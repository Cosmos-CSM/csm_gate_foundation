import 'package:csm_view/csm_view.dart';

/// {category page} class.
///
/// Implements a [CategoryLayoutPageI] defining default behavior for a [EmployeesPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class AccountsCategoryPage extends CategoryEntityViewPageBase<AccountsEntityTableAdatper> {
  /// Creates a new instance.
  AccountsCategoryPage({
    required super.routeData,
  }) : super(
         title: 'Accounts',
         route: FoundationRoutes.accountsPageRoute,
       );

  @override
  List<RouteB> composeRoutes() {
    return <RouteB>[
      RouteWhisper<Object>(
        FoundationRoutes.accountsCreateWhisperRoute,
        whisperOptions: RouteWhisperOptions(),
        pageBuilder: (BuildContext _, RouteData _) {
          return AccountsPageCreateWhisper();
        },
      ),
    ];
  }

  @override
  AccountsEntityTableAdatper composeAdapter() {
    return AccountsEntityTableAdatper(
      authBuilder: authBuilder,
    );
  }

  @override
  List<ActionsRibbonNodeI> composeRibbonController(AccountsEntityTableAdatper adapter) {
    return <ActionsRibbonNodeI>[
      ActionsRisbbonRefresh(
        onRefresh: adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: () {
          Injector.get<Router>().go(FoundationRoutes.accountsCreateWhisperRoute);
        },
      ),
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
  PageI composePage(BuildContext buildContext, RouteData routeData) {
    return AccountsPage(
      adapter: adapter,
    );
  }
}
