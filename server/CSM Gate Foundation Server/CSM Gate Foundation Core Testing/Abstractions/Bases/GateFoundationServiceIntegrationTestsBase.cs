using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Security_Database_Core;

using CSM_Server_Core.Abstractions.Interfaces;

using CSM_Server_Core_Testing.Abstractions.Bases;

namespace CSM_Gate_Foundation_Core_Testing.Abstractions.Bases;

/// <summary>
///     Represents an integration tests class for {Gate Foundation} service.
/// </summary>
/// <typeparam name="TService">
///     Type of the <see cref="IService"/> tested.
/// </typeparam>
/// <typeparam name="TEntity">
///     Type of the <see cref="IEntity"/>
/// </typeparam>
public abstract class GateFoundationServiceIntegrationTestsBase<TService, TEntity>
    : ServiceIntegrationTestsBase<TService, TEntity>
    where TService : IService<TEntity>
    where TEntity : class, IEntity, new() {


    public GateFoundationServiceIntegrationTestsBase()
        : base(
                [
                    () => new SecurityDatabase()
                ]
            ) {
    }
}
