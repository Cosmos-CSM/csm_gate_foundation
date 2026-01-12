import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/abstractions/bases/gate_foundation_service_base.dart';

/// Represents a [Profile] entity operations service.
abstract interface class IProfilesService extends GateFoundationServiceBase implements IViewService<Profile, GateFoundationServerResolver<ViewOutput<Profile>>>, ICreateService<Profile, GateFoundationServerResolver<BatchOperationOutput<Profile>>> {
  /// Creates a new instance.
  IProfilesService(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });

  /// Updates a [Profile] based on the [Profile.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  Future<GateFoundationServerResolver<UpdateOutput<Profile>>> update(UpdateInput<Profile> input, String auth);

  /// Updates a [Profile] based on the [Profile.Id] pointer.
  ///
  ///
  /// [entity] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  Future<GateFoundationServerResolver<Profile>> delete(Profile entity, String auth);
}
