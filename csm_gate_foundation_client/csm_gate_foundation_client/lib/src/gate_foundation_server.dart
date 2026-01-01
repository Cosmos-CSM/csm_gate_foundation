import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_gate_foundation_client/src/gate_foundation_server_options.dart';
import 'package:csm_gate_foundation_client/src/services/abstractions/interfaces/iauth_service.dart';
import 'package:csm_gate_foundation_client/src/services/auth_service.dart';

/// Represents a server communication handler with { CSM Gate Foundation Server }.
final class GateFoundationServer extends ServerBase {
  /// {Auth} operations service.
  late final IAuthService authService;

  /// Creates a new instance.
  GateFoundationServer({
    Uri? devHost,
    required String sign,
    required bool isRelease,
    super.prodHost,
    super.httpClient,
    super.serverHeaders,
    ServiceBuilder<IAuthService>? authServiceBuilder,
  }) : super(
         devHost ??
             Uri(
               'localhost',
               '',
               port: 5195,
             ),
         isRelease: isRelease,
       ) {
    GateFoundationServerOptions.sign = sign;

    Uri host = super.serverHost;
    Client? client = super.httpClient;

    authService = authServiceBuilder?.call(host, client) ?? AuthService(host);
  }
}
