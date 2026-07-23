import 'dart:core' hide Uri;

import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/abstractions/bases/gate_foundation_service_base.dart';

/// Represents a [Permit] entity operations service.
class PermitsService extends GateFoundationServiceBase implements IPermitsService {
  /// Creates a new service.
  PermitsService(
    Uri host, {
    String? servicePath,
    super.client,
    super.headers,
  }) : super(
         host,
         servicePath ?? 'permits',
       );

  @override
  Future<GateFoundationServerResolver<ViewOutput<Permit>>> view(ViewInput<Permit> input, String auth) async {
    return GateFoundationServerResolver<ViewOutput<Permit>>(
      await postSecure<ViewInput<Permit>>(
        'view',
        input,
        authToken: auth,
      ),
    );
  }

  @override
  Future<GateFoundationServerResolver<BatchOperationOutput<Permit>>> create(List<Permit> users, String authToken) async {
    return GateFoundationServerResolver<BatchOperationOutput<Permit>>(
      await postListSecure<Permit>(
        'create',
        users,
        authToken: authToken,
      ),
    );
  }

  @override
  Future<GateFoundationServerResolver<UpdateOutput<Permit>>> update(UpdateInput<Permit> input, String authToken) async {
    return GateFoundationServerResolver<UpdateOutput<Permit>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  Future<GateFoundationServerResolver<Permit>> delete(Permit entity, String authToken) async {
    return GateFoundationServerResolver<Permit>(
      await postSecure(
        'delete',
        entity,
        authToken: authToken,
      ),
    );
  }
}
