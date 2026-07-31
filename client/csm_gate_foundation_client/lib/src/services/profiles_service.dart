import 'dart:core' hide Uri;

import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/abstractions/bases/gate_foundation_service_base.dart';

/// Represents a [Profile] entity operations service.
class ProfilesService extends GateFoundationServiceBase implements IProfilesService {
  /// Creates a new instance.
  ProfilesService(
    Uri host,
    String? servicePath, {
    super.client,
    super.headers,
  }) : super(
         host,
         servicePath ?? 'profiles',
       );

  @override
  Future<GateFoundationServerResolver<ViewOutput<Profile>>> view(ViewInput<Profile> input, String auth) async {
    return GateFoundationServerResolver<ViewOutput<Profile>>(
      await postSecure<ViewInput<Profile>>(
        'view',
        input,
        authToken: auth,
      ),
    );
  }

  @override
  Future<GateFoundationServerResolver<BatchOperationOutput<Profile>>> create(List<Profile> users, String authToken) async {
    return GateFoundationServerResolver<BatchOperationOutput<Profile>>(
      await postListSecure<Profile>(
        'create',
        users,
        authToken: authToken,
      ),
    );
  }

  @override
  Future<GateFoundationServerResolver<UpdateOutput<Profile>>> update(UpdateInput<Profile> input, String authToken) async {
    return GateFoundationServerResolver<UpdateOutput<Profile>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  Future<GateFoundationServerResolver<Profile>> delete(Profile entity, String authToken) async {
    return GateFoundationServerResolver<Profile>(
      await postSecure(
        'delete',
        entity,
        authToken: authToken,
      ),
    );
  }
}
