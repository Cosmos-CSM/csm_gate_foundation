import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// {abstract} class.
///
/// Implements base behavior for {foundation} [EntityTableAdapterI] implementations.
abstract class GateFoundationEntityTableBase<TEntity extends IEntity<TEntity>, TAdapter extends IEntityTableAdapter<TEntity>> extends StatelessWidget {
  /// Adapter handler.
  final TAdapter adapter;

  /// Creates a new [GateFoundationEntityTableBase] instance.
  const GateFoundationEntityTableBase({
    super.key,
    required this.adapter,
  });
}
