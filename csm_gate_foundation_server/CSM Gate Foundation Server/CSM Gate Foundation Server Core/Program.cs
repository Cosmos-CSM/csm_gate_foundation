using CSM_Gate_Foundation_Core.Managers;
using CSM_Gate_Foundation_Core.Managers.Abstractions.Interfaces;
using CSM_Gate_Foundation_Core.Services;
using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

using CSM_Security_Database_Core.Core;

using CSM_Server_Core.Core.Models;
using CSM_Server_Core.Core.Utils;
using CSM_Server_Core.Middlewares;

namespace CSM_Gate_Foundation_Server;

internal class Program {
    static void Main(string[] args) {
        ServerUtils.Start(
                "CSMS",
                new FramingMiddleware(
                        async (services) => {

                        },
                        async (services) => {

                        },
                        async (services) => {

                        }
                    ),
                async (WebApplicationBuilder appBuilder, ServerSettings serverSettings) => {
                    IServiceCollection services = appBuilder.Services;

                    // --> Singleton dependencies injected.
                    services.AddSingleton<ISessionsManager, SessionsManager>();

                    // --> Security Database Service injection.
                    services.AddSecurityDatabaseServices();


                    // --> Injecting Gate Foundation services.
                    services.AddScoped<IAuthService, AuthService>();
                    services.AddScoped<IUsersService, UsersService>();
                },
                async (WebApplication webApp, ServerSettings serverSettings) => {

                }
            );
    }
}