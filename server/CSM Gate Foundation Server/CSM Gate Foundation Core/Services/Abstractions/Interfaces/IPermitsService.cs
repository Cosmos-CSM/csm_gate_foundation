using CSM_Security_Database_Core.Entities;

using CSM_Server_Core.Abstractions.Interfaces;

namespace CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

/// <summary>
///     Represents a <see cref="Permit"/> scoped operations service.
/// </summary>
public interface IPermitsService
    : IService<Permit> {
}
