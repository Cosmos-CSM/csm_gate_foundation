using CSM_Gate_Foundation_Core.Managers;
using CSM_Gate_Foundation_Core.Managers.Abstractions.Interfaces;
using CSM_Gate_Foundation_Core.Services;
using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

using CSM_Security_Database_Core.Core;

using CSM_Server_Core.Core.Models;
using CSM_Server_Core.Core.Utils;
using CSM_Server_Core.Middlewares;

using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;

namespace CSM_Gate_Foundation_Core;

/// <summary>
///     Represents { Gate Foundation Core } initializer provider. 
/// </summary>
public static class GateFoundationCore {

    /// <summary>
    ///     Starts { Gate Foundation Core } server.
    /// </summary>
    /// <param name="sign">
    ///     [CSM] framework solution signature identifier.
    /// </param>
    /// <param name="args">
    ///     System application arguments.
    /// </param>
    /// <param name="buildApp">
    ///     Customization application builder process.
    /// </param>
    /// <param name="configureApp">
    ///     Customization application configuration process.
    /// </param>
    public static void Start(string[] args, Action<WebApplicationBuilder>? buildApp = null, Action<WebApplication, ServerSettings>? configureApp = null, string sign = "CSMS") {
        ServerUtils.Start(
                sign,
                new FramingMiddleware(
                        async (services) => {

                        },
                        async (services) => {

                        },
                        async (services) => {

                        }
                    ),
                async (appBuilder, serverSettings) => {
                    IServiceCollection services = appBuilder.Services;

                    // --> Singleton dependencies injected.
                    services.AddSingleton<ISessionsManager, SessionsManager>();
                    services.AddSingleton<CSM_Server_Core.Abstractions.Interfaces.ISessionManager>(
                            sProvier => sProvier.GetRequiredService<ISessionsManager>()
                        );

                    // --> Security Database Service injection.
                    services.AddSecurityDatabaseServices();


                    // --> Injecting Gate Foundation services.
                    services.AddScoped<IAuthService, AuthService>();
                    services.AddScoped<IUsersService, UsersService>();


                    // --> Adding package controllers.
                    services
                        .AddControllers()
                        .AddApplicationPart(
                            typeof(GateFoundationCore).Assembly
                        );

                    buildApp?.Invoke(appBuilder);
                },
                async (webApp, serverSettings) => {
                    configureApp?.Invoke(webApp, serverSettings);
                }
            );
    }

}
