import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/src/core/constants/routes_constants.dart';
import 'package:csm_gate_foundation_view/src/view/pages/profiles/profiles_page.dart';
import 'package:csm_gate_foundation_view/src/view/pages/profiles/whispers/create_profiles_whisper.dart';
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
    required super.routeData,
  }) : super(
         title: 'Profiles',
       );

  @override
  List<IRoutingGraphData> composeRoutes() {
    return <IRoutingGraphData>[
      RoutingGraphWhisperData<Object>(
        GateFoundationViewRouteConstants.administationCreateProfilesWhisperRoute,
        whisperOptions: WhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData){
          return CreateProfilesWhisper(
            tableAdapter: adapter,
          );
        },

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
          InjectorUtils.get<Router>().go(context, GateFoundationViewRouteConstants.administationCreateProfilesWhisperRoute);
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
