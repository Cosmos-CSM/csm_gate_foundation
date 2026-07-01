import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/core/utilities/entity_utilities.dart';

/// Represents a permit into the ecosystem, to trace security through actions into system.
final class Permit extends CatalogEntityBase<Permit> {

  /// [Permit.solution] property key.
  static const String kSolution = 'solution';

  /// [Permit.action] property key.
  static const String kAction = 'action';

  /// [Permit.feature] property key.
  static const String kFeature = 'feature';

  /// [Solution] information.
  Solution solution = Solution();

  /// [Feature] information.
  Feature feature = Feature();

  /// [Action] information.
  Action action = Action();

  /// Creates a new instance.
  Permit();

  @override
  void decode(DataMap encode) {
    solution =
        encode.getEntity(
          () => Solution(),
          kSolution,
        ) ??
        Solution();
    feature =
        encode.getEntity(
          () => Feature(),
          kFeature,
        ) ??
        Feature();
    action =
        encode.getEntity(
          () => Action(),
          kAction,
        ) ??
        Action();

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kSolution: solution.encode(),
        kFeature: feature.encode(),
        kAction: action.encode(),
      },
    );
  }

  @override
  List<ObjectDifference> compare(Permit ref, [List<ObjectDifference>? aggregated]) {
    aggregated ??= <ObjectDifference>[];

    if(reference != ref.reference) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(CorePropertiesConsts.reference, String, reference),
          reference,
          ref.reference,
          null,
        ),
      );
    }

    List<ObjectDifference> solutionDiffs = solution.compare(ref.solution);
    if (solutionDiffs.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('solution', Solution, solution),
          null,
          null,
          solutionDiffs,
        ),
      );
    }

    List<ObjectDifference> featureDiffs = feature.compare(ref.feature);
    if (featureDiffs.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('feature', Feature, feature),
          null,
          null,
          featureDiffs,
        ),
      );
    }

    List<ObjectDifference> actionDiffs = action.compare(ref.action);
    if (actionDiffs.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('action', Action, action),
          null,
          null,
          actionDiffs,
        ),
      );
    }

    return super.compare(ref, aggregated);
  }

  @override
  List<EntityErrors<Permit>> evaluate(List<EntityErrors<Permit>> errors) {
    errors = super.evaluate(errors);

    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Permit>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }

    if (description != null) {
      if (description!.trim().isEmpty || description!.length > 200) {
        errors.add(
          EntityErrors<Permit>(
            this,
            PropertyInfo(CorePropertiesConsts.description, String, description),
            "Lenght: ${description!.length}, less than 200 characters or empty.",
            "201 > length",
          ),
        );
      }
    }

    if (reference.length != 8) {
      errors.add(
        EntityErrors<Permit>(
          this,
          PropertyInfo(CorePropertiesConsts.reference, String, reference),
          'lentgh: ${reference.length}, must be exactly 8 characters',
          'length == 8',
        ),
      );
    }

    errors.validateDependency(this, solution);
    errors.validateDependency(this, feature);
    errors.validateDependency(this, action);

    return errors;
  }
}
