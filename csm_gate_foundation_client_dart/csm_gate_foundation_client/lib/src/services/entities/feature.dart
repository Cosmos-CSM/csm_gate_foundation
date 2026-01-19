import 'package:csm_client_core/csm_client_core.dart';

/// Represents an ecosystem complex feature.
final class Feature extends CatalogEntityBase<Feature> {
  /// Creates a new instance.
  Feature();


  @override
  List<ObjectDifference> compare(Feature ref, [List<ObjectDifference>? aggregated]) {
    aggregated ??= <ObjectDifference>[];
    return super.compare(ref, aggregated);
  }
}
