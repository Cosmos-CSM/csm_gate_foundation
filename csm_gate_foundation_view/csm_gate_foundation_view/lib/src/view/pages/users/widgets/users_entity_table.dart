import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_gate_foundation_view/src/view/abstractions/bases/gate_foundation_entity_table_base.dart';
import 'package:csm_gate_foundation_view/src/view/pages/users/widgets/users_entity_table_adapter.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [Account] {entity}, also handles basic available behavior.
class UsersEntityTable extends GateFoundationEntityTableBase<UsersEntityTableAdatper> {
  /// Creates a new [UsersEntityTable] instance.
  const UsersEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<User, GateFoundationServerResolver<ViewOutput<User>>, IAuthService>(
      entityFactory: () => User(),
      adapter: adapter,
      columns: <EntityTableColumnOptions<Account>>[
        /// --> User
        EntityTableColumnOptions<Account>(
          title: 'User',
          factory: (Account entity, int index, BuildContext buildContext) => entity.user,
        ),

        /// --> Wildcard
        EntityTableColumnOptions<Account>(
          title: 'Wildcard',
          factory: (Account entity, int index, BuildContext buildContext) => entity.wildcard ? 'Yes' : 'No',
        ),

        /// --> Name
        EntityTableColumnOptions<Account>(
          title: 'Name',
          factory: (Account entity, int index, BuildContext buildContext) => entity.contact.name,
        ),

        /// --> lastname
        EntityTableColumnOptions<Account>(
          title: 'Lastname',
          factory: (Account entity, int index, BuildContext buildContext) => entity.contact.lastName,
        ),

        /// --> Email
        EntityTableColumnOptions<Account>(
          title: 'Email',
          factory: (Account entity, int index, BuildContext buildContext) => entity.contact.eMail,
        ),

        /// --> Profiles
        EntityTableColumnOptions<Account>(
          title: 'Profiles',
          factory: (Account entity, int index, BuildContext buildContext) => entity.profiles.length.toString(),
        ),

        /// --> Permits
        EntityTableColumnOptions<Account>(
          title: 'Permits',
          factory: (Account entity, int index, BuildContext buildContext) => entity.permits.length.toString(),
        ),
      ],
    );
  }
}
