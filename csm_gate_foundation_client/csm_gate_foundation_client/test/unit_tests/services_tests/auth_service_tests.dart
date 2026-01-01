import 'dart:core' hide Uri;

import 'package:csm_client_core/csm_client_core.dart' show Client, StringExtension, Uri;
import 'package:csm_client_testing/csm_client_testing.dart';
import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:test/test.dart';

void main() {
  late IAuthService serviceMock;
  late SessionData sessionDataMock;

  setUp(
    () {
      sessionDataMock = SessionData();
      sessionDataMock.expiration = DateTime.now().toUtc();
      sessionDataMock.wildcard = true;
      sessionDataMock.token = 'test_token';

      final Client clientMock = TestingClientUtils.createMockClient<SessionData>(
        <String, SessionData>{
          'authenticate': sessionDataMock,
        },
      );

      serviceMock = AuthService(
        Uri('', ''),
        client: clientMock,
      );
    },
  );

  group(
    'Security Service Tests',
    () {
      final AuthInput input = AuthInput();
      input.username = 'test_username';
      input.password = 'testing_password'.bytes;
      input.sign = 'twsmf';

      test(
        '[authenticate]: correctly gets {ServerSession} object',
        () async {
          final GateFoundationServerResolver<SessionData> resolver = await serviceMock.authenticate(input);
          final SessionData serverSession = resolver.resolveDirect(() => SessionData());

          expect(serverSession.token, sessionDataMock.token);
          expect(serverSession.wildcard, sessionDataMock.wildcard);
          expect(serverSession.expiration, sessionDataMock.expiration);
        },
      );
    },
  );
}
