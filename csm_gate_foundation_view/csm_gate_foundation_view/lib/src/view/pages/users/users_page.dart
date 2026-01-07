import 'package:csm_gate_foundation_view/src/view/pages/users/widgets/users_entity_table_adapter.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

///
final class UsersPage extends EntityViewPageBase<UsersEntityTableAdatper> {
  /// Creates a new instance.
  UsersPage({
    required super.adapter,
  });

  @override
  Widget compose(BuildContext context, Size windowSize, Size pageSize) {
    return UsersEntt;
  }
}
