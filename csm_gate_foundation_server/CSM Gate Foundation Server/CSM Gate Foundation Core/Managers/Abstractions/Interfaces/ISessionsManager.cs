using CSM_Gate_Foundation_Core.Core.Models;
using CSM_Gate_Foundation_Core.Services.Models.Inputs;

namespace CSM_Gate_Foundation_Core.Managers.Abstractions.Interfaces;

/// <summary>
///     Represents a server sessions manager.
/// </summary>
public interface ISessionsManager {

    /// <summary>
    ///     Authenticates an user from the given <paramref name="authInput"/> information.
    /// </summary>
    /// <param name="authInput">
    ///     Input parameters.
    /// </param>
    /// <returns>
    ///     The correct authenticated <see cref="SessionData"/> information.
    /// </returns>
    public Task<SessionData> Auth(AuthInput authInput);

    /// <summary>
    ///     Gets the <see cref="SessionData"/> from the transaction user. 
    /// </summary>
    /// <returns>
    ///     The found <see cref="SessionData"/> information.
    /// </returns>
    public Task<SessionData> Get();
}