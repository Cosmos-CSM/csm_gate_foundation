using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

using CSM_Security_Database_Core.Depots.Abstractions.Interfaces;

using CSM_Server_Core.Abstractions.Bases;

namespace CSM_Gate_Foundation_Core.Services;

using ActionEntity = CSM_Security_Database_Core.Entities.Action;

/// <inheritdoc cref="IActionsService"/>
public class ActionsService
    : ServiceBase<ActionEntity, IActionsDepot>, IActionsService {

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    /// <param name="depot">
    ///     Depot dependency.
    /// </param>
    public ActionsService(IActionsDepot depot)
        : base(depot) {
    }


}
