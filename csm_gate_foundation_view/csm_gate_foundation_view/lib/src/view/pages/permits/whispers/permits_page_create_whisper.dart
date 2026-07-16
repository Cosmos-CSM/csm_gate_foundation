import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/src/data/session_storage.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Action;


/// {whisper} class.
final class PermitsPageCreateWhispers extends ViewWhisperFormBase {

  /// Controller for the creation form.
  static CreateEntityFormController _creationController = CreateEntityFormController();

  /// Creates a new [PermitsPageCreateWhispers] instance.
  const PermitsPageCreateWhispers({
    super.title = 'Create Permit(s)'
  });

  @override
  onPerform() {
    _creationController.create();
  }

  @override
  Widget composeForm(GlobalKey<FormState> formState, BuildContext context, Size windowSize, Size pageSize) {
    _creationController = CreateEntityFormController();

    return CreateEntityForm<Permit, IPermitsService>(
      factory: () => Permit(),
      controller: _creationController,
      authFactory: (BuildContext context) {
        SessionStorage sessionStorage = InjectorUtils.get();
        return sessionStorage.token;
      },
      recordDesigner: (Permit entity, bool selected, bool valid) {
        return CreateEntityFormRecord(
          selected: selected,
          fields: <CreateEntityFormRecordField<Object>>[

            /// --> Permit name.
            CreateEntityFormRecordField<String>(
              label: '*Reference code',
              value: entity.reference.cleaned,
            ),

            /// --> Permit name.
            CreateEntityFormRecordField<String>(
              label: '*Name',
              value: entity.name,
            ),

            /// --> Permit description.
            CreateEntityFormRecordField<String>(
              label: 'Description',
              value: entity.description.cleaned,
            ),
            
            /// --> Permit enabled status.
            CreateEntityFormRecordField<String>(
              label: '*Enabled',
              value: entity.enabled? 'Yes' : 'No',
            ),

            /// --> Solution.
            CreateEntityFormRecordField<String>(
              label: 'Solution',
              value: entity.solution.name.cleaned,
            ),

            /// --> Feature.
            CreateEntityFormRecordField<String>(
              label: 'Feature',
              value: entity.feature.name.cleaned ,
            ),

            /// --> Action.
            CreateEntityFormRecordField<String>(
              label: 'Action',
              value: entity.action.name.cleaned,
            ),
            
          ],
        );
      },
      formDesigner: (CreateEntityFormRecordReactor<Permit>? itemState, ScrollController scrollController) {
        final bool formDisabled = !(itemState == null);

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 12,
            children: <Widget>[
              /// --> Permits enabled status
              OptionsSelector<bool>(
                height: 100,
                title: 'Enabled',
                preSelected: <bool>[itemState!.entity.enabled],
                options: <OptionsSelectorOption<bool>>[
                  OptionsSelectorOption<bool>(
                    title: 'Enabled',
                    value: true,
                  ),
                  OptionsSelectorOption<bool>(
                    title: 'Disabled',
                    value: false,
                  ),
                ],
                onSelect: (List<bool> selected) {
                  itemState.entity.enabled = selected.first;
                },
              ),
              Row(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// --> Reference code
                  Expanded(
                    child: TextInput(
                      label: '*Reference code',
                      isEnabled: formDisabled,
                      maxLength: 8,
                      isFixedLength: true,
                      controller: TextEditingController(
                        text: itemState.entity.reference,
                      ),
                      onChanged: (String text) {
                        Permit permit = itemState.entity;
                        permit.reference = text;
                        itemState.react();
                      },
                    ),
                  ),
        
                  /// --> Contact Name
                  Expanded(
                    child: TextInput(
                      label: '*Name',
                      isEnabled: formDisabled,
                      maxLength: 100,
                      controller: TextEditingController(
                        text: itemState.entity.name,
                      ),
                      onChanged: (String text) {
                        Permit permit = itemState.entity;
                        permit.name = text;
                        itemState.react();
                      },
                    ),
                  ),
                ],
              ),
        
              Row(
                spacing: 10,
                children: <Widget>[
        
                  /// --> Description
                  Expanded(
                    child: TextInput(
                      label: 'Description',
                      isEnabled: formDisabled,
                      maxLength: 200,
                      controller: TextEditingController(
                        text: itemState.entity.description,
                      ),
                      onChanged: (String text) {
                        Permit permit = itemState.entity;
                        permit.description = text.cleaned;
                        itemState.react();
                      },
                    ),
                  ),
        
                  /// --> Solution
                  Expanded(
                    child: Entity<Solution, SolutionsServiceI>(
                      entityBuilder: () => Solution(),
                      label: 'Select a Solution...',
                      initialValue: itemState.entity.solution,
                      textBuilder: (Solution solution) {
                        return solution.name;
                      },
                      onSelected: (Solution? solution) {
                        itemState.entity.solution = solution ?? Solution();
                        itemState.react();
                      },
                    ),
                  ),
                ],
              ),
        
              Row(
                spacing: 10,
                children: <Widget>[
                  /// --> Feature
                  Expanded(
                    child: EntityFinderSelector<Feature, FeaturesServiceI>(
                      entityBuilder: () => Feature(),
                      label: 'Select a Feature...',
                      initialValue: itemState.entity.feature,
                      textBuilder: (Feature feature) {
                        return feature.name;
                      },
                      onSelected: (Feature? feature) {
                        itemState.entity.feature = feature ?? Feature();
                        itemState.react();
                      },
                    ),
                  ),
                  /// --> Feature
                  Expanded(
                    child: EntityFinderSelector<Action, ActionsServiceI>(
                      entityBuilder: () => Action(),
                      label: 'Select an Action...',
                      initialValue: itemState.entity.action,
                      textBuilder: (Action action) {
                        return action.name;
                      },
                      onSelected: (Action? action) {
                        itemState.entity.action = action ?? Action();
                        itemState.react();
                      },
                    ),
                  ),
                ],
              ),
            
            ],
          ),
        );
      },
    );
  }
}
