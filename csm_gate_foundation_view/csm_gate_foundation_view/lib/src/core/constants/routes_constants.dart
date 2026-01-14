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
}
