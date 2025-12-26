using System.Text.Json.Serialization;

using CSM_Security_Database_Core.Entities;

namespace TWS_Customer.Managers.Session;

/// <summary>
///     Represents a server user session data.
/// </summary>
public record SessionData {

    /// <summary>
    ///     Unique session token.
    /// </summary>
    public required Guid Token { get; set; }

    /// <summary>
    ///     Whether the current session has free master access.
    /// </summary>
    public required bool Wildcard { get; set; }

    /// <summary>
    ///     When this session usage gets expired.
    /// </summary>
    public required DateTime Expiration { get; set; }

    /// <summary>
    ///     <see cref="CSM_Security_Database_Core.Entities.UserInfo"/> data,
    /// </summary>
    public required UserInfo UserInfo { get; set; }

    /// <summary>
    ///     <see cref="CSM_Security_Database_Core.Entities.User"> data
    /// </summary>
    [JsonIgnore]
    public User User { get; init; } = default!;
}