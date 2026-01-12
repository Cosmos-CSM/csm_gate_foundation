using CSM_Database_Core.Depots.Models;

using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

using CSM_Security_Database_Core.Entities;

using CSM_Server_Core.Core.Attributes;

using Microsoft.AspNetCore.Mvc;

namespace CSM_Gate_Foundation_Server.Controllers;

[ApiController, Route("[Controller]/[Action]"), Feature("Users")]
public class UsersController
    : ControllerBase {

    readonly IUsersService _usersService;

    public UsersController(IUsersService usersService) {
        _usersService = usersService;
    }

    [HttpPost, Action("View")]
    public async Task<IActionResult> View(ViewInput<User> input) {
        return Ok(
                await _usersService.View(
                        new QueryInput<User, ViewInput<User>> {
                            Parameters = input,
                        }
                    )
            );
    }
}
