import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/src/view/pages/features/view_pages_features_module.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;


/// {page} class.
///
/// Implements a [ViewPageBase], draws a complex {csm} design for the [Feature] business entity to interact and manage data related with it.
final class FeaturesPage extends EntityViewPageBase<Feature, FeaturesEntityTableAdapter> {
  /// Creates a new [FeaturesPage] instance.
  FeaturesPage({
    required super.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return FeaturesEntityTable(
      adapter: adapter,
    );
  }
}
