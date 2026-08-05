import 'package:csm_view/csm_view.dart';

///
final class GateFoundationViewRouteConstants {
  ///
  static const RouteData authPageRoute = RouteData(
    '',
    name: 'auth_page',
  );

  ///
  static const RouteData homePageRoute = RouteData(
    'gate_home',
    name: 'gate_home',
  );

  ///
  static const RouteData administrationPageRoute = RouteData(
    'administration',
    name: 'administration',
  );

  static const RouteData administrationUsersPageRoute = RouteData(
    'users',
    name: 'administration_users',
  );

  static const RouteData administrationCreateUsersWhisperRoute = RouteData(
    'users_create',
    name: 'administration_users_create',
  );

   //! --> Permits Routes
  static const RouteData permitsPageRoute = RouteData(
    'permits',
    name: 'administation_permits',
  );

  static const RouteData administrationCreatePermitsWhisperRoute = RouteData(
    'create-permits',
    name: 'administration_permits_create',
  );
  //! <-- Permits Routes

  //! --> Profiles Routes
  static const RouteData profilesPageRoute = RouteData(
    'profiles',
    name: 'administration_profiles',
  );

  static const RouteData administationCreateProfilesWhisperRoute = RouteData(
    'create-profiles',
    name: 'administration_profiles_create',
  );
  //! <-- Profiles Routes

    //! --> Features Routes
  static const RouteData featuresPageRoute = RouteData(
    'features',
    name: 'administration_profiles',
  );

  static const RouteData administrationCreateFeaturesWhisperRoute = RouteData(
    'create-features',
    name: 'administration_features_create',
  );
  //! <-- Profiles Routes

}
