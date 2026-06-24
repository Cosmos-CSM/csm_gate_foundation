using CSM_Database_Core.Depots.Models;
using CSM_Database_Core.Depots.Models.Structs;

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

    /// <method>
    ///     <see cref=""/>
    /// </method>
    /// <result>
    ///     <see cref="Action"/> entity correctly gets updated relations and properties.
    /// </result>
    public override async Task Update_SingleEntity_UpdatesEntity() {
        //Setting up
        Action expAction = await Store(RunEntityDraft());
        Permit expPermit = DraftUtils.Permit();

        await Store(expPermit.Action);
        await Store(expPermit.Feature);
        await Store(expPermit.Solution);

        expPermit = await Store(expPermit);

        string? oldDescription = expAction.Description;
        expAction.Description = "New description";

        //Acting
        UpdateOutput<Action> actOutput = await _service.Update(
                new UpdateInput<Action> {
                    Entity = expAction,
                    Relations = new Dictionary<string, IDictionary<string, RelationUpdate[]>>{
                        {
                            nameof(Action.Permits),
                            new Dictionary<string, RelationUpdate[]> {
                                {
                                    string.Empty,
                                    [
                                            new RelationUpdate  {
                                                Action = RelationUpdateAction.ADD,
                                                Entity = expPermit,
                                            },
                                        ]
                                }
                            }
                        },
                    },
                }
            );

        //Asserting
        Assert.NotNull(actOutput.Original);
        Assert.Equal(oldDescription, actOutput.Original.Description);
        Assert.NotEqual(actOutput.Original.Description, actOutput.Updated.Description);
        Assert.NotEmpty(actOutput.Updated.Permits);
        Assert.Contains(actOutput.Updated.Permits, actUpdatedPermit => actUpdatedPermit.Id == expPermit.Id);
    }
}
