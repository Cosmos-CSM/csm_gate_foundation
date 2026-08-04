import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/widgets.dart';

/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [Feature] {entity}, also handles basic available behavior.
final class FeaturesEntityTable extends GateFoundationEntityTableBase<Feature, FeaturesEntityTableAdapter> {
  /// Creates a new [FeaturesEntityTable] instance.
  const FeaturesEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<Feature, ResponseResolverBase<ViewOutput<Feature>>, IFeaturesService>(
      factory: () => Feature(),
      adapter: adapter,
      columns: <EntityTableColumnData<Feature>>[
        /// --> Name
        EntityTableColumnData<Feature>(
          title: 'Name',
          factory: (Feature entity, int index, BuildContext buildContext) => entity.name,
        ),

        /// --> Description
        EntityTableColumnData<Feature>(
          title: 'Description',
          factory: (Feature entity, int index, BuildContext buildContext) => entity.description,
        ),

        /// --> Reference
        EntityTableColumnData<Feature>(
          title: 'Reference',
          factory: (Feature entity, int index, BuildContext buildContext) => entity.reference,
        ),

        /// --> Associated permits
        EntityTableColumnData<Feature>(
          title: 'associated permits',
          factory: (Feature entity, int index, BuildContext buildContext) => entity.permits.length.toString(),
        ),
      ],
    );
  }
}
