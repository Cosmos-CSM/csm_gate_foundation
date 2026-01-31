using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

using CSM_Security_Database_Core.Entities;

using CSM_Server_Core.Abstractions.Bases;
using CSM_Server_Core.Core.Attributes;

namespace CSM_Gate_Foundation_Server_Core.Controllers;

/// <summary>
/// 
/// </summary>
[Feature("Actions")]
public class ActionsController
    : EntityControllerBase<IActionsService, CSM_Security_Database_Core.Entities.Action> {

    /// <summary>
    ///     
    /// </summary>
    /// <param name="service"></param>
    public ActionsController(IActionsService service)
        : base(service) {
    }
}
