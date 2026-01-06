import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_view/csm_view.dart';

/// Provides utilities methods for [GateFoundationViewModule] development.
final class DeveloperGateUtils {
  /// Sets an user data into the application context.
  ///
  /// [authInput] - Authentication user data to set.
  static Future<void> setUser(AuthInput authInput) async {
    ISessionStorage sessionStorage = InjectorUtils.get();
    IAuthService authService = InjectorUtils.get();

    if (sessionStorage.isLive) {
      ConsoleUtils.successLog(
        'Setting development user',
        info: <String, dynamic>{
          'token': sessionStorage.token,
        },
      );
      return;
    }

    GateFoundationServerResolver<SessionData> authResolver = await authService.authenticate(authInput).timeout(6.seconds);
    SessionData serverSession = authResolver.resolveDirect(
      () => SessionData(),
    );

    sessionStorage.store(serverSession);
  }
}
