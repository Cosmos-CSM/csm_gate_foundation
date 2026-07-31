import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/abstractions/bases/gate_foundation_service_base.dart';

/// Represents a [Solution] entity operations service.
abstract interface class ISolutionsService extends GateFoundationServiceBase implements IService, IViewService<Solution, GateFoundationServerResolver<ViewOutput<Solution>>>, ICreateService<Solution, GateFoundationServerResolver<BatchOperationOutput<Solution>>> {
  /// Creates a new [ISolutionsService] instance.
  ISolutionsService(
    super.host,
    super.servicePath,
  );

  /// Updates a [Solution] based on the [Solution.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  Future<GateFoundationServerResolver<UpdateOutput<Solution>>> update(UpdateInput<Solution> input, String auth);
}
