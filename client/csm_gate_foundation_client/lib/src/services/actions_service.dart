import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/abstractions/bases/gate_foundation_service_base.dart';

/// Represents an [Action] entity operations service.
class ActionsService extends GateFoundationServiceBase implements IActionsService {
  /// Creates a new instance.
  ActionsService(
    Uri host, {
    super.client,
    super.headers,
  }) : super(
         host,
         'actions',
       );

  @override
  Future<GateFoundationServerResolver<ViewOutput<Action>>> view(ViewInput<Action> input, String auth) async {
    return GateFoundationServerResolver<ViewOutput<Action>>(
      await postSecure<ViewInput<Action>>(
        'view',
        input,
        authToken: auth,
      ),
    );
  }
}
