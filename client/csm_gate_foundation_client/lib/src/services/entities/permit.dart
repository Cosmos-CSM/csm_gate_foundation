import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';

/// Represents a permit into the ecosystem, to trace security through actions into system.
final class Permit extends EntityBase<Permit> {
  /// [Permit.solution] property key.
  static const String kSolution = 'solution';

  /// [Permit.action] property key.
  static const String kAction = 'action';

  /// [Permit.feature] property key.
  static const String kFeature = 'feature';

  /// Solution data.
  Solution solution = Solution();

  /// Feature data.
  Feature feature = Feature();

  /// Action data.
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
}
