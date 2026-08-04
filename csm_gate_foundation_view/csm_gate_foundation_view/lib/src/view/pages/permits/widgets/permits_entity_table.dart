import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog, Action;


/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [Permit] {entity}, also handles basic available behavior.
final class PermitsEntityTable extends GateFoundationEntityTableBase<Permit, PermitsEntityTableAdapter> {
  /// Creates a new [PermitsEntityTable] instance.
  const PermitsEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<Permit, ResponseResolverBase<ViewOutput<Permit>>, IPermitsService>(
      factory: () => Permit(),
      adapter: adapter,
      columns: <EntityTableColumnData<Permit>>[
        /// --> Name
        EntityTableColumnData<Permit>(
          title: 'Name',
          factory: (Permit entity, int index, BuildContext buildContext) => entity.name,
        ),
         /// --> Enabled
        EntityTableColumnData<Permit>(
          title: 'Enabled',
          factory: (Permit entity, int index, BuildContext buildContext) => entity.enabled? 'Yes' : 'No',
        ),
         /// --> Solution
        EntityTableColumnData<Permit>(
          title: 'Solution',
          factory: (Permit entity, int index, BuildContext buildContext) => entity.solution.name,
        ),
         /// --> Feature
        EntityTableColumnData<Permit>(
          title: 'Feature',
          factory: (Permit entity, int index, BuildContext buildContext) => entity.feature.name,
        ),
         /// --> Action
        EntityTableColumnData<Permit>(
          title: 'Action',
          factory: (Permit entity, int index, BuildContext buildContext) => entity.action.name,
        ),
      ],
    );
  }
}
