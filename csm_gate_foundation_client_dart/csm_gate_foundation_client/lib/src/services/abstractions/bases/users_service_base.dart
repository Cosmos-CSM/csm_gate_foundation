import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/abstractions/bases/gate_foundation_service_base.dart';

/// Represents a server service communication for [User] entity operations.
abstract class UsersServiceBase extends GateFoundationServiceBase implements IUsersService {
  /// Creates a new instance.
  UsersServiceBase(
    Uri host, {
    String? servicePath,
    super.client,
    super.headers,
  }) : super(
         host,
         servicePath ?? "users",
       );

  @override
  Future<GateFoundationServerResolver<ViewOutput<User>>> view(ViewInput<User> input, String auth) async {
    final IResponseController controller = await postSecure('authenticate', input);
    return GateFoundationServerResolver<ViewOutput<User>>(controller);
  }
}
