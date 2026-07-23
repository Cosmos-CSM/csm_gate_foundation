import 'dart:core' hide Uri;

import 'package:csm_client_testing/csm_client_testing.dart';
import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:test/test.dart';

void main() {
  late IUsersService serviceMock;
  final ViewOutput<User> viewOutputMock = ViewOutput<User>(userBuilder);

  setUp(
    () {

      final Client clientMock = TestingClientUtils.createMockClient(
        <String, IEncodable>{
          'view': viewOutputMock,
        },
      );

      serviceMock = UsersService(
        Uri('', ''),
        client: clientMock,
      );
    },
  );

  group(
    '[Unit Tests] User Service Tests',
    () {

      test(
        '[View]: correctly gets a {ViewOutput} generated.',
        () async {
          final ViewInput<User> viewInput = ViewInput<User>.b(1, 10);

          final ResponseResolverBase<ViewOutput<User>> resolver = await serviceMock.view(viewInput, '');

          final ViewOutput<User> viewOutput = resolver.resolveDirect(() => viewOutputBuilder(userBuilder));

          expect(viewOutputMock.page, viewOutput.page);
          expect(viewOutputMock.pages, viewOutput.pages);
          expect(viewOutputMock.entities, viewOutput.entities);
          expect(viewOutputMock.timestamp, viewOutput.timestamp);
        },
      );
    },
  );
}
