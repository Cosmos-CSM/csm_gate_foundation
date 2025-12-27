import 'dart:core' hide Uri;
import 'dart:typed_data';

import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:test/test.dart';

void main() {
  late IAuthService authServiceMock;

  setUp(
    () {
      authServiceMock = CSMGateFoundationServer(
        sign: 'CSMGF',
        isRelease: false,
      ).authService;
    },
  );

  group(
    '[Integration Tests] Security Service Tests',
    () {
      final AuthInput authInput = AuthInput.a(
        'CSMGF',
        'local_user',
        Uint8List.fromList(
          'local_user'.codeUnits,
        ),
      );

      test(
        '[authenticate]: correctly gets { SessionData }',
        () async {
          final CSMGateServerResolver<SessionData> resolver = await authServiceMock.authenticate(authInput);
          final SessionData sessionData = resolver.resolveDirect(
            () => SessionData(),
          );

          expect(sessionData.token, isNotEmpty);
          expect(sessionData.wildcard, true);
        },
      );
    },
  );
}
