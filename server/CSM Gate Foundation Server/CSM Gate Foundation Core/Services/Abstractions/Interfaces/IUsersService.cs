using CSM_Security_Database_Core.Entities;

using CSM_Server_Core.Abstractions.Interfaces;

namespace CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

/// <summary>
///     Represents a <see cref="User"/> scoped service operations.
/// </summary>
public interface IUsersService
    : IService<User> {

    /// <summary>
    ///     Reads the <see cref="User"/> data with the given <paramref name="username"/>.
    /// </summary>
    /// <param name="username">
    ///     User's identity.
    /// </param>
    /// <returns>
    ///     <see cref="User"/> data.
    /// </returns>
    Task<User> Read(string username);

    /// <summary>
    ///     Reads the effective <see cref="Permit"/> collection the given <see cref="User"/>'s <paramref name="id"/> have access to.
    /// </summary>
    /// <param name="id">
    ///     Data storages <see cref="CSM_Database_Core.Entities.Abstractions.Interfaces.IEntity"/> identifier value.
    /// </param>
    /// <returns>
    ///     Effective user <see cref="Permit"/> collection data.
    /// </returns>
    Task<Permit[]> ReadPermits(long id);
}
