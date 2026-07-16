import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/src/view/pages/permits/widgets/permits_entity_table.dart';
import 'package:csm_gate_foundation_view/src/view/pages/permits/widgets/permits_entity_table_adapter.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;


/// {page} class.
///
/// Implements a [ViewPageBase], draws a complex {csm} design for the [Permit] business entity to interact and manage data related with it.
final class PermitsPage extends EntityViewPageBase<Permit, PermitsEntityTableAdapter> {
  /// Creates a new [PermitsPage] instance.
  PermitsPage({
    required super.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return PermitsEntityTable(
      adapter: adapter,
    );
  }
}
