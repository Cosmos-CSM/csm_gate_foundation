import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';

/// Represents [User] information.
class UserInfo extends EntityBase<UserInfo> {
  /// User's name.
  String name = "";

  /// User's lastname.
  String lastName = "";

  /// User's contact email.
  String eMail = "";

  /// User's contact phoen.
  String phone = "";

  /// Creates a new instance.
  UserInfo();

  @override
  void decode(DataMap encode) {
    name = encode.get('name');
    lastName = encode.get('lastName');
    eMail = encode.get('eMail');
    phone = encode.get('phone');

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        'name': name,
        'lastName': lastName,
        'eMail': eMail,
        'phone': phone,
      },
    );
  }

  @override
  List<ObjectDifference> compare(UserInfo ref, [List<ObjectDifference>? aggregated]) {
    aggregated ??= <ObjectDifference>[];

    if (name != ref.name) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('name', String, name),
          name,
          ref.name,
          null,
        ),
      );
    }

    if (lastName != ref.lastName) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('lastName', String, lastName),
          lastName,
          ref.lastName,
          null,
        ),
      );
    }

    if (eMail != ref.eMail) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('eMail', String, eMail),
          eMail,
          ref.eMail,
          null,
        ),
      );
    }

    if (phone != ref.phone) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('phone', String, phone),
          phone,
          ref.phone,
          null,
        ),
      );
    }

    return super.compare(ref, aggregated);
  }
}
