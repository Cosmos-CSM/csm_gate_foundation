import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Action;
import 'package:flutter/widgets.dart' hide Router, Action;

/// {adapter} class.
///
/// Implements the [GateFoundationEntityTableAdapterBase] for [PermitsEntityTable] {widget}.
final class PermitsEntityTableAdapter extends GateFoundationEntityTableAdapterBase<Permit> {

  /// Creates a new [PermitsEntityTableAdapter] instance.
  PermitsEntityTableAdapter();

  @override
  Widget composeViewer(BuildContext buildContext, Permit entity) {
    return EntityTableViewer(
      children: <Widget>[

        /// --> Timestamp
        PropertyViewer<String>(
          label: 'Timestamp',
          value: entity.timestamp.fullDate,
        ),

        /// --> Reference
        PropertyViewer<String>(
          label: 'Reference code',
          value: entity.reference,
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

        /// --> Email
        PropertyViewer<String>(
          label: 'Enabled',
          value: entity.isEnabled? 'Yes' : 'No',
        ),

        /// --> Solution 
        PropertyViewer<String>(
          label: 'Solution',
          value: entity.solution.name,
        ),

        SectionDivider(text: 'Feature details'),

        /// --> Feature name 
        PropertyViewer<String>(
          label: 'Feature',
          value: entity.feature.name,
        ),

        /// --> Feature enabled status
        PropertyViewer<String>(
          label: 'Feature enabled',
          value: entity.feature.enabled? 'Yes' : 'No',
        ),

        SectionDivider(text: 'Action details'),

        /// --> Action name 
        PropertyViewer<String>(
          label: 'Action',
          value: entity.action.name,
        ),

        /// --> Action enabled status
        PropertyViewer<String>(
          label: 'Action enabled',
          value: entity.action.isEnabled? 'Yes' : 'No',
        ),
      ],
    );
  }

 @override
  EntityTableAdapterEditor<Permit>? composeEditor() {

    return EntityTableAdapterEditor<Permit>(
      onUpdate: (EntityTableAdapterEditorData<Permit> data) {
        List<ObjectDifference> diffs = data.entity.compare(data.entityRef);
        debugPrint('Updating Permit');

        showDialog(
          context: data.context,
          builder: (BuildContext context) {
            return UpdateEntityDialog<Permit>(
              differences: diffs,
            );
          },
        );
      },

      formBuilder:(EntityTableAdapterEditorData<Permit> data) {
        return Column(
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
            OptionsSelector<bool>(
              title: 'Enabled',
              preSelected: <bool>[data.entity.enabled],
              options:  <OptionsSelectorOption<bool>>[
                OptionsSelectorOption<bool>(
                  title: 'Yes',
                  value: true,
                ),
                OptionsSelectorOption<bool>(
                  title: 'No',
                  value: false,
                ),
              ],
              onSelect: (List<bool> selected) {
                data.entity.enabled = selected.firstOrNull ?? false;
              },
            ),
            TextInput(
              width: double.infinity,
              label: '*Reference code',
              maxLength: 8,
              isFixedLength: true,
              controller: TextEditingController(
                text: data.entity.reference,
              ),
              onChanged: (String text) {
                data.entity.reference = text;
              },
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
                data.entity.description = text.;
              },
            ),
            EntityFinderSelector<Solution, SolutionsServiceI>(
              entityBuilder: () => Solution(),
              label: '*Select a Solution...',
              initialValue: data.entity.solution,
              textBuilder: (Solution solution) {
                return solution.name;
              },
              onSelected: (Solution? solution) {
                data.entity.solution = solution ?? Solution();
              },
            ),
            EntityFinderSelector<Feature, FeaturesServiceI>(
              entityBuilder: () => Feature(),
              label: '*Select a Feature...',
              initialValue: data.entity.feature,
              textBuilder: (Feature feature) {
                return feature.name;
              },
              onSelected: (Feature? feature) {
                data.entity.feature = feature ?? Feature();
              },
            ),
            EntityFinderSelector<Action, IActionsService>(
              entityBuilder: () => Action(),
              label: '*Select an Action...',
              initialValue: data.entity.action,
              textBuilder: (Action action) {
                return action.name;
              },
              onSelected: (Action? action) {
                data.entity.action = action ?? Action();
              },
            ),
          ],
        );
      },
    );
  }
}