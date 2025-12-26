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
    ///     Creates a new instance.
    /// </summary>
    /// <param name="depot">
    ///     <see cref="User"/> based data depot dependency.
    /// </param>
    public UsersService(IUsersDepot depot)
        : base(depot) {
    }

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

    public Task<Permit[]> ReadPermits(long id) {
        return _depot.GetPermits(id);
    }
}
