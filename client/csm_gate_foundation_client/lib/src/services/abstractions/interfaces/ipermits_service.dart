import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/abstractions/bases/gate_foundation_service_base.dart';

/// Represetns a [Permit] entity operations service.
abstract interface class IPermitsService extends GateFoundationServiceBase implements IViewService<Permit, GateFoundationServerResolver<ViewOutput<Permit>>>, ICreateService<Permit, GateFoundationServerResolver<BatchOperationOutput<Permit>>> {
  /// Creates a new instance.
  IPermitsService(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });

  /// Updates a [Permit] based on the [Permit.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  Future<GateFoundationServerResolver<UpdateOutput<Permit>>> update(UpdateInput<Permit> input, String auth);

  /// Updates a [Permit] based on the [Permit.Id] pointer.
  ///
  ///
  /// [entity] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  Future<GateFoundationServerResolver<Permit>> delete(Permit entity, String auth);
}
