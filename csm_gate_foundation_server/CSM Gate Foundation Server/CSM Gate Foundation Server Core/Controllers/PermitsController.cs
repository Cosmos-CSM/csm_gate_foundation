using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

using CSM_Security_Database_Core.Entities;

using CSM_Server_Core.Abstractions.Bases;
using CSM_Server_Core.Core.Attributes;

using Microsoft.AspNetCore.Mvc;

namespace CSM_Gate_Foundation_Server_Core.Controllers;

/// <summary>
/// 
/// </summary>
[ApiController, Route("[Controller]/[Action]"), Feature("Permits")]
public class PermitsController
    : EntityControllerBase<IPermitsService, Permit> {

    /// <summary>
    ///     
    /// </summary>
    /// <param name="service"></param>
    public PermitsController(IPermitsService service)
        : base(service) {
    }
}
