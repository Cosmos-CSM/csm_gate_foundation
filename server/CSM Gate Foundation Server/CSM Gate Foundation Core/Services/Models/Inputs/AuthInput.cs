namespace CSM_Gate_Foundation_Core.Services.Models.Inputs;

/// <summary>
///     Represents an authentication request data input.
/// </summary>
public record AuthInput {

    /// <summary>
    ///     Solution signature to authenticate.
    /// </summary>
    public required string Sign { get; set; }

    /// <summary>
    ///     User identity.
    /// </summary>
    public required string Username { get; init; }

    /// <summary>
    ///     User secret password.
    /// </summary>
    public required byte[] Password { get; init; }
}
