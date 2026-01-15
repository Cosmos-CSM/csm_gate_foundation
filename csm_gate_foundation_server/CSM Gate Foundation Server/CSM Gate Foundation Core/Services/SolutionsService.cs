using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;

using CSM_Security_Database_Core.Depots;
using CSM_Security_Database_Core.Entities;

using CSM_Server_Core.Abstractions.Bases;

namespace CSM_Gate_Foundation_Core.Services;

/// <inheritdoc cref="ISolutionsService"/>
public class SolutionsService
    : ServiceBase<Solution, SolutionsDepot>, ISolutionsService {

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    /// <param name="depot">
    ///     Depot dependency.
    /// </param>
    public SolutionsService(SolutionsDepot depot)
        : base(depot) {
    }
}
