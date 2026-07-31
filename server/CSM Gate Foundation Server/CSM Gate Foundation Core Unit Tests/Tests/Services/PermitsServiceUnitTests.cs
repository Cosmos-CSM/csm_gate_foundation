using CSM_Gate_Foundation_Core.Services;

using CSM_Security_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Security_Database_Core.Entities;

using CSM_Server_Core_Testing.Abstractions.Bases;

namespace CSM_Gate_Foundation_Core_Unit_Tests.Tests.Services;

/// <summary>
///     Unit tests class for <see cref="PermitsService"/>.
/// </summary>
public class PermitsServiceUnitTests
    : ServiceUnitTestsBase<Permit, IPermitsDepot, PermitsService> {

    protected override PermitsService ServiceFactory(IPermitsDepot depotMock) {
        return new PermitsService(depotMock);
    }
}
