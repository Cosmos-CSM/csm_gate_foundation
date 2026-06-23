using CSM_Gate_Foundation_Core.Core.Models;
using CSM_Gate_Foundation_Core.Managers;
using CSM_Gate_Foundation_Core.Managers.Abstractions.Interfaces;
using CSM_Gate_Foundation_Core.Services;
using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;
using CSM_Gate_Foundation_Core.Services.Models.Inputs;

using CSM_Security_Database_Core;
using CSM_Security_Database_Core.Depots;
using CSM_Security_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Security_Database_Core.Entities;

using CSM_Security_Database_Testing.Utils;

using CSM_Server_Core_Testing.Abstractions.Bases;

using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;

namespace CSM_Gate_Foundation_Core_Integration_Tests.Tests.Services;

/// <summary>
///     Tests class for <see cref="AuthService"/>
/// </summary>
public class AuthServiceIntegrationTests
    : ServiceIntegrationTestsBase<IAuthService> {

    protected override IAuthService ServiceFactory() {
        HttpContextAccessor contextAccessor = new() {
            HttpContext = new DefaultHttpContext()
        };

        DefaultServiceProviderFactory serviceProvider = new();
        IServiceCollection services = new ServiceCollection();


        SecurityDatabase securityDatabase = new();
        IUsersDepot usersDepot = new UsersDepot(securityDatabase, Disposer);
        IUserInfosDepot userInfosDepot = new UserInfosDepot(securityDatabase, Disposer);

        services.AddScoped<IUsersService, UsersService>(
                (_) => new UsersService(
                        usersDepot,
                        userInfosDepot
                    )
            );

        contextAccessor.HttpContext.RequestServices = serviceProvider.CreateServiceProvider(services);

        ISessionsManager sessionManager = new SessionsManager(contextAccessor);

        return new AuthService(sessionManager);
    }

    public AuthServiceIntegrationTests()
        : base(
                [
                    () =>  new SecurityDatabase()
                ]
            ) {
    }

    /// <summary>
    ///     Tests that <see cref="AuthService.Authenticate(AuthInput)"/> successes.
    /// </summary>
    [Fact]
    public async Task Authenticate_Success() {
        // Setting
        UserInfo userInfo = await Store(
                DraftUtils.UserInfo()
            );
        User user = await Store(
                DraftUtils.User(
                        new User {
                            IsMaster = true,
                            UserInfo = userInfo
                        }
                    )
            );

        // Acting
        SessionData actOutput = await _service.Authenticate(
                new AuthInput {
                    Sign = "",
                    Password = user.Password,
                    Username = user.Username,
                }
            );

        // Asserting
        Assert.NotEmpty(actOutput.Token.ToString());
        Assert.Equal(user.Id, actOutput.User.Id);
        Assert.Equal(userInfo.Id, actOutput.UserInfo.Id);
    }
}
