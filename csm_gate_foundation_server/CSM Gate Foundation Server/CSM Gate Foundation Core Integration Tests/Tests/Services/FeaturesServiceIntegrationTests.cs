using CSM_Database_Core.Depots.Models;

using CSM_Gate_Foundation_Core.Services;
using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

using CSM_Security_Database_Core;
using CSM_Security_Database_Core.Depots;
using CSM_Security_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Security_Database_Core.Entities;

using CSM_Security_Database_Testing.Utils;

using CSM_Server_Core_Testing.Abstractions.Bases;

namespace CSM_Gate_Foundation_Core_Integration_Tests.Tests.Services;


/// <summary>
///     Integration tests class for <see cref="FeaturesService"/>
/// </summary>
public class FeaturesServiceIntegrationTests
    : ServiceIntegrationTestsBase<IFeaturesService, Feature> {

    public FeaturesServiceIntegrationTests()
        : base(
                [
                    () => new SecurityDatabase()
                ]
            ) { }


    protected override IFeaturesService ServiceFactory() {
        SecurityDatabase securityDatabase = new();

        IFeaturesDepot featuresDepot = new FeaturesDepot(securityDatabase, Disposer);

        return new FeaturesService(featuresDepot);
    }

    protected override Feature DraftEntity(string entropy) {
        return DraftUtils.Feature();
    }

    public override async Task Update_SingleEntity_UpdatesEntity() {
        // Setting
        Feature feature = Store(RunEntityDraft());

        // Expectations
        string? oldDescription = feature.Description;
        Permit expPermit = Store(DraftUtils.Permit());

        // Acting
        feature.Description = "New description random";
        feature.Permits.Add(expPermit);
        UpdateOutput<Feature> actOutput = await _service.Update(
                new UpdateInput<Feature> {
                    Entity = feature,
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
