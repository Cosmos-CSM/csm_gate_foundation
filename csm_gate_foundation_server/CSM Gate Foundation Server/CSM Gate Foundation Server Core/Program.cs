using CSM_Server_Core.Core.Models;
using CSM_Server_Core.Core.Utils;

namespace CSM_Gate_Foundation_Server;

internal class Program {
    static void Main(string[] args) {
        ServerUtils.Start(
                "CSMS",
                async (WebApplicationBuilder appBuilder, ServerSettings serverSettings) => {

                },
                async (WebApplication webApp, ServerSettings serverSettings) => {

                }
            );
    }
}