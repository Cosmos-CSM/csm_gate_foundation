using System.Text.Json.Serialization;

using CSM_Security_Database_Core.Entities;

namespace CSM_Gate_Foundation_Core.Core.Models;

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
    ///     Stores the permits the <see cref="User"/> has access to, only for the scoped <see cref="Solution"/> this session is related.
    /// </summary>
    public required Permit[] Permits { get; set; }

    /// <summary>
    ///     <see cref="CSM_Security_Database_Core.Entities.User"/> data.
    /// </summary>
    [JsonIgnore]
    public User User { get; init; } = default!;
}