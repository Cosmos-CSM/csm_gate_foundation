import 'package:csm_client_core/csm_client_core.dart';

/// Represents a solution metadata info into the ecosystem.
final class Solution extends NamedEntityBase<Solution> {
  /// Unique solution signature.
  String sign = "";

  /// Creates a new instance.
  Solution();

  @override
  void decode(DataMap encode) {
    sign = encode.get('sign');

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        'sign': sign,
      },
    );
  }

  @override
  List<EntityErrors<Solution>> evaluate(List<EntityErrors<Solution>> errors) {
    List<EntityErrors<Solution>> error = <EntityErrors<Solution>>[];

    if (sign.length != 5) {
      error.add(
        EntityErrors<Solution>(
          this,
          PropertyInfo(
            'sign',
            bool,
            sign,
          ),
          CoreEntityErrorReasonsConsts.invalidLength,
          'Fixed 5',
        ),
      );
    }

    return super.evaluate(errors);
  }

  @override
  List<ObjectDifference> compare(Solution ref, [List<ObjectDifference>? aggregated]) {
    aggregated ??= <ObjectDifference>[];

    if (sign != ref.sign) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('sign', String, sign),
          sign,
          ref.sign,
          null,
        ),
      );
    }
    return super.compare(ref, aggregated);
  }
}
