import 'dart:core' hide Uri;

import 'package:csm_client_testing/csm_client_testing.dart';
import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:test/test.dart';

void main() {
  late IProfilesService serviceMock;
  final ViewOutput<Profile> viewOutputMock = ViewOutput<Profile>(profileBuilder);

  setUp(
    () {

      final Client clientMock = TestingClientUtils.createMockClient(
        <String, IEncodable>{
          'view': viewOutputMock,
        },
      );

      serviceMock = ProfilesService(
        Uri('', ''),
        client: clientMock,
      );
    },
  );

  group(
    '[Unit Tests] Profile Service Tests',
    () {

      test(
        '[View]: correctly gets a {ViewOutput} generated.',
        () async {
          final ViewInput<Profile> viewInput = ViewInput<Profile>.b(1, 10);

          final ResponseResolverBase<ViewOutput<Profile>> resolver = await serviceMock.view(viewInput, '');

          final ViewOutput<Profile> viewOutput = resolver.resolveDirect(() => viewOutputBuilder(profileBuilder));

          expect(viewOutputMock.page, viewOutput.page);
          expect(viewOutputMock.pages, viewOutput.pages);
          expect(viewOutputMock.entities, viewOutput.entities);
          expect(viewOutputMock.timestamp, viewOutput.timestamp);
        },
      );
    },
  );
}
