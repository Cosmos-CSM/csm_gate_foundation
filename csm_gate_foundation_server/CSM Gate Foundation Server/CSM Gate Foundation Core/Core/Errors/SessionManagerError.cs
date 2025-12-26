using CSM_Foundation_Core.Errors.Abstractions.Bases;

namespace CSM_Gate_Foundation_Core.Core.Errors;

/// <summary>
///     <see cref="SessionManagerError"/> error events.
/// </summary>
public enum AuthErrorEvents {
    /// <summary>
    ///     When the user wasn't found in the system.
    /// </summary>
    UNFOUND_USR,

    /// <summary>
    ///     When the user password is incorrect.
    /// </summary>
    WRONG_PWD,

    /// <summary>
    ///     When the global solution access is disabled.
    /// </summary>
    DIS_SOLUTION,

    /// <summary>
    ///     When the auth process finds out the user credentials doesn't have auth level to access requested feature.
    /// </summary>
    UNAUTHORIZED,

    /// <summary>
    ///     When the <see cref="IAuthManager.Auth(Services.Records.AuthInput)"/> requires the request context scope but is not being given.
    /// </summary>
    NO_REQ_CONTEXT,

    /// <summary>
    ///     When a being handled token is not found on internal references.
    /// </summary>
    UNK_TOKEN,
}

/// <summary>
///     Represents an error object for <see cref="Managers.Abstractions.Interfaces.ISessionsManager"/> operations.
/// </summary>
public class SessionManagerError
    : ErrorBase<AuthErrorEvents> {

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    /// <param name="reason">
    ///     Specifies the <see cref="AuthErrorEvents"/> that caused the exception.
    /// </param>
    /// <param name="system">
    ///     Indicates if the cause was due to a unrecognized system exception was caugth.
    /// </param>
    public SessionManagerError(AuthErrorEvents reason, Exception? system = null)
        : base($"Session Manager error", reason, system) {
    }

    protected override Dictionary<AuthErrorEvents, string> BuildAdviseContext() {
        return new Dictionary<AuthErrorEvents, string> {
            { AuthErrorEvents.UNFOUND_USR, $"Identity not found" },
            { AuthErrorEvents.WRONG_PWD, $"Wrong password" },
            { AuthErrorEvents.DIS_SOLUTION, $"The solution is currently disabled" },
            { AuthErrorEvents.UNAUTHORIZED, $"Unathurozied feature access" },
            { AuthErrorEvents.UNK_TOKEN, $"Unknown session" },
        };
    }
}