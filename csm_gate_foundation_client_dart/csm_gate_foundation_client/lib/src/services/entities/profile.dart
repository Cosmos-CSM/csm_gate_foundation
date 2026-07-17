import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_client/src/core/utilities/entity_utilities.dart';

/// {implementation} class for an [EntityI].
///
///  [Entity] that stores a relation between a collection of [Permit] with an [Account].
final class Profile extends CatalogEntityBase<Profile> {

  /// [Profile.permits] property key.
  static const String kPermits = 'permits';

  /// [Profile.users] property key.
  static const String kUsers = 'users';

  /// [Permit]s related to this profile.
  List<Permit> permits = <Permit>[];

  /// [User]s related to this profile.
  List<User> users = <User>[];

  /// Creates a new instance.
  Profile();

  @override
  List<ObjectDifference> compare(Profile ref, [List<ObjectDifference>? aggregated]) {
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

    for(User user in users){
      User? refUser = ref.users.firstWhere((User e) => e.id == user.id, orElse: () => User());
      List<ObjectDifference> userDiff = user.compare(refUser);

      if (userDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kUsers, User, user),
            user,
            refUser,
            userDiff,
          ),
        );
      }
    }

    return super.compare(ref, aggregated);
  }

  @override
  void decode(DataMap encode) {
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

    List<DataMap> usersMaps = encode.getList(kUsers);
    if (usersMaps.isNotEmpty) {
      users = usersMaps.map<User>(
        (DataMap e) {
          User user = User();
          user.decode(e);
          return user;
        },
      ).toList();
    }

    super.decode(encode);
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
        kUsers: users
          .map(
            (User e) => e.encode(),
          )
          .toList(),
      },
    );
  }

  @override
  List<EntityErrors<Profile>> evaluate(List<EntityErrors<Profile>> errors) {
    errors = super.evaluate(errors);
    
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Profile>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    
    if (name.trim().isEmpty || name.length > 100) {
      errors.add(
        EntityErrors<Profile>(
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
          EntityErrors<Profile>(
            this,
            PropertyInfo(CorePropertiesConsts.description, String, description),
            CoreEntityErrorReasonsConsts.invalidLength,
            'Between 1 and 200 characters',
          ),
        );
      }
    }

    if (permits.isNotEmpty) {
      for (Permit permit in permits) {
        errors.validateDependency(this, permit);
      }
    }

    if (users.isNotEmpty) {
      for (User user in users) {
        errors.validateDependency(this, user);
      }
    }

    return errors;
  }
  
}

