import 'dart:core' hide Uri;

import 'package:csm_client_testing/csm_client_testing.dart';
import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:test/test.dart';

void main() {
  late IPermitsService serviceMock;
  final ViewOutput<Permit> viewOutputMock = ViewOutput<Permit>(permitBuilder);

  setUp(
    () {

      final Client clientMock = TestingClientUtils.createMockClient(
        <String, IEncodable>{
          'view': viewOutputMock,
        },
      );

      serviceMock = PermitsService(
        Uri('', ''),
        client: clientMock,
      );
    },
  );

  group(
    '[Unit Tests] Permit Service Tests',
    () {

      test(
        '[View]: correctly gets a {ViewOutput} generated.',
        () async {
          final ViewInput<Permit> viewInput = ViewInput<Permit>.b(1, 10);

          final ResponseResolverBase<ViewOutput<Permit>> resolver = await serviceMock.view(viewInput, '');

          final ViewOutput<Permit> viewOutput = resolver.resolveDirect(() => viewOutputBuilder(permitBuilder));

          expect(viewOutputMock.page, viewOutput.page);
          expect(viewOutputMock.pages, viewOutput.pages);
          expect(viewOutputMock.entities, viewOutput.entities);
          expect(viewOutputMock.timestamp, viewOutput.timestamp);
        },
      );
    },
  );
}
