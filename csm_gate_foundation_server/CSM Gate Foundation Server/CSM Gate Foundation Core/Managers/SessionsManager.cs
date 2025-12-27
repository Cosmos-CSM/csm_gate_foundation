using System.Collections.Concurrent;

using CSM_Gate_Foundation_Core.Core.Errors;
using CSM_Gate_Foundation_Core.Core.Models;
using CSM_Gate_Foundation_Core.Managers.Abstractions.Interfaces;
using CSM_Gate_Foundation_Core.Services.Abstractions.Interfaces;
using CSM_Gate_Foundation_Core.Services.Models.Inputs;

using CSM_Security_Database_Core.Entities;

using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Primitives;

using SessionsBag = System.Collections.Concurrent.ConcurrentDictionary<System.Guid, (CSM_Gate_Foundation_Core.Services.Models.Inputs.AuthInput Credentials, System.DateTime Expiration)>;
using SessionScope = (CSM_Gate_Foundation_Core.Services.Models.Inputs.AuthInput authInput, System.DateTime expiration);

namespace CSM_Gate_Foundation_Core.Managers;

/// <inheritdoc cref="ISessionsManager"/>
public sealed class SessionsManager
    : ISessionsManager {

    /// <summary>
    ///     Expiration time aggregation for token refreshing, this value is aggregated to the current expirations to get a final expiration timestamp.
    /// </summary>
    readonly TimeSpan _expirationGap = TimeSpan.FromHours(6);

    /// <summary>
    ///     Stores all the current <see cref="SessionsManager"/> stored sessions keyed by the calculated unique token.
    /// </summary>
    readonly SessionsBag _sessionsBag = [];

    /// <summary>
    ///     Stores all the current calculated unique tokens managed, used to validate token related relations with no need to access <see cref="_sessionsBag"/> dictionary.
    /// </summary>
    readonly ConcurrentBag<Guid> _tokensBag = [];


    /// <summary>
    ///     {dep} Allows to access and handle transaction contexts.
    /// </summary>
    readonly IHttpContextAccessor _contextAccessor;

    /// <summary>
    ///     Creaes a new <see cref="SessionsManager"/> instance.
    /// </summary>
    public SessionsManager(
            IHttpContextAccessor contextAccesor
        ) {
        _contextAccessor = contextAccesor;
    }

    /// <summary>
    ///     Gets the current transaction context data.
    /// </summary>
    HttpContext Transaction {
        get {
            return _contextAccessor.HttpContext ?? throw new SessionManagerError(AuthErrorEvents.NO_REQ_CONTEXT);
        }
    }

    /// <summary>
    ///     Gets the current transaction context auth header value.
    /// </summary>
    string TransactionAuth {
        get {

            IHeaderDictionary reqHeaders = Transaction.Request.Headers;

            StringValues authHeader = reqHeaders.Authorization;

            return authHeader.ToString();
        }
    }

    /// <summary>
    ///     Gets the current transaction context auth token being used.
    /// </summary>
    string TransactionAuthToken {
        get {
            return TransactionAuth.Split('@')[0].Replace($"CSMAuth ", "");
        }
    }

    public async Task<SessionData> Auth(AuthInput input) {

        SessionData sessionData = await GenerateSession(input);
        StoreSession(input, sessionData);

        return sessionData;
    }

    public async Task<SessionData> Get() {
        string token = TransactionAuthToken;

        Guid sessionToken = Guid.Parse(token);

        if (!_sessionsBag.TryGetValue(sessionToken, out SessionScope sessionScope)) {
            throw new SessionManagerError(AuthErrorEvents.UNK_TOKEN);
        }

        return await GenerateSession(sessionScope.authInput);
    }

    /// <summary>
    ///     Generates the <see cref="SessionData"/> from the given <paramref name="input"/>, checking if the account identity and password
    ///     matches solution stored ones.
    /// </summary>
    /// <returns>
    ///     Session related information.
    /// </returns>
    async Task<SessionData> GenerateSession(AuthInput input) {
        HttpContext transaction = Transaction;

        IServiceProvider serviceProvider = transaction.RequestServices;
        IUsersService usersService = serviceProvider.GetRequiredService<IUsersService>();

        try {
            User userAccount = await usersService.Read(input.Username);

            if (!input.Password.SequenceEqual(userAccount.Password))
                throw new SessionManagerError(AuthErrorEvents.NO_REQ_CONTEXT);

            UserInfo sessionContact = userAccount.UserInfo;

            return new SessionData {
                User = userAccount,
                Expiration = DateTime.Now.Add(_expirationGap),
                Token = Guid.NewGuid(),
                Wildcard = userAccount.IsMaster,
                UserInfo = sessionContact,
            };
        } catch (ServiceError<User> readException) when (readException.Event == ServiceErrorEvents.READ_UNFOUND) {
            throw new SessionManagerError(AuthErrorEvents.UNFOUND_USR);
        }
    }

    /// <summary>
    ///     Internaly generates and stores into the current manager sessions the given <see cref="AuthInput"/> information.
    /// </summary>
    /// <param name="authInput">
    ///     Authentication input information.
    /// </param>
    /// <exception cref="SessionManagerError">
    ///     For more details check innser <see cref="AuthErrorEvents"/>.
    /// </exception>
    void StoreSession(AuthInput input, SessionData sessionData) {
        SessionScope sessionScope = (
                input,
                sessionData.Expiration
            );

        if (_sessionsBag.TryAdd(sessionData.Token, sessionScope)) {
            _tokensBag.Add(sessionData.Token);
            return;
        }

        throw new SessionManagerError(AuthErrorEvents.NO_REQ_CONTEXT);
    }
}
