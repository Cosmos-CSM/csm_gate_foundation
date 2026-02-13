using CSM_Gate_Foundation_Core.Core.Models;
using CSM_Gate_Foundation_Core.Managers.Abstractions.Interfaces;
using CSM_Gate_Foundation_Core.Services;
using CSM_Gate_Foundation_Core.Services.Models.Inputs;

using CSM_Security_Database_Core.Entities;

using Moq;

namespace CSM_Gate_Foundation_Core_Unit_Tests.Tests.Services;

/// <summary>
///     Tests class for <see cref="IActionsService"/>
/// </summary>
public class AuthServiceUnitTests {


    /// <summary>
    ///     Tests that <see cref="AuthService.Authenticate(AuthInput)"/> correctly returns the token expected and called correctly the <see cref="ISessionsManager.Auth(AuthInput)"/> method
    /// </summary>
    /// <returns></returns>
    [Fact]
    public async Task Authenticate_CorrectlyGetsToken() {
        // --> Expectations
        Guid expectedToken = Guid.NewGuid();

        // --> Mocking
        Mock<ISessionsManager> sessionManagerMock = new();
        sessionManagerMock.Setup(
                obj => obj.Auth(It.IsAny<AuthInput>())
            ).Returns(
                async () => {
                    return new SessionData {
                        Expiration = DateTime.UtcNow.AddHours(1),
                        Permits = [],
                        Token = expectedToken,
                        UserInfo = new UserInfo {
                            Id = 1,
                            Name = "Test User",
                        },
                        Wildcard = false,
                    }; 
                }
            );

        AuthService authService = new(sessionManagerMock.Object);


        // --> Acting.
        SessionData sessionData = await authService.Authenticate(
                new AuthInput {
                    Sign = "",
                    Username = "",
                    Password = [],
                }
            );


        // --> Asserting.
        Assert.Equal(expectedToken, sessionData.Token);
        sessionManagerMock.Verify(
                obj => obj.Auth(It.IsAny<AuthInput>()),
                Times.Once()
            );
    }
}
