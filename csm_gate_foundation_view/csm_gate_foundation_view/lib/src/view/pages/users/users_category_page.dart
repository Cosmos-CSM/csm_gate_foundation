import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/src/core/constants/routes_constants.dart';
import 'package:csm_gate_foundation_view/src/view/pages/users/users_page.dart';
import 'package:csm_gate_foundation_view/src/view/pages/users/whispers/create_users_whisper.dart';
import 'package:csm_gate_foundation_view/src/view/pages/users/widgets/users_entity_table.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// {category page} class.
///
/// Implements a [CategoryLayoutPageI] defining default behavior for a [EmployeesPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
class UsersCategoryPage extends CategoryEntityViewPageBase<User, UsersEntityTableAdatper> {
  /// Creates a new instance.
  UsersCategoryPage({
    required super.routeData,
  }) : super(
         title: 'Users',
       );

  @override
  List<IRoutingGraphData> composeRoutes() {
    return <IRoutingGraphData>[
      RoutingGraphWhisperData<Object>(
        GateFoundationViewRouteConstants.administrationCreateUsersWhisperRoute,
        whisperOptions: WhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData) {
          return CreateUsersWhisper(
            tableAdapter: adapter,
          );
        },
      ),
    ];
  }

  @override
  UsersEntityTableAdatper composeAdapter() {
    return UsersEntityTableAdatper();
  }

  @override
  List<IActionsRibbonNode> composeActions(UsersEntityTableAdatper adapter) {
    return <IActionsRibbonNode>[
      ActionsRisbbonRefresh(
        onRefresh: (_) {
          adapter.refresh();
        },
      ),
      ActionsRisbbonCreate(
        onCreate: (BuildContext context) {
          IRouter router = InjectorUtils.get();

          router.go(context, GateFoundationViewRouteConstants.administrationCreateUsersWhisperRoute);
        },
      ),
    ];
  }

  @override
  Widget? composeIcon(BuildContext context, Color? fgColor) {
    return Icon(
      Icons.account_box,
      color: fgColor,
    );
  }

  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routingData) {
    return UsersPage(
      adapter: super.adapter,
    );
  }
}
