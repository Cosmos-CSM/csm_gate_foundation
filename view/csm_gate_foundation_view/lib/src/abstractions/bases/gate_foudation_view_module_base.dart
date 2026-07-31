import 'dart:async';

import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_gate_foundation_view/src/core/constants/routes_constants.dart';
import 'package:csm_gate_foundation_view/src/core/theming/gate_foundation_view_dark_theme.dart';
import 'package:csm_gate_foundation_view/src/core/utils/developer_gate_utils.dart';
import 'package:csm_gate_foundation_view/src/data/session_storage.dart';
import 'package:csm_gate_foundation_view/src/view/pages/auth/auth_page_routing_node.dart';
import 'package:csm_gate_foundation_view/src/view/pages/home/gate_foundation_home_page.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///
abstract class GateFoundationViewModuleBase extends ViewModuleBase {
  /// Solution module signature identificator.
  final String signature;

  /// Creates a new instance.
  const GateFoundationViewModuleBase({
    super.key,
    required this.signature,
  });

  /// Provides authentication user for development purposes ignoring login page and moving forward to the system home page.
  @protected
  AuthInput? developmentUser() => null;

  @override
  @Deprecated("This method mustn't be overriden since it is being handled by the base class.")
  List<IRoutingGraphData> bootstrapRouting() {
    return <IRoutingGraphData>[
      AuthPageRoutingNode(
        signature: signature,
        authRedirected: GateFoundationViewRouteConstants.homePageRoute,
      ),
      NavigationLayoutRoutingGraphData(
        homeRouteData: GateFoundationViewRouteConstants.homePageRoute,
        routes: <IRoutingGraphData>[
          RoutingGraphNode(
            GateFoundationViewRouteConstants.homePageRoute,
            pageBuilder: (BuildContext ctx, RoutingData routeData) => GateFoundationHomePage(),
          ),
          CategoryLayoutRoutingGraphData(
            pages: <ICategoryLayoutPage>[
              UsersCategoryPage(
                routeData: GateFoundationViewRouteConstants.administrationUsersPageRoute,
              ),
            ],
          ),
        ],
        navigationNodes: <INavigationLayoutNode>[
          NavigationLayoutNode(
            title: 'Administration',
            routeData: GateFoundationViewRouteConstants.administrationUsersPageRoute,
            icon: Icons.admin_panel_settings,
          ),
        ],
      ),
    ];
  }

  @override
  List<IThemeData> bootstrapTheming() {
    return <IThemeData>[
      GateFoundationViewDarkTheme(),
    ];
  }

  @override
  FutureOr<void> initView(BuildContext context) async {
    await initLocalStorage();

    /// --> Initializing { Gate Foundation Server Client }
    GateFoundationServer gateFoundationServer = GateFoundationServer(
      sign: 'CSMGF',
      isRelease: !kDebugMode,
      prodHost: Uri(
        'localhost',
        '',
        port: 5195,
      ),
    );

    InjectorUtils.addSingleton(gateFoundationServer);

    InjectorUtils.addSingleton<IAuthService>(gateFoundationServer.authService);
    InjectorUtils.addSingleton<IUsersService>(gateFoundationServer.usersService);

    InjectorUtils.addSingleton<ISessionStorage>(SessionStorage(signature));

    AuthInput? devAuth = developmentUser();
    if (kDebugMode && devAuth != null) {
      await DeveloperGateUtils.setUser(devAuth);
    }
  }
}
