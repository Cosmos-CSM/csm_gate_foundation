import 'dart:async';

import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_gate_foundation_view/src/core/constants/routes_constants.dart';
import 'package:csm_gate_foundation_view/src/core/theming/gate_foundation_view_dark_theme.dart';
import 'package:csm_gate_foundation_view/src/view/pages/pages/auth_page/auth_page.dart';
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

  @override
  @Deprecated("This method mustn't be overriden since it is being handled by the base class.")
  List<IRoutingGraphData> bootstrapRouting() {
    return <IRoutingGraphData>[
      RoutingGraphNode(
        GateFoundationViewRouteConstants.authPageRoute,
        pageBuilder: (BuildContext ctx, RoutingData routeData) => AuthPage(
          solutionSign: signature,
          tenanImage: AssetImage(
            ThemingUtils.get<IGateFoundationViewTheme>(ctx).loginBusinessLogo,
          ),
          onAuthSuccess: (SessionData serverSession) {},
        ),
      ),
    ];
  }

  @override
  @Deprecated("This method mustn't be overriden since it is being handled by the base class.")
  List<IThemeData> bootstrapTheming() {
    return <IThemeData>[
      GateFoundationViewDarkTheme(),
    ];
  }

  @override
  FutureOr<void> initView() {
    /// --> Initializing { Gate Foundation Server Client }
    GateFoundationServer gateFoundationServer = GateFoundationServer(
      sign: 'CSMGF',
      isRelease: !kDebugMode,
    );

    InjectorUtils.addSingleton(gateFoundationServer);
    InjectorUtils.addSingleton<IAuthService>(gateFoundationServer.authService);
  }
}
