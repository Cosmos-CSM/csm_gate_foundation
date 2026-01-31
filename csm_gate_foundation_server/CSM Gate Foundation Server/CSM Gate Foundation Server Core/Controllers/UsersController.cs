using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

using CSM_Security_Database_Core.Entities;

using CSM_Server_Core.Abstractions.Bases;
using CSM_Server_Core.Core.Attributes;

using Microsoft.AspNetCore.Mvc;

namespace CSM_Gate_Foundation_Server.Controllers;

/// <summary>
///     
/// </summary>
[ApiController, Route("[Controller]/[Action]"), Feature("Users")]
public class UsersController
    : EntityControllerBase<IUsersService, User> {


    /// <summary>
    /// 
    /// </summary>
    /// <param name="usersService"></param>
    public UsersController(IUsersService usersService)
        : base(usersService) {
    }
}
