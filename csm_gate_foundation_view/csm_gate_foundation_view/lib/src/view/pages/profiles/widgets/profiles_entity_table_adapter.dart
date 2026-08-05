import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;

/// {adapter} class.
///
/// Implements the [GateFoundationEntityTableAdapterBase] for [ProfilesEntityTable] {widget}.
final class ProfilesEntityTableAdapter extends GateFoundationEntityTableAdapterBase<Profile> {
  
  /// Creates a new [ProfilesEntityTableAdapter] instance.
  ProfilesEntityTableAdapter();

  @override
  Widget composeViewer(BuildContext buildContext, Profile entity) {
    return EntityTableViewer(
      children: <Widget>[

        /// --> Timestamp
        PropertyViewer<String>(
          label: 'Timestamp',
          value: entity.timestamp.fullDate,
        ),

        /// --> Name
        PropertyViewer<String>(
          label: 'Name',
          value: entity.name,
        ),

        /// --> Description
        PropertyViewer<String>(
          label: 'Description',
          value: entity.description ?? '---',
        ),

        const SectionDivider(text: 'Associated Permits'),

        ListViewer<Permit>(
          title: 'Permits',
          tilesContent: entity.permits,
          tileTitle:(Permit permit) => '${permit.solution} - ${permit.name}',
        ),
      ],
    );
  }

 @override
  EntityTableAdapterEditor<Profile>? composeEditor() {

    return EntityTableAdapterEditor<Profile>(
      onUpdate: (EntityTableAdapterEditorData<Profile> data) {
        List<ObjectDifference> diffs = data.entity.compare(data.entityRef);
        debugPrint('Updating profile');

        showDialog(
          context: data.context,
          builder: (BuildContext context) {
            return UpdateEntityDialog<Profile>(
              differences: diffs,
            );
          },
        );
      },

      formBuilder:(EntityTableAdapterEditorData<Profile> data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,          children: <Widget>[
            const SectionDivider(text: 'Permit details'),
            TextInput(
              width: double.infinity,
              label: 'Timestamp',
              isEnabled: false,
              controller: TextEditingController(
                text: data.entity.timestamp.fullDate,
              ),
            ),
            TextInput(
              width: double.infinity,
              label: '*Name',
              maxLength: 100,
              controller: TextEditingController(
                text: data.entity.name,
              ),
              onChanged: (String text) {
                data.entity.name = text;
              },
            ),
            TextInput(
              width: double.infinity,
              label: 'Description',
              maxLength: 200,
              controller: TextEditingController(
                text: data.entity.description,
              ),
              onChanged: (String text) {
                data.entity.description = text.cleaned;
              },
            ),
            SelectableListAsync<Permit, PermitsServiceI>(
              title: 'Available Permits',
              entityBuilder: () => Permit(),
              initialValues: data.entity.permits,
              tileTitle:(Permit permit) => '${permit.solution.name} - ${permit.name}',
              onSelect:(bool selected, Permit item) {
                if(selected){
                  if(data.entity.permits.contains(item)) return;
                  data.entity.permits.add(item);
                  return;
                }
                data.entity.permits.remove(item);
              },
            ),
          ],
        );
      },
    );
  }
}