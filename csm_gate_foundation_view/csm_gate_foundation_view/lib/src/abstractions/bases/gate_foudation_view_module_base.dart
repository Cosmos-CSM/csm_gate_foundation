import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/src/view/pages/pages/auth_page/auth_page.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

///
abstract class GateFoundationViewModuleBase extends ViewModuleBase {
  /// Creates a new instance.
  const GateFoundationViewModuleBase({
    super.key,
  });

  @override
  @Deprecated("This method mustn't be overriden since it is being handled by the base class.")
  RoutingGraphBase bootstrapRouting() {
    return RoutingGraph(
      routes: <IRoutingGraphData>[
        RoutingGraphNode(
          RouteData(
            '',
          ),
          pageBuilder: (BuildContext ctx, RoutingData routeData) => AuthPage(
            solutionSign: '',
            onAuthSuccess: (SessionData serverSession) {},
          ),
        ),
      ],
    );
  }

  @override
  @Deprecated("This method mustn't be overriden since it is being handled by the base class.")
  List<IThemeData> bootstrapTheming() {
    return <IThemeData>[];
  }
}
