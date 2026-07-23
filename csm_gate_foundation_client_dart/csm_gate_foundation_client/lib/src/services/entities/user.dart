import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/core/constants/core_properties_consts.dart';
import 'package:csm_gate_foundation_client/src/core/utilities/entity_utilities.dart';

/// [User] default builder.
User userBuilder() => User();

/// Represents an ecosystem authentication user.
class User extends EntityBase<User> {

  /// [User.username] property key.
  static const String kUsername = "username";
  /// [User.password] property key.
  static const String kPassword = "password";
  /// [User.isMaster] property key.
  static const String kIsMaster = "isMaster";
  /// [User.type] property key.
  static const String kType = "type";
  /// [User.permits] property key.
  static const String kPermits = "permits";
  /// [User.profiles] property key.
  static const String kProfiles = "profiles";
  /// [User.vendors] property key.
  static const String kVendors = "vendors";

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

  /// [Permit]s related to this accounts.
  List<Permit> permits = <Permit>[];
  
  /// [Profile]s related to this accounts.
  List<Profile> profiles = <Profile>[];

  /// [Vendor]s related to this accounts.
  List<Vendor> vendors = <Vendor>[];

  /// Creates a new instance.
  User();

  @override
  void decode(DataMap encode) {
    username = encode.get(kUsername);
    password = encode.get(kPassword);
    isMaster = encode.get(kIsMaster);
    int typeVal = encode.get(kType);

    type = UserTypes.values[typeVal];
    DataMap userInfoDataMap = encode.get(FoundationCommonPropertyKeys.kUserInfo);
    userInfo = UserInfo();
    userInfo.decode(userInfoDataMap);

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

    List<DataMap> profilesMaps = encode.getList(kProfiles);
    if (profilesMaps.isNotEmpty) {
      profiles = profilesMaps.map<Profile>(
        (DataMap e) {
          Profile profile = Profile();
          profile.decode(e);
          return profile;
        },
      ).toList();
    }

    List<DataMap> vendorsMaps = encode.getList(kVendors);
    if (vendorsMaps.isNotEmpty) {
      vendors = vendorsMaps.map<Vendor>(
        (DataMap e) {
          Vendor vendor = Vendor();
          vendor.decode(e);
          return vendor;
        },
      ).toList();
    }

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kUsername: username,
        kPassword: password,
        kIsMaster: isMaster,
        kType: type.index,
        FoundationCommonPropertyKeys.kUserInfo: userInfo.encode(),
        kPermits: permits.map((Permit e) => e.encode()).toList(),
        kProfiles: profiles.map((Profile e) => e.encode()).toList(),
        kVendors: vendors.map((Vendor e) => e.encode()).toList(),
      },
    );
  }

  @override
  List<ObjectDifference> compare(User ref, [List<ObjectDifference>? aggregated]) {
    aggregated ??= <ObjectDifference>[];

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

    for(Profile profile in profiles){
      Profile? refProfile = ref.profiles.firstWhere((Profile e) => e.id == profile.id, orElse: () => Profile());
      List<ObjectDifference> profilediff = profile.compare(refProfile);

      if (profilediff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kProfiles, Profile, profile),
            profile,
            refProfile,
            profilediff,
          ),
        );
      }
    }
  
    for (Vendor vendor in vendors) {
      Vendor? refVendor = ref.vendors.firstWhere((Vendor e) => e.id == vendor.id, orElse: () => Vendor());
      List<ObjectDifference> vendorDiff = vendor.compare(refVendor);

      if (vendorDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kVendors, Vendor, vendor),
            vendor,
            refVendor,
            vendorDiff,
          ),
        );
      }
    }

    return super.compare(ref, aggregated);
  }

   @override
  List<EntityErrors<User>> evaluate(List<EntityErrors<User>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<User>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }

    if (username.trim().isEmpty || username.length > 50) {
      errors.add(
        EntityErrors<User>(
          this,
          PropertyInfo(kUsername, String, username),
          CoreEntityErrorReasonsConsts.invalidLength,
          'Between 1 and 50 characters',
        ),
      );
    }
    
    errors.validateDependency(this, userInfo);

    if (permits.isNotEmpty) {
      for (Permit permit in permits) {
        errors.validateDependency(this, permit);
      }
    }

    if (profiles.isNotEmpty) {
      for (Profile profile in profiles) {
        errors.validateDependency(this, profile);
      }
    }

    if (vendors.isNotEmpty) {
      for (Vendor vendor in vendors) {
        errors.validateDependency(this, vendor);
      }
    }

    return errors;
  }
}

/// Represents [User] types.
enum UserTypes {
  /// When the user context is for system integration.
  integration,

  /// When the user context is for a physical person.
  person,
}
