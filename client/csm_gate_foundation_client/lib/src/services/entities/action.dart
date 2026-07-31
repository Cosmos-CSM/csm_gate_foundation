import 'package:csm_client_core/csm_client_core.dart';

/// {implementation} class for an [EntityI].
///
/// [Entity] that represents the information for certain actions/operations to be performed to the Solutions.
final class Action extends CatalogEntityBase<Action> {
  /// Creates a new instance.
  Action();

  @override
  List<ObjectDifference> compare(Action ref, [List<ObjectDifference>? aggregated]) {
    aggregated ??= <ObjectDifference>[];
    return super.compare(ref, aggregated);
  }
}
