using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

using CSM_Security_Database_Core.Entities;

using CSM_Server_Core.Abstractions.Bases;
using CSM_Server_Core.Core.Attributes;

using Microsoft.AspNetCore.Mvc;

namespace CSM_Gate_Foundation_Server_Core.Controllers;

/// <summary>
/// 
/// </summary>
[ApiController, Route("[Controller]/[Action]"), Feature("Features")]
public class FeaturesController
    : EntityControllerBase<IFeaturesService, Feature> {

    /// <summary>
    ///     
    /// </summary>
    /// <param name="service"></param>
    public FeaturesController(IFeaturesService service)
        : base(service) {
    }
}
