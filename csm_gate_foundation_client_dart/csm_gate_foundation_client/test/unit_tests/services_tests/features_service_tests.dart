import 'dart:core' hide Uri;

import 'package:csm_client_testing/csm_client_testing.dart';
import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:test/test.dart';

void main() {
  late IFeaturesService serviceMock;
  final ViewOutput<Feature> viewOutputMock = ViewOutput<Feature>(featureBuilder);
  // final UpdateOutput<Feature> updateOutputMock = UpdateOutput<Feature>(featureBuilder);
  // final BatchOperationOutput<Feature> createBatchOutputMock = BatchOperationOutput<Feature>(featureBuilder);

  setUp(
    () {

      // TODO: Create and update services are not IEncodable.
      final Client clientMock = TestingClientUtils.createMockClient(
        <String, IEncodable>{
          'view': viewOutputMock,
        },
      );

      serviceMock = FeaturesService(
        Uri('', ''),
        client: clientMock,
      );
    },
  );

  group(
    '[Unit Tests] Feature Service Tests',
    () {

      test(
        '[View]: correctly gets a {ViewOutput} generated.',
        () async {
          final ViewInput<Feature> viewInput = ViewInput<Feature>.b(1, 10);

          final ResponseResolverBase<ViewOutput<Feature>> resolver = await serviceMock.view(viewInput, '');

          final ViewOutput<Feature> viewOutput = resolver.resolveDirect(() => viewOutputBuilder(featureBuilder));

          expect(viewOutputMock.page, viewOutput.page);
          expect(viewOutputMock.pages, viewOutput.pages);
          expect(viewOutputMock.entities, viewOutput.entities);
          expect(viewOutputMock.timestamp, viewOutput.timestamp);
        },
      );
    },
  );
}
