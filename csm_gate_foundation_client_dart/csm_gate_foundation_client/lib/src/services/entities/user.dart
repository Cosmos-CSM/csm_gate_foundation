import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';

/// Represents an ecosystem authentication user.
class User extends EntityBase<User> {
  /// User auth username.
  String username = "";

  /// User auth password.
  String password = "";

  /// Whether the user has total access.
  bool isMaster = false;

  /// User's usage type.
  UserTypes type = UserTypes.person;

  /// User's info data.
  UserInfo userInfo = UserInfo();

  /// Creates a new instance.
  User();

  @override
  void decode(DataMap encode) {
    username = encode.get('username');
    isMaster = encode.get('isMaster');
    int typeVal = encode.get('type');

    type = UserTypes.values[typeVal];
    DataMap userInfoDataMap = encode.get('userInfo');
    userInfo = UserInfo();
    userInfo.decode(userInfoDataMap);

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        'username': username,
        'password': password,
        'isMaster': isMaster,
        'type': type.index,
        'userInfo': userInfo.encode(),
      },
    );
  }

  @override
  List<ObjectDifference> compare(User ref, [List<ObjectDifference> aggregated = const <ObjectDifference>[]]) {
    if (username != ref.username) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('username', String, username),
          username,
          ref.username,
          null,
        ),
      );
    }

    if (password != ref.password) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('password', String, password),
          password,
          ref.password,
          null,
        ),
      );
    }

    if (isMaster != ref.isMaster) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('isMaster', bool, isMaster),
          isMaster,
          ref.isMaster,
          null,
        ),
      );
    }

    if (type != ref.type) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('type', UserTypes, type),
          type,
          ref.type,
          null,
        ),
      );
    }

    List<ObjectDifference> userInfoDifferences = userInfo.compare(ref.userInfo);
    if (userInfoDifferences.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('userInfo', UserInfo, userInfo),
          null,
          null,
          userInfoDifferences,
        ),
      );
    }

    return super.compare(ref, aggregated);
  }
}

/// Represents [User] types.
enum UserTypes {
  /// When the user context is for system integration.
  integration,

  /// When the user context is for a physical person.
  person,
}
