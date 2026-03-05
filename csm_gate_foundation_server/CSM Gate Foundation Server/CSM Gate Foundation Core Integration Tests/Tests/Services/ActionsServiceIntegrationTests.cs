using CSM_Database_Core.Depots.Models;

using CSM_Gate_Foundation_Core.Services;

using CSM_Security_Database_Core;
using CSM_Security_Database_Core.Depots;
using CSM_Security_Database_Core.Entities;

using CSM_Security_Database_Testing.Utils;

using CSM_Server_Core_Testing.Abstractions.Bases;

using Action = CSM_Security_Database_Core.Entities.Action;

namespace CSM_Gate_Foundation_Core_Integration_Tests.Tests.Services;

/// <summary>
///     Integration tests class for <see cref="ActionsService"/>
/// </summary>
public class ActionsServiceIntegrationTests
    : ServiceIntegrationTestsBase<ActionsService, Action> {


    public ActionsServiceIntegrationTests()
        : base(
                () => new SecurityDatabase()
            ) {

    }

    protected override Action DraftEntity(string entropy) {
        return DraftUtils.Action();
    }

    protected override ActionsService ServiceFactory() {
        SecurityDatabase database = new();

        return new ActionsService(
                new ActionsDepot(
                        database,
                        Disposer
                    )
            );
    }

    public override async Task Update_SingleEntity_UpdatesEntity() {
        // Expectation
        Action expAction = Store(RunEntityDraft());
        Permit expPermit = DraftUtils.Permit();

        Store(expPermit.Action);
        Store(expPermit.Feature);
        Store(expPermit.Solution);

        expPermit = Store(expPermit);

        string? oldDescription = expAction.Description;
        expAction.Description = "New description";
        expAction.Permits = [
                expPermit
            ];

        // Acting
        UpdateOutput<Action> actOutput = await _service.Update(
                new UpdateInput<Action> {
                    Entity = expAction,
                }
            );

        // Asserting
        Assert.NotNull(actOutput.Original);
        Assert.Equal(oldDescription, actOutput.Original.Description);
        Assert.NotEqual(actOutput.Original.Description, actOutput.Updated.Description);
        Assert.NotEmpty(actOutput.Updated.Permits);
        Assert.Contains(actOutput.Updated.Permits, actUpdatedPermit => actUpdatedPermit.Id == expPermit.Id);
    }
}
