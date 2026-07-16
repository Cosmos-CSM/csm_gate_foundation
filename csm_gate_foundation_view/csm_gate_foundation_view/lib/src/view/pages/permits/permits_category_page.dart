import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/src/core/constants/routes_constants.dart';
import 'package:csm_gate_foundation_view/src/view/pages/permits/permits_page.dart';
import 'package:csm_gate_foundation_view/src/view/pages/permits/whispers/permits_page_create_whisper.dart';
import 'package:csm_gate_foundation_view/src/view/pages/permits/widgets/permits_entity_table_adapter.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;

/// {category page} class.
///
/// Implements a [ICategoryLayoutPage] defining default behavior for a [PermitsPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class PermitsCategoryPage extends CategoryEntityViewPageBase<Permit, PermitsEntityTableAdapter> {
  /// Creates a new [PermitsCategoryPage] instance.
  PermitsCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Permits',
         routeData: FoundationRoutes.permitsPageRoute,
       );

  @override
  List<IRoutingGraphData> composeRoutes() {
    return <IRoutingGraphData>[
      RoutingGraphWhisperData<Object>(
        FoundationRoutes.permitsCreateWhisperRoute,
        whisperOptions: WhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData) => PermitsPageCreateWhisper(),
      ),
    ];
  }

  @override
  PermitsEntityTableAdapter composeAdapter() {
    return PermitsEntityTableAdapter();
  }

  @override
  Widget? composeIcon(_, Color? recomdColor) {
    return Icon(
      Icons.workspace_premium_outlined,
      color: recomdColor,
    );
  }

  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routeData) {
    return PermitsPage(
      adapter: adapter,
    );
  }
  
  @override
  List<IActionsRibbonNode> composeActions(PermitsEntityTableAdapter adapter) {
    return <IActionsRibbonNode>[
      ActionsRisbbonRefresh(
        onRefresh:(_) => adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: (BuildContext context) {
          InjectorUtils.get<Router>().go(context, GateFoundationViewRouteConstants.permitsCreateWhisperRoute);
        },
      ),
    ];
  }
}