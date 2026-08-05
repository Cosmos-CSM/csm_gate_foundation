import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/src/core/constants/routes_constants.dart';
import 'package:csm_gate_foundation_view/src/view/pages/features/view_pages_features_module.dart';
import 'package:csm_gate_foundation_view/src/view/pages/features/whispers/create_features_whisper.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;

/// {category page} class.
///
/// Implements a [ICategoryLayoutPage] defining default behavior for a [FeaturesPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class FeaturesCategoryPage extends CategoryEntityViewPageBase<Feature, FeaturesEntityTableAdapter> {
  /// Creates a new [FeaturesCategoryPage] instance.
  FeaturesCategoryPage() : super(
         title: 'Permits',
         routeData: GateFoundationViewRouteConstants.featuresPageRoute,
       );

  @override
  List<IRoutingGraphData> composeRoutes() {
    return <IRoutingGraphData>[
      RoutingGraphWhisperData<Object>(
        GateFoundationViewRouteConstants.administrationCreateFeaturesWhisperRoute,
        whisperOptions: WhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData) {
          return CreateFeatureWhispers(
            tableAdapter: adapter,
          );
        }
      ),
    ];
  }

  @override
  FeaturesEntityTableAdapter composeAdapter() {
    return FeaturesEntityTableAdapter();
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
    return FeaturesPage(
      adapter: adapter,
    );
  }
  
  @override
  List<IActionsRibbonNode> composeActions(FeaturesEntityTableAdapter adapter) {
    return <IActionsRibbonNode>[
      ActionsRisbbonRefresh(
        onRefresh:(_) => adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: (BuildContext context) {
          InjectorUtils.get<Router>().go(context, GateFoundationViewRouteConstants.administrationCreateFeaturesWhisperRoute);
        },
      ),
    ];
  }
}