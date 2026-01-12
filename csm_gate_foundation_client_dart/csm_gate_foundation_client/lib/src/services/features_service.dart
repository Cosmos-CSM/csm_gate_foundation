import 'dart:core' hide Uri;

import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/abstractions/bases/gate_foundation_service_base.dart';
import 'package:csm_gate_foundation_client/src/services/abstractions/interfaces/ifeatures_service.dart';

/// Represents a [Feature] entity operations service.
class FeaturesService extends GateFoundationServiceBase implements IFeaturesService {
  /// Creates a new instance.
  FeaturesService(
    Uri host,
    String? servicePath, {
    super.client,
    super.headers,
  }) : super(
         host,
         servicePath ?? 'features',
       );

  @override
  Future<GateFoundationServerResolver<ViewOutput<Feature>>> view(ViewInput<Feature> input, String auth) async {
    return GateFoundationServerResolver<ViewOutput<Feature>>(
      await postSecure<ViewInput<Feature>>(
        'view',
        input,
        authToken: auth,
      ),
    );
  }

  @override
  Future<GateFoundationServerResolver<BatchOperationOutput<Feature>>> create(List<Feature> features, String authToken) async {
    return GateFoundationServerResolver<BatchOperationOutput<Feature>>(
      await postListSecure<Feature>(
        'create',
        features,
        authToken: authToken,
      ),
    );
  }

  @override
  Future<GateFoundationServerResolver<UpdateOutput<Feature>>> update(UpdateInput<Feature> input, String authToken) async {
    return GateFoundationServerResolver<UpdateOutput<Feature>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  Future<GateFoundationServerResolver<Feature>> delete(Feature entity, String authToken) async {
    return GateFoundationServerResolver<Feature>(
      await postSecure(
        'delete',
        entity,
        authToken: authToken,
      ),
    );
  }
}
