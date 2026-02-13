using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

using CSM_Security_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Security_Database_Core.Entities;

using CSM_Server_Core.Abstractions.Bases;

namespace CSM_Gate_Foundation_Core.Services;

/// <inheritdoc cref="IPermitsService"/>
public class PermitsService
    : ServiceBase<Permit, IPermitsDepot>, IPermitsService {


    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    /// <param name="depot">
    ///     Depot dependency.
    /// </param>
    public PermitsService(IPermitsDepot depot) : base(depot) {
    }
}
