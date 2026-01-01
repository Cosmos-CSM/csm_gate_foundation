import 'dart:core' hide Uri;
import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_gate_foundation_client/src/abstractions/bases/gate_foundation_service_base.dart';
import 'package:csm_gate_foundation_client/src/core/models/session_data.dart';
import 'package:csm_gate_foundation_client/src/gate_foundation_server_resolver.dart';
import 'package:csm_gate_foundation_client/src/models/inputs/auth_input.dart';
import 'package:csm_gate_foundation_client/src/services/abstractions/interfaces/iauth_service.dart';

/// Represents a server service communication handler for {Auth} operations.
abstract class AuthServiceBase extends CSMGateFoundationServiceBase implements IAuthService {
  /// Creates a new instance.
  AuthServiceBase(
    Uri host, {
    String? servicePath,
    super.client,
    super.headers,
  }) : super(
         host,
         servicePath ?? "auth",
       );

  @override
  Future<GateFoundationServerResolver<SessionData>> authenticate(AuthInput input) async {
    final IResponseController controller = await postSecure('authenticate', input);
    return GateFoundationServerResolver<SessionData>(controller);
  }
}
