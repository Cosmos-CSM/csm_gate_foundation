using CSM_Gate_Foundation_Core.Core.Models;
using CSM_Gate_Foundation_Core.Services.Models.Inputs;

using CSM_Server_Core.Abstractions.Interfaces;

namespace CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

/// <summary>
///     Represents a server authentication service operations.
/// </summary>
public interface IAuthService
    : IService {

    /// <summary>
    ///     Authenticates a given credentials subscribing the session into the current <see cref="AuthManager"/> context.
    /// </summary>
    /// <param name="input">
    ///     Authentication credentials.
    /// </param>
    /// <returns>
    ///     The <see cref="SessionData"/> information referencing the given <see cref="AuthInput"/> session.
    /// </returns>
    Task<SessionData> Authenticate(AuthInput input);
}
