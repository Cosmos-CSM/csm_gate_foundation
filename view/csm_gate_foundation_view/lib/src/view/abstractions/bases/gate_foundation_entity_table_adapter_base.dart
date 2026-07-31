import 'dart:async';

import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_view/csm_view.dart';

/// Represents a { Gate Foundation } entity table adapter.
///
/// [TEntity] - Type of the [IEntity] the table is based on.
abstract class GateFoundationEntityTableAdapterBase<TEntity extends IEntity<TEntity>> extends EntityTableAdapterBase<TEntity> {
  /// Creates a new instance.
  GateFoundationEntityTableAdapterBase();

  @override
  FutureOr<String> composeAuth() {
    ISessionStorage sessionStorage = InjectorUtils.get();

    return sessionStorage.token;
  }
}
