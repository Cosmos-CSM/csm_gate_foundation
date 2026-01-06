import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';

/// Represents a server service communication handler for {Auth} operations.
abstract interface class IAuthService implements IService {
  /// Authenticates an user into [GateFoundationServer].
  ///
  /// [input] operation input parameters.
  Future<GateFoundationServerResolver<SessionData>> authenticate(AuthInput input);
}
