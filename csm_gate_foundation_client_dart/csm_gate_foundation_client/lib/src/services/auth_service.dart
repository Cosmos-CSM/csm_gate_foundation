import 'package:csm_gate_foundation_client/src/services/abstractions/bases/auth_service_base.dart';

/// Represents a server service communication handler for {Auth} operations.
final class AuthService extends AuthServiceBase {
  /// Creates a new instance.
  AuthService(
    super.host, {
    super.client,
    super.headers,
    super.servicePath,
  });
}
