import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// {abstract} class.
///
/// Implements base behavior for {foundation} [EntityTableAdapterI] implementations.
abstract class GateFoundationEntityTableBase<TAdapter extends IEntityTableAdapter> extends StatelessWidget {
  /// Adapter handler.
  final TAdapter adapter;

  /// Creates a new [GateFoundationEntityTableBase] instance.
  const GateFoundationEntityTableBase({
    super.key,
    required this.adapter,
  });
}
