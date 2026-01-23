using CSM_Database_Core.Depots.Models;

using CSM_Gate_Foundation_Core.Core.Errors;
using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

using CSM_Security_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Security_Database_Core.Entities;

using CSM_Server_Core.Abstractions.Bases;

namespace CSM_Gate_Foundation_Core.Services;

/// <inheritdoc cref="IUsersService"/>
public class UsersService
    : ServiceBase<User, IUsersDepot>, IUsersService {

    /// <summary>
    ///     <see cref="UserInfo"/> entity depot.
    /// </summary>
    readonly IUserInfosDepot _userInfosDepot;

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    /// <param name="depot">
    ///     <see cref="User"/> depot dependency.
    /// </param>
    /// <param name="userInfosDepot">
    ///     <see cref="UserInfo"/> depot dependency.
    /// </param>
    public UsersService(IUsersDepot depot, IUserInfosDepot userInfosDepot)
        : base(depot) {
        _userInfosDepot = userInfosDepot;
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

    /// <inheritdoc/>
    public override async Task<BatchOperationOutput<User>> Create(User[] entities, bool sync = false) {
        List<UserInfo> infosToCreate = [];
        foreach (User user in entities) {
            if (user.UserInfo.Id == 0)
                infosToCreate.Add(user.UserInfo);
        }

        await _userInfosDepot.Create(infosToCreate);

        return await base.Create(entities, sync);
    }

    /// <inheritdoc/>
    public override async Task<UpdateOutput<User>> Update(UpdateInput<User> input) {
        UserInfo userInfo = input.Entity.UserInfo;
        if (userInfo.Id != 0) {
            UpdateOutput<UserInfo> output = await _userInfosDepot.Update(
                    new QueryInput<UserInfo, UpdateInput<UserInfo>> {
                        Parameters = new UpdateInput<UserInfo> {
                            Entity = userInfo,
                            Create = input.Create,
                        }
                    }
                );

            userInfo = output.Updated;
        }

        input.Entity.UserInfo = userInfo;
        return await base.Update(input);
    }
}
