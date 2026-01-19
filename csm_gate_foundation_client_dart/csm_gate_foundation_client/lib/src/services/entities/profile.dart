import 'package:csm_client_core/csm_client_core.dart';

/// {implementation} class for an [EntityI].
///
///  [Entity] that stores a relation between a collection of [Permit] with an [Account].
final class Profile extends CatalogEntityBase<Profile> {
  /// Creates a new instance.
  Profile();

  @override
  List<ObjectDifference> compare(Profile ref, [List<ObjectDifference>? aggregated]) {
    aggregated ??= <ObjectDifference>[];
    return super.compare(ref, aggregated);
  }
}
