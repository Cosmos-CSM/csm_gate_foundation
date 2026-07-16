import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/src/core/constants/routes_constants.dart';
import 'package:csm_gate_foundation_view/src/view/pages/profiles/profiles_page.dart';
import 'package:csm_gate_foundation_view/src/view/pages/profiles/whispers/profiles_page_create_whisper.dart';
import 'package:csm_gate_foundation_view/src/view/pages/profiles/widgets/profiles_entity_table_adapter.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;

/// {category page} class.
///
/// Implements a [ICategoryLayoutPage] defining default behavior for a [ProfilesPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class ProfilesCategoryPage extends CategoryEntityViewPageBase<Profile, ProfilesEntityTableAdapter> {
  /// Creates a new [ProfilesCategoryPage] instance.
  ProfilesCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Profiles',
         routeData: GateFoundationViewRouteConstants.profilesPageRoute,
       );

  @override
  List<IRoutingGraphData> composeRoutes() {
    return <IRoutingGraphData>[
      RoutingGraphWhisperData<Object>(
        GateFoundationViewRouteConstants.profilesCreateWhisperRoute,
        whisperOptions: WhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData) => ProfilesPageCreateWhisper(),

      ),
    ];
  }

  @override
  ProfilesEntityTableAdapter composeAdapter() {
    return ProfilesEntityTableAdapter();
  }

  @override
  List<IActionsRibbonNode> composeActions(ProfilesEntityTableAdapter adapter) {
     return <IActionsRibbonNode>[
      ActionsRisbbonRefresh(
        onRefresh:(_) => adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: (BuildContext context) {
          InjectorUtils.get<Router>().go(context, GateFoundationViewRouteConstants.profilesCreateWhisperRoute);
        },
      ),
    ];
  }

  @override
  Widget? composeIcon(_, Color? recomdColor) {
    return Icon(
      Icons.switch_account,
      color: recomdColor,
    );
  }

  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routeData) {
    return ProfilesPage(
      adapter: adapter,
    );
  }
}
