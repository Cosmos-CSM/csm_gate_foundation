import 'package:csm_gate_foundation_client/src/services/entities/user.dart';
import 'package:csm_gate_foundation_client/src/services/services_module.dart';

/// Represents a server service communication for [User] entity operations.
final class UsersService extends UsersServiceBase {
  /// Creates a new instance.
  UsersService(
    super.host, {
    super.client,
    super.headers,
    super.servicePath,
  });
}
