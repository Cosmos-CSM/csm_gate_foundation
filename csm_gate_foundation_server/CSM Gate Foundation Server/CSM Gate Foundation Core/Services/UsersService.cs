using CSM_Database_Core.Core.Errors;
using CSM_Database_Core.Depots.Models;

using CSM_Gate_Foundation_Core.Core.Errors;
using CSM_Gate_Foundation_Core.Core.Models;
using CSM_Gate_Foundation_Core.Managers;
using CSM_Gate_Foundation_Core.Managers.Abstractions.Interfaces;
using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

using CSM_Security_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Security_Database_Core.Entities;

using CSM_Server_Core.Abstractions.Bases;
using CSM_Server_Core.Abstractions.Interfaces;

using Microsoft.EntityFrameworkCore;

namespace CSM_Gate_Foundation_Core.Services;

/// <inheritdoc cref="IUsersService"/>
public class UsersService
    : ServiceBase<User, IUsersDepot>, IUsersService {

    /// <summary>
    ///     <see cref="UserInfo"/> entity depot.
    /// </summary>
    readonly IUserInfosDepot _userInfosDepot;

    /// <summary>
    ///     <see cref="SessionsManager"/> User session manager.
    /// </summary>
    readonly ISessionsManager _sessionsManager;

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    /// <param name="depot">
    ///     <see cref="User"/> depot dependency.
    /// </param>
    /// <param name="sessionManager"> session manager dependency</param>
    /// <param name="userInfosDepot">
    ///     <see cref="UserInfo"/> depot dependency.
    /// </param>
    public UsersService(IUsersDepot depot, ISessionsManager sessionManager, IUserInfosDepot userInfosDepot)
        : base(depot) {
        _userInfosDepot = userInfosDepot;
        _sessionsManager = sessionManager;
    }

    /// <inheritdoc/>
    public async Task<User> Read(string username) {
        BatchOperationOutput<User> queryOutput = await _depot.Read(
                new QueryInput<User, FilterQueryInput<User>> {
                    Parameters = new FilterQueryInput<User> {
                        Behavior = FilteringBehaviors.First,
                        Filter = user => user.Username == username
                    }
                }
            );

        if (queryOutput.Failed)
            throw queryOutput.Failures[0].Exception!;

        if (queryOutput.SuccessesCount <= 0)
            throw new ServiceError<User>(ServiceErrorEvents.READ_UNFOUND);

        return queryOutput.Successes[0];
    }

    /// <inheritdoc/>
    public Task<Permit[]> ReadPermits(long id) {
        return _depot.GetPermits(id);
    }
    /// <summary>
    /// Get the current user's vendors. If the user is a master user, it will return all enabled vendors. 
    /// Otherwise, it will return only the vendors associated with the user.
    /// </summary>
    /// <returns></returns>
    /// <exception cref="DepotError{User}"></exception>
    public async Task<ViewOutput<Vendor>> GetVendors() {
        SessionData sessionData = await _sessionsManager.Get();
        long accountId = sessionData.User.Id;

        BatchOperationOutput<User> readOutput = await _depot.Read(
                new QueryInput<User, FilterQueryInput<User>> {
                    Parameters = new FilterQueryInput<User> {
                        Behavior = FilteringBehaviors.First,
                        Filter = (record) => record.Id == accountId,
                    },
                    PostProcessor = (query) => {
                        return query
                            .Include(a => a.Vendors);
                    },
                }
            );

        if (readOutput.SuccessesCount <= 0)
            throw new DepotError<User>(DepotErrorEvents.UNFOUND);


        if (readOutput.Failed && readOutput.Failures.Length != 0 && readOutput.Failures[0].Exception != null)
            throw readOutput.Failures[0].Exception!;



        if (readOutput.SuccessesCount > 0 && readOutput.Successes[0].IsMaster) {
            ViewOutput<Vendor> output = new() {
                Entities = [.. readOutput.Successes[0].Vendors],
                Pages = 1,
                Page = 1,
                Count = readOutput.Successes[0].Vendors.Count,
                Timestamp = DateTime.UtcNow,
            };
        }

        // Vendor[] vendors = [.. _database.Vendors.Where(v => v.IsEnabled)];
        Vendor[] vendors = [];
        ViewOutput<Vendor> wildCardOutput = new() {
            Entities = vendors,
            Pages = 1,
            Page = 1,
            Count = vendors.Length,
            Timestamp = DateTime.UtcNow,
        };

        return wildCardOutput;

    }

    /// <inheritdoc/>
    public override async Task<BatchOperationOutput<User>> Create(User[] entities, bool sync = false) {
        List<UserInfo> infosToCreate = [];
        foreach (User user in entities) {
            if (user.UserInfo.Id == 0)
                infosToCreate.Add(user.UserInfo);
        }

        await _userInfosDepot.Create(infosToCreate, sync);

        return await base.Create(entities, sync);
    }

    /// <inheritdoc/>
    public override async Task<UpdateOutput<User>> Update(UpdateInput<User> input) {
        UserInfo userInfo = input.Entity.UserInfo;
        UpdateOutput<UserInfo> output = await _userInfosDepot.Update(
                    new QueryInput<UserInfo, UpdateInput<UserInfo>> {
                        Parameters = new UpdateInput<UserInfo> {
                            Entity = userInfo,
                            Create = input.Create,
                        }
                    }
                );

        input.Entity.UserInfo = output.Updated;
        return await base.Update(input);
    }
}
