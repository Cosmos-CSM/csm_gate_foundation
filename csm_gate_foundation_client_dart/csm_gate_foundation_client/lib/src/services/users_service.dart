import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/abstractions/bases/gate_foundation_service_base.dart';

/// Represents a server service communication for [User] entity operations.
class UsersService extends GateFoundationServiceBase implements IUsersService {
  /// Creates a new instance.
  UsersService(
    Uri host, {
    String? servicePath,
    super.client,
    super.headers,
  }) : super(
         host,
         servicePath ?? "users",
       );

  @override
  Future<UsersViewResolver> view(ViewInput<User> input, String auth) async {
    final IResponseController controller = await postSecure('view', input, authToken: auth);
    return UsersViewResolver(controller);
  }

  @override
  Future<UsersBatchResolver> create(List<User> users, String authToken) async {
    return UsersBatchResolver(
      await postListSecure<User>(
        'create',
        users,
        authToken: authToken,
      ),
    );
  }  
}
