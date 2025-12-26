using CSM_Gate_Foundation_Core.Managers.Abstractions.Interfaces;
using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;
using CSM_Gate_Foundation_Core.Services.Models.Inputs;

using TWS_Customer.Managers.Session;

namespace CSM_Gate_Foundation_Core.Services;

/// <inheritdoc cref="IAuthService"/>
public class AuthService
    : IAuthService {

    /// <summary>
    ///     Manager for session handling and context.
    /// </summary>
    readonly ISessionsManager _sessionsManager;

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    /// <param name="sessionManager"></param>
    public AuthService(ISessionsManager sessionManager) {
        _sessionsManager = sessionManager;
    }

    public async Task<SessionData> Authenticate(AuthInput input) {
        return await _sessionsManager.Auth(input);
    }
}
