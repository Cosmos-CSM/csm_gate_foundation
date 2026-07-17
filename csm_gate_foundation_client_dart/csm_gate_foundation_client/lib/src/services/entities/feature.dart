import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/core/utilities/entity_utilities.dart';

/// {implementation} class for an [IEntity].
///
/// [Entity] that represents a complex Feature storing different actions, this to determine Feature Scoped permits.
/// only for authorization purposes.
final class Feature extends CatalogEntityBase<Feature> { 

  /// [Feature.permits] property key.
  static const String kPermits = 'Permits';

  /// [Permit]s information.
  List<Permit> permits = <Permit>[];
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    List<DataMap> permitsMaps = encode.getList(kPermits);
    if (permitsMaps.isNotEmpty) {
      permits = permitsMaps.map<Permit>(
        (DataMap e) {
          Permit permit = Permit();
          permit.decode(e);
          return permit;
        },
      ).toList();
    }
  }
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kPermits: permits
            .map(
              (Permit e) => e.encode(),
            )
            .toList(),
      },
    );
  }

  @override
  List<EntityErrors<Feature>> evaluate(List<EntityErrors<Feature>> errors) {
    errors = super.evaluate(errors);
    
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Feature>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    if (name.trim().isEmpty || name.length > 100) {
      errors.add(
        EntityErrors<Feature>(
          this,
          PropertyInfo(CorePropertiesConsts.name, String, name),
          CoreEntityErrorReasonsConsts.invalidLength,
          'Between 1 and 100 characters',
        ),
      );
    }
    if (description != null) {
      if (description!.trim().isEmpty || description!.length > 200) {
        errors.add(
          EntityErrors<Feature>(
            this,
            PropertyInfo(CorePropertiesConsts.description, String, description),
            CoreEntityErrorReasonsConsts.invalidLength,
            'Empty or between 1 and 200 characters',
          ),
        );
      }
    }

    if (permits.isNotEmpty) {
      for (Permit plate in permits) {
        errors.validateDependency(this, plate);
      }
    }
    return errors;
  }
  
  @override
  List<ObjectDifference> compare(Feature ref, [List<ObjectDifference>? aggregated]) {
    aggregated ??= <ObjectDifference>[];

    for(Permit permit in permits){
      Permit? refPermit = ref.permits.firstWhere((Permit e) => e.id == permit.id, orElse: () => Permit());
      List<ObjectDifference> permitDiff = permit.compare(refPermit);

      if (permitDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kPermits, Permit, permit),
            permit,
            refPermit,
            permitDiff,
          ),
        );
      }
    }

    return  super.compare(ref, aggregated);
  }
}
