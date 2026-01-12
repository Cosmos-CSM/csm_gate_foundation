import 'dart:core' hide Uri;

import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/abstractions/bases/gate_foundation_service_base.dart';

/// Represents a [Solution] entity operations service.
class SolutionsService extends GateFoundationServiceBase implements ISolutionsService {
  /// Creates a new instance.
  SolutionsService(
    Uri host, {
    String? servicePath,
    super.client,
    super.headers,
  }) : super(
         host,
         servicePath ?? 'solutions',
       );

  @override
  Future<GateFoundationServerResolver<ViewOutput<Solution>>> view(ViewInput<Solution> input, String authToken) async {
    return GateFoundationServerResolver<ViewOutput<Solution>>(
      await postSecure<ViewInput<Solution>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  Future<GateFoundationServerResolver<BatchOperationOutput<Solution>>> create(List<Solution> solutions, String authToken) async {
    return GateFoundationServerResolver<BatchOperationOutput<Solution>>(
      await postListSecure<Solution>(
        'create',
        solutions,
        authToken: authToken,
      ),
    );
  }

  @override
  Future<GateFoundationServerResolver<UpdateOutput<Solution>>> update(UpdateInput<Solution> input, String authToken) async {
    return GateFoundationServerResolver<UpdateOutput<Solution>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }
}
