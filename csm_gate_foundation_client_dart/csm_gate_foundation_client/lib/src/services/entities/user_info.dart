import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';

/// Represents [User] information.
class UserInfo extends EntityBase<UserInfo> {

  /// [UserInfo.name] property key.
  static const String kName = 'name';
  /// [UserInfo.lastName] property key.
  static const String kLastName = 'lastName';
  /// [UserInfo.eMail] property key.
  static const String kEMail = 'eMail';
  /// [UserInfo.phone] property key.
  static const String kPhone = 'phone';

  /// User's name.
  ///
  /// Rules:
  ///   1. 101 > [name] > 0
  String name = '';

  /// User's last name.
  ///
  /// Rules:
  ///   1. 101 > [lastName] > 0
  String lastName = '';

  /// User's E-Mail address.
  ///
  /// Rules:
  ///   1. 101 > [eMail] > 0
  String eMail = '';

  /// User's contact phone.
  ///
  /// Rules:
  ///   1. 15 > [phone] > 0
  String phone = '';

  /// Creates a new instance.
  UserInfo();

  @override
  void decode(DataMap encode) {
    name = encode.get(kName);
    lastName = encode.get(kLastName);
    eMail = encode.get(kEMail);
    phone = encode.get(kPhone);

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kName: name,
        kLastName: lastName,
        kEMail: eMail,
        kPhone: phone,
      },
    );
  }

  @override
  List<ObjectDifference> compare(UserInfo ref, [List<ObjectDifference>? aggregated]) {
    aggregated ??= <ObjectDifference>[];

    if (name != ref.name) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kName, String, name),
          name,
          ref.name,
          null,
        ),
      );
    }

    if (lastName != ref.lastName) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kLastName, String, lastName),
          lastName,
          ref.lastName,
          null,
        ),
      );
    }

    if (eMail != ref.eMail) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kEMail, String, eMail),
          eMail,
          ref.eMail,
          null,
        ),
      );
    }

    if (phone != ref.phone) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kPhone, String, phone),
          phone,
          ref.phone,
          null,
        ),
      );
    }

    return super.compare(ref, aggregated);
  }

  @override
  List<EntityErrors<UserInfo>> evaluate(List<EntityErrors<UserInfo>> errors) {
    errors = super.evaluate(errors);


    if (name.length > 100 || name.trim().isEmpty) {
      errors.add(
        EntityErrors<UserInfo>(
          this,
          PropertyInfo(
            kName,
            String,
            name,
          ),
          CoreEntityErrorReasonsConsts.invalidLength,
          'Between 1 and 100 characters',
        ),
      );
    }

    if (lastName.length > 100 || lastName.trim().isEmpty) {
      errors.add(
        EntityErrors<UserInfo>(
          this,
          PropertyInfo(
            kLastName,
            String,
            lastName,
          ),
          CoreEntityErrorReasonsConsts.invalidLength,
          'Between 1 and 100 characters',
        ),
      );
    }

    if (eMail.length > 100 || eMail.trim().isEmpty) {
      errors.add(
        EntityErrors<UserInfo>(
          this,
          PropertyInfo(
            kEMail,
            String,
            eMail,
          ),
          CoreEntityErrorReasonsConsts.invalidLength,
          'Between 1 and 100 characters',
        ),
      );
    }

    if (phone.length > 14 || phone.trim().isEmpty) {
      errors.add(
        EntityErrors<UserInfo>(
          this,
          PropertyInfo(
            kPhone,
            String,
            phone,
          ),
          CoreEntityErrorReasonsConsts.invalidLength,
          'Between 1 and 14 characters',
        ),
      );
    }

    return errors;
  }
}
