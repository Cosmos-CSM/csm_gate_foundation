import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/_gate_foundation_server_options.dart';

/// Represents a server communication handler with { CSM Gate Foundation Server }.
final class GateFoundationServer extends ServerBase {
  /// {Auth} operations service.
  late final IAuthService authService;

  late final IUsersService usersService;

  /// Creates a new instance.
  GateFoundationServer({
    Uri? devHost,
    required String sign,
    required bool isRelease,
    super.prodHost,
    super.httpClient,
    super.serverHeaders,
    ServiceBuilder<IAuthService>? authServiceBuilder,
    ServiceBuilder<IUsersService>? usersServiceBuilder,
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
    usersService = usersServiceBuilder?.call(host, client) ?? UsersService(host);
  }
}
