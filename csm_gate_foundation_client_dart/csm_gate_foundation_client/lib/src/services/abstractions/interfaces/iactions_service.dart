import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/abstractions/bases/gate_foundation_service_base.dart';

/// Represents an [Action] entity operations service.
abstract interface class IActionsService extends GateFoundationServiceBase implements IService, IViewService<Action, GateFoundationServerResolver<ViewOutput<Action>>> {
  
  /// Creates a new instance.
  IActionsService(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}
