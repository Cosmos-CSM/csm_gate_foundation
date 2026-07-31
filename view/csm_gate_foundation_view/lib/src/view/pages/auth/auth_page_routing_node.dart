import 'dart:async';

import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_gate_foundation_view/src/core/constants/routes_constants.dart';
import 'package:csm_gate_foundation_view/src/view/pages/auth/auth_page.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a confgured [RoutingGraph] node for [AuthPage].
final class AuthPageRoutingNode extends RoutingGraphNodeDataBase {
  AuthPageRoutingNode({
    RouteData? route,
    Redirection? redirection,
    ImageProvider<Object>? tenantImage,
    FutureOr<void> Function(BuildContext context, SessionData sessionData)? onAuthSuccess,
    required String signature,
    required RouteData authRedirected,
  }) : super(
         route ?? GateFoundationViewRouteConstants.authPageRoute,
         redirection:
             redirection ??
             (BuildContext context, RoutingData routingData) async {
               ISessionStorage sessionStorage = InjectorUtils.get();

               return sessionStorage.isLive ? authRedirected : null;
             },
         pageBuilder: (BuildContext ctx, RoutingData routeData) {
           return AuthPage(
             solutionSign: signature,
             tenantImage:
                 tenantImage ??
                 AssetImage(
                   ThemingUtils.get<IGateFoundationViewTheme>(ctx).loginBusinessLogo,
                 ),
             onAuthSuccess:
                 onAuthSuccess ??
                 (BuildContext context, SessionData sessionData) async {
                   IRouter router = InjectorUtils.get();
                     ISessionStorage sessionStorage = InjectorUtils.get();

                     sessionStorage.store(sessionData);
                     router.go(
                       context,
                       authRedirected,
                   );
                 },
           );
         },
       );
}
