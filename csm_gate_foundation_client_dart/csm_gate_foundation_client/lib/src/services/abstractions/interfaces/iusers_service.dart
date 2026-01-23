import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';

/// Type definition for a simplified [User] view resolver.
typedef UsersViewResolver = GateFoundationServerResolver<ViewOutput<User>>;

/// Type definition for a simplified [User] batch resolver.
typedef UsersBatchResolver = GateFoundationServerResolver<BatchOperationOutput<User>>;

/// Type definition for a simplified [User] update resolver.
typedef UsersUpdateResolver = GateFoundationServerResolver<UpdateOutput<User>>;

/// Represents a server service communication for [User] entity operations.
abstract interface class IUsersService implements IViewService<User, UsersViewResolver>, ICreateService<User, UsersBatchResolver> {
  /// Creates a new instance.
  const IUsersService();

  /// Updates the given [user] entity in the data storages, the update is verying through the [IEntity.id]
  /// unique identifier, comparing the current stored data and the new given one.
  ///
  /// [user] - Updated entity to store.
  ///
  /// [authToken] - Server authentication token.
  Future<UsersUpdateResolver> update(User user, String authToken);
}
