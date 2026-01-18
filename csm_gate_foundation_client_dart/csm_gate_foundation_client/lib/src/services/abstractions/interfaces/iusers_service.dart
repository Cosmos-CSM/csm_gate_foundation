import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';


/// Type definition for a simplified [User] view resolver.
typedef UsersViewResolver = GateFoundationServerResolver<ViewOutput<User>>;

/// Type definition for a simplified [User] batch resolver.
typedef UsersBatchResolver = GateFoundationServerResolver<BatchOperationOutput<User>>;

/// Represents a server service communication for [User] entity operations.
abstract interface class IUsersService implements IViewService<User, UsersViewResolver>, ICreateService<User, UsersBatchResolver> {
  /// Creates a new instance.
  const IUsersService();
}
