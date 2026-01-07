import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/src/view/pages/users/users_page.dart';
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
    ];
  }

  @override
  UsersEntityTableAdatper composeAdapter() {
    return UsersEntityTableAdatper();
  }

  @override
  List<IActionsRibbonNode> composeRibbonController(UsersEntityTableAdatper adapter) {
    return <IActionsRibbonNode>[
    ];
  }

  @override
  Widget? composeIcon(Color? recomdColor) {
    return Icon(
      Icons.account_box,
      color: recomdColor,
    );
  }

  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routingData) {
    return UsersPage(
      adapter: super.adapter,
    );
  }
}
