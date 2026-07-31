using CSM_Gate_Foundation_Core.Services;
using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

using CSM_Security_Database_Core.Depots.Abstractions.Interfaces;

using CSM_Server_Core_Testing.Abstractions.Bases;

using Action = CSM_Security_Database_Core.Entities.Action;

namespace CSM_Gate_Foundation_Core_Unit_Tests.Tests.Services;

/// <summary>
///     Tests class for <see cref="IActionsService"/>
/// </summary>
public class ActionsServiceUnitTests
     : ServiceUnitTestsBase<Action, IActionsDepot, ActionsService> {

    protected override ActionsService ServiceFactory(IActionsDepot depotMock) {
        return new ActionsService(depotMock);
    }
}
