import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';

/// Represents a server service communication for [User] entity operations.
abstract interface class IUsersService implements IViewService<User, GateFoundationServerResolver<ViewOutput<User>>>, ICreateService<User, GateFoundationServerResolver<BatchOperationOutput<User>>> {
  /// Creates a new instance.
  const IUsersService();
}
