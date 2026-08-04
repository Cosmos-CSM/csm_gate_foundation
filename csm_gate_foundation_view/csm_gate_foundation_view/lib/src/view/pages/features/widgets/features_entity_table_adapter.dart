import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// {adapter} class.
///
/// Implements the [GateFoundationEntityTableAdapterBase] for [FeaturesEntityTable] {widget}.
final class FeaturesEntityTableAdapter extends GateFoundationEntityTableAdapterBase<Feature> {
  /// Creates a new [FeaturesEntityTableAdapter] instance.
  FeaturesEntityTableAdapter();

  @override
  Widget composeViewer(BuildContext buildContext, Feature entity) {
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
          value: entity.description,
        ),

        /// --> Description
        PropertyViewer<String>(
          label: 'Reference',
          value: entity.reference,
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
  EntityTableAdapterEditor<Feature>? composeEditor() {

    return EntityTableAdapterEditor<Feature>(
      onUpdate: (EntityTableAdapterEditorData<Feature> data) {
        List<ObjectDifference> diffs = data.entity.compare(data.entityRef);
        debugPrint('Updating user');

        showDialog(
          context: data.context,
          builder: (BuildContext context) {
            return UpdateEntityDialog<User>(
              differences: diffs,
            );
          },
        );
      },

      formBuilder:(EntityTableAdapterEditorData<Feature> data) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            spacing: 20,
            children: <Widget>[

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

              TextInput(
                width: double.infinity,
                label: 'Reference',
                maxLength: 8,
                controller: TextEditingController(
                  text: data.entity.reference,
                ),
                onChanged: (String text) {
                  data.entity.reference = text.cleaned;
                },
              ),

              SelectableListAsync<Permit, IPermitsService>(
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
          ),
        );
      },
    );
  }
}