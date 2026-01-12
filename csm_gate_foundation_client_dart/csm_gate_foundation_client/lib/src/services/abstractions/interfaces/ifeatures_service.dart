import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/abstractions/bases/gate_foundation_service_base.dart';

/// Represents a [Feature] entity operations service.
abstract interface class IFeaturesService extends GateFoundationServiceBase implements IViewService<Feature, GateFoundationServerResolver<ViewOutput<Feature>>>, ICreateService<Feature, GateFoundationServerResolver<BatchOperationOutput<Feature>>> {
  /// Creates a new instance.
  IFeaturesService(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });

  /// Updates a [Contact] based on the [Contact.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  Future<GateFoundationServerResolver<UpdateOutput<Feature>>> update(UpdateInput<Feature> input, String auth);

  /// Updates a [Contact] based on the [Contact.Id] pointer.
  ///
  ///
  /// [entity] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  Future<GateFoundationServerResolver<Feature>> delete(Feature entity, String auth);
}
