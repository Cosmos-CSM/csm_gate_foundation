using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;
using CSM_Gate_Foundation_Core.Services.Models.Inputs;

using Microsoft.AspNetCore.Mvc;

namespace CSM_Gate_Foundation_Server.Controllers;

/// <summary>
///     Controller class for authorization services endpoints.
/// </summary>
[ApiController, Route("[Controller]/[Action]")]
public class AuthController
    : ControllerBase {


    readonly IAuthService _authService;

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    public AuthController(IAuthService authService) {
        _authService = authService;
    }

    [HttpPost]
    public async Task<IActionResult> Authenticate(AuthInput input) {
        return Ok(
                await _authService.Authenticate(input)
            );
    }
}
