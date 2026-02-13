using CSM_Database_Core.Core.Errors;
using CSM_Database_Core.Depots.Models;

using CSM_Gate_Foundation_Core.Core.Errors;
using CSM_Gate_Foundation_Core.Services;

using CSM_Security_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Security_Database_Core.Entities;

using CSM_Server_Core_Testing.Abstractions.Bases;

using Moq;

namespace CSM_Gate_Foundation_Core_Unit_Tests.Tests.Services;

/// <summary>
///     Unit tests class for <see cref="UsersService"/>
/// </summary>
public class UsersServiceUnitTests
    : ServiceUnitTestsBase<User, IUsersDepot, UsersService> {

    protected override UsersService ServiceFactory(IUsersDepot depotMock) {
        return new UsersService(
                depotMock,
                Mock.Of<IUserInfosDepot>()
            );
    }

    /// <summary>
    ///     Tests that <see cref="UsersService.Read(string)"/> correctly reads a user by its username, 
    ///     by verifying that the correct query is sent to the depot and that the returned user matches the expected one.
    /// </summary>
    [Fact]
    public async Task Read_UserReadFromUsername_SuccessfulyGetsEntity() {
        // --> Expectation
        User expectation = new() {
            Username = "expected_username"
        };

        // --> Mocking
        Mock<IUsersDepot> usersDepotMock = new();
        usersDepotMock.Setup(
                obj => obj.Read(
                        It.IsAny<QueryInput<User, FilterQueryInput<User>>>()
                    )
            ).Returns(
                async (QueryInput<User, FilterQueryInput<User>> queryInput) => {
                    FilterQueryInput<User> @params = queryInput.Parameters;

                    Func<User, bool> compiledExpresison = @params.Filter.Compile();

                    User[] successes = [];

                    bool isMatch = compiledExpresison(expectation);
                    if (isMatch) {
                        successes = [expectation];
                    }

                    return new BatchOperationOutput<User>(
                            successes,
                            []
                        );
                }
            );

        UsersService service = new(
                usersDepotMock.Object,
                Mock.Of<IUserInfosDepot>()
            );

        // --> Acting 
        User userResult = await service.Read(expectation.Username);

        // --> Asserting
        Assert.Equal(expectation.Username, userResult.Username);
        usersDepotMock.Verify(
                obj => obj.Read(
                        It.IsAny<QueryInput<User, FilterQueryInput<User>>>()
                    ),
                Times.Once()
            );
    }

    /// <summary>
    ///     Tests that <see cref="UsersService.Read(string)"/> throws a caught failure exception during operation.
    /// </summary>
    [Fact]
    public async Task Read_UserReadFromUsername_outputFailed() {
        // --> Expectation
        string expectedMessage = "Expected exception message";
        Exception expectation = new(expectedMessage);

        // --> Mocking
        Mock<IUsersDepot> usersDepotMock = new();
        usersDepotMock.Setup(
                obj => obj.Read(
                        It.IsAny<QueryInput<User, FilterQueryInput<User>>>()
                    )
            ).Returns(
                async (QueryInput<User, FilterQueryInput<User>> queryInput) => {
                    return new BatchOperationOutput<User>(
                            [],
                            [
                                    new EntityError<User>(
                                            EntityErrorEvents.READ_FAILED,
                                            new User { },
                                            expectation
                                        )
                                ]
                        );
                }
            );

        UsersService service = new(
                usersDepotMock.Object,
                Mock.Of<IUserInfosDepot>()
            );

        // --> Asserting
        await Assert.ThrowsAsync(
                async () => await service.Read("invalidusername"),
                (Exception exception) => {
                    if (exception.Message == expectedMessage) {
                        return null;
                    }

                    return $"Wrong exception caught, expected ({expectedMessage}), caught ({exception.Message})";
                }
            );
        usersDepotMock.Verify(
                obj => obj.Read(
                        It.IsAny<QueryInput<User, FilterQueryInput<User>>>()
                    ),
                Times.Once()
            );
    }

    /// <summary>
    ///     Tests that <see cref="UsersService.Read(string)"/> throws an error when the entity was not found.
    /// </summary>
    [Fact]
    public async Task Read_UserReadFromUsername_EntityNotFoundError() {
        // --> Mocking
        Mock<IUsersDepot> usersDepotMock = new();
        usersDepotMock.Setup(
                obj => obj.Read(
                        It.IsAny<QueryInput<User, FilterQueryInput<User>>>()
                    )
            ).Returns(
                async (QueryInput<User, FilterQueryInput<User>> queryInput) => {
                    return new BatchOperationOutput<User>(
                            [],
                            []
                        );
                }
            );

        UsersService service = new(
                usersDepotMock.Object,
                Mock.Of<IUserInfosDepot>()
            );

        // --> Asserting
        await Assert.ThrowsAsync(
                async () => await service.Read("invalidusername"),
                (ServiceError<User> error) => {
                    if (error.Event == ServiceErrorEvents.READ_UNFOUND) {
                        return null;
                    }

                    return $"Unexpected error caught. Expected ({ServiceErrorEvents.READ_UNFOUND}), actual ({error.Event})";
                }
            );
        usersDepotMock.Verify(
                obj => obj.Read(
                        It.IsAny<QueryInput<User, FilterQueryInput<User>>>()
                    ),
                Times.Once()
            );
    }

    /// <summary>
    ///     Tests that <see cref="UsersService.ReadPermits(long)"/> correctly reads the permits of a user by its id.
    /// </summary>
    [Fact]
    public async Task ReadPermits_ReadPermitsFromUserId_CorrectlyGetsUserPermits() {
        // --> Expectation
        long userId = 1;
        Permit[] expectedPermits = [
                new Permit {
                        Id = 12,
                        Name = "random permit",
                    }
            ];

        // --> Mocking
        Mock<IUsersDepot> usersDepotMock = new();
        usersDepotMock.Setup(
                obj => obj.GetPermits(
                        It.Is<long>(id => id == userId)
                    )
            ).Returns(
                async (long userId) => expectedPermits
            );

        UsersService service = new(
            usersDepotMock.Object,
                Mock.Of<IUserInfosDepot>()
            );

        // --> Acting
        Permit[] userPermits = await service.ReadPermits(userId);

        // --> Asserting
        Assert.Equal(expectedPermits.Length, userPermits.Length);
        Assert.All(
                userPermits,
                permit => Assert.Contains(
                        expectedPermits,
                        expectedPermit => expectedPermit.Id == permit.Id && expectedPermit.Name == permit.Name
                    )
            );
        usersDepotMock.Verify(
                obj => obj.GetPermits(
                        It.Is<long>(id => id == userId)
                    ),
                Times.Once()
            );
    }

    /// <inheritdoc/>
    public override async Task Create_BatchEntityCreation(bool sync) {
        // --> Expectation
        User[] expectation = [
            new User {
                    Username = "username_1",
                    UserInfo = new UserInfo {
                            Id = 1,
                        }
                },
            new User {
                    Username = "username_2",
                    UserInfo = new UserInfo {
                            Id = 2,
                        }
                }
        ];

        // --> Mocking
        Mock<IUsersDepot> usersDepotMock = new();
        usersDepotMock.Setup(
                obj => obj.Create(
                        It.IsAny<User[]>(),
                        It.Is(sync, EqualityComparer<bool>.Default)
                    )
            ).Returns(
                async (User[] users, bool sync) => {

                    return new BatchOperationOutput<User>(
                            users,
                            []
                        );
                }
            );

        Mock<IUserInfosDepot> userInfosDepotMock = new();

        UsersService service = new(
                usersDepotMock.Object,
                userInfosDepotMock.Object
            );

        // --> Acting
        BatchOperationOutput<User> output = await service.Create(
                expectation,
                sync
            );

        // --> Asserting
        Assert.False(output.Failed);
        Assert.Empty(output.Failures);
        Assert.Equal(0, output.FailuresCount);
        Assert.NotEmpty(output.Successes);
        Assert.Equal(expectation.Length, output.SuccessesCount);
        Assert.Equal(expectation.Length, output.OperationsCount);
        Assert.All(
                output.Successes,
                (createdUser, index) => {
                    User expectedUser = expectation[index];
                    Assert.Multiple(
                            [
                                () => Assert.Equal(expectedUser.Username, createdUser.Username),
                                () => Assert.Equal(expectedUser.UserInfo.Id, createdUser.UserInfo.Id),
                            ]
                        );
                }
            );
        usersDepotMock.Verify(
                obj => obj.Create(
                        It.IsAny<User[]>(),
                        It.Is(sync, EqualityComparer<bool>.Default)
                    ),
                Times.Once()
            );
        userInfosDepotMock.Verify(
                obj => obj.Create(
                        It.Is<ICollection<UserInfo>>(
                                users => users.Count == 0
                            ),
                        It.Is(sync, EqualityComparer<bool>.Default)
                    ),
                Times.Once()
            );
    }

    /// <inheritdoc/>
    public override async Task Update_UpdateFromInput(bool isToCreate) {
        // --> Expectation
        User expectation = new() {
            Id = 1,
            Username = "expectation_username",
            UserInfo = new UserInfo {
                Id = 2,
            }
        };

        // --> Mocking
        Mock<IUsersDepot> usersDepotMock = new();
        usersDepotMock.Setup(
                obj => obj.Update(
                        It.Is<QueryInput<User, UpdateInput<User>>>(
                                input => input.Parameters.Create == isToCreate
                            )
                    )
            ).Returns(
                async (QueryInput<User, UpdateInput<User>> updateInput) => {

                    return new UpdateOutput<User> {
                        Original = isToCreate
                            ? null
                            : updateInput.Parameters.Entity,
                        Updated = updateInput.Parameters.Entity,
                    };
                }
            );

        Mock<IUserInfosDepot> userInfosDepotMock = new();
        userInfosDepotMock.Setup(
                obj => obj.Update(
                        It.Is<QueryInput<UserInfo, UpdateInput<UserInfo>>>(
                                input => input.Parameters.Create == isToCreate
                                    && input.Parameters.Entity.Id == expectation.UserInfo.Id
                            )
                    )
            ).Returns(
                async (QueryInput<UserInfo, UpdateInput<UserInfo>> input) => {
                    return new UpdateOutput<UserInfo> {
                        Original = isToCreate
                            ? null
                            : input.Parameters.Entity,
                        Updated = input.Parameters.Entity,
                    };
                }
            );

        UsersService service = new(
                usersDepotMock.Object,
                userInfosDepotMock.Object
            );

        // --> Acting
        UpdateOutput<User> output = await service.Update(
                new UpdateInput<User> {
                    Create = isToCreate,
                    Entity = expectation,
                }
            );

        // --> Asserting
        if (isToCreate) {
            Assert.Null(output.Original);
        } else {
            Assert.NotNull(output.Original);
        }

        Assert.Multiple(
                    [
                    () => Assert.Equal(expectation.Id, output.Updated.Id),
                    () => Assert.Equal(expectation.Username, output.Updated.Username),
                ]
            );
        usersDepotMock.Verify(
                obj => obj.Update(
                        It.Is<QueryInput<User, UpdateInput<User>>>(
                                input => input.Parameters.Create == isToCreate
                            )
                    ),
                Times.Once()
            );
        userInfosDepotMock.Verify(
                obj => obj.Update(
                        It.Is<QueryInput<UserInfo, UpdateInput<UserInfo>>>(
                                input => input.Parameters.Create == isToCreate
                                    && input.Parameters.Entity.Id == expectation.UserInfo.Id
                            )
                    ),
                Times.Once()
            );
    }
}
