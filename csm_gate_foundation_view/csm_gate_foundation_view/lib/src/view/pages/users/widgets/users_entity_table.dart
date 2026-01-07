import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

export 'users_entity_table_adapter.dart';

/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [Account] {entity}, also handles basic available behavior.
class UsersEntityTable extends GateFoundationEntityTableBase<User, UsersEntityTableAdatper> {
  /// Creates a new [UsersEntityTable] instance.
  const UsersEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<User, GateFoundationServerResolver<ViewOutput<User>>, IUsersService>(
      entityFactory: () => User(),
      adapter: adapter,
      columns: <EntityTableColumnData<User>>[
        /// --> User
        EntityTableColumnData<User>(
          title: 'User',
          factory: (User entity, int index, BuildContext buildContext) => entity.username,
        ),

        /// --> Wildcard
        EntityTableColumnData<User>(
          title: 'Wildcard',
          factory: (User entity, int index, BuildContext buildContext) => entity.isMaster ? 'Yes' : 'No',
        ),

        /// --> Name
        EntityTableColumnData<User>(
          title: 'Name',
          factory: (User entity, int index, BuildContext buildContext) => entity.userInfo.name,
        ),

        /// --> lastname
        EntityTableColumnData<User>(
          title: 'Lastname',
          factory: (User entity, int index, BuildContext buildContext) => entity.userInfo.lastName,
        ),

        /// --> Email
        EntityTableColumnData<User>(
          title: 'Email',
          factory: (User entity, int index, BuildContext buildContext) => entity.userInfo.eMail,
        ),
      ],
    );
  }
}
