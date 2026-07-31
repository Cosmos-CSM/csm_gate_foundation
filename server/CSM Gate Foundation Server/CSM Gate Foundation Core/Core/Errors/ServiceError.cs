
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Errors.Abstractions.Bases;

namespace CSM_Gate_Foundation_Core.Core.Errors;

/// <summary>
///     Stores <see cref="ServiceError"/> events.
/// </summary>
public enum ServiceErrorEvents {

    /// <summary>
    ///     Event used when at a [Read] operation the data is not found.
    /// </summary>
    READ_UNFOUND,
}


/// <summary>
///     Represents an error object data for <see cref="CSM_Server_Core.Abstractions.Interfaces.IService"/> operation errors.
/// </summary>
public class ServiceError
    : ErrorBase<ServiceErrorEvents> {

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    /// <param name="event">
    ///     Error event trigger.
    /// </param>
    /// <param name="exception">
    ///     System exception caught.
    /// </param>
    public ServiceError(ServiceErrorEvents @event, Exception? exception = null)
        : base("Service error", @event, exception) {
    }
}

/// <summary>
///     Represents an <see cref="IEntity"/> scoped error object data for <see cref="CSM_Server_Core.Abstractions.Interfaces.IService"/> operation errors.
/// </summary>
public class ServiceError<TEntity>
    : ErrorBase<ServiceErrorEvents>
    where TEntity : class, IEntity {

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    /// <param name="event">
    ///     Error event trigger.
    /// </param>
    /// <param name="exception">
    ///     System exception caught.
    /// </param>
    public ServiceError(ServiceErrorEvents @event, Exception? exception = null)
        : base("Service error", @event, exception) {
    }
}
