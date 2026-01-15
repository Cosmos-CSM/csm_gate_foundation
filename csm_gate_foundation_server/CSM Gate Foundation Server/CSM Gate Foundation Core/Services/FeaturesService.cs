using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

using CSM_Security_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Security_Database_Core.Entities;

using CSM_Server_Core.Abstractions.Bases;

namespace CSM_Gate_Foundation_Core.Services;

/// <inheritdoc cref="IFeaturesService"/>.
public class FeaturesService
    : ServiceBase<Feature, IFeaturesDepot>, IFeaturesService {


    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    /// <param name="depot">
    ///     Depot dependency.
    /// </param>
    public FeaturesService(IFeaturesDepot depot) : base(depot) {
    }
}
