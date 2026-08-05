import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog, Action;

/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [Profile] {entity}, also handles basic available behavior.
final class ProfilesEntityTable extends GateFoundationEntityTableBase<Profile, ProfilesEntityTableAdapter> {
  /// Creates a new [ProfilesEntityTable] instance.
  const ProfilesEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<Profile, ResponseResolverBase<ViewOutput<Profile>>, IProfilesService>(
      factory: () => Profile(),
      adapter: adapter,
      columns: <EntityTableColumnData<Profile>>[
        /// --> Name
        EntityTableColumnData<Profile>(
          title: 'Name',
          factory: (Profile entity, int index, BuildContext buildContext) => entity.name,
        ),

        /// --> Description
        EntityTableColumnData<Profile>(
          title: 'Description',
          factory: (Profile entity, int index, BuildContext buildContext) => entity.description ?? '---',
        ),

        /// --> Associated permits
        EntityTableColumnData<Profile>(
          title: 'associated permits',
          factory: (Profile entity, int index, BuildContext buildContext) => entity.permits.length.toString(),
        ),
      ],
    );
  }
}
