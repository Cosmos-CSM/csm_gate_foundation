import 'dart:async';

import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_gate_foundation_view/src/data/session_storage.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Action;


/// {whisper} class.
final class CreatePermitsWhispers extends ViewWhisperFormBase {
  /// Form controller.
  final CreateEntityFormController controller = CreateEntityFormController();

  /// [PermitsCategoryPage] inner entity table adapter.
  final PermitsEntityTableAdapter tableAdapter;

  /// Creates a new [CreatePermitsWhispers] instance.
  CreatePermitsWhispers({
    required this.tableAdapter,
  }) : super(
         title: 'Create Permits',
       );
  @override
  FutureOr<void> onClose() {
    tableAdapter.refresh();
  }

  @override
  onPerform() {
    controller.create();
  }

  @override
  Widget composeForm(GlobalKey<FormState> formState, BuildContext context, Size windowSize, Size pageSize) {

    return CreateEntityForm<Permit, IPermitsService>(
      factory: () => Permit(),
      controller: controller,
      onClose: onClose,
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

        return Column(
          spacing: 12,
          children: <Widget>[
            /// --> Permit´s [IsEnabled] status.
            CheckboxInput(
              label: 'Is Enabled',
              startChecked: itemState?.entity.isEnabled ?? false,
              onChanged: (bool? value) {
                Permit permit = itemState!.entity;
                permit.isEnabled = value ?? false;
                itemState.react();
              },
            ),
            
            FormInputGroup(
              spacing: 16,
              children: <Widget>[
                /// --> Reference code
                TextInput(
                  label: '*Reference code',
                  isEnabled: formDisabled,
                  maxLength: 8,
                  isFixedLength: true,
                  controller: TextEditingController(
                    text: itemState?.entity.reference,
                  ),
                  onChanged: (String text) {
                    Permit permit = itemState!.entity;
                    permit.reference = text;
                    itemState.react();
                  },
                ),
                
                /// --> Contact Name
                TextInput(
                  label: '*Name',
                  isEnabled: formDisabled,
                  maxLength: 100,
                  controller: TextEditingController(
                    text: itemState?.entity.name,
                  ),
                  onChanged: (String text) {
                    Permit permit = itemState!.entity;
                    permit.name = text;
                    itemState.react();
                  },
                ),
              ],
            ),
                
            FormInputGroup(
              spacing: 16,
              children: <Widget>[
                
                /// --> Description
                TextInput(
                  label: 'Description',
                  isEnabled: formDisabled,
                  maxLength: 200,
                  controller: TextEditingController(
                    text: itemState?.entity.description,
                  ),
                  onChanged: (String text) {
                    Permit permit = itemState!.entity;
                    permit.description = text.cleaned;
                    itemState.react();
                  },
                ),
                
                /// --> Solution
                Entity<Solution, ISolutionsService>(
                  entityBuilder: () => Solution(),
                  label: 'Select a Solution...',
                  initialValue: itemState?.entity.solution,
                  textBuilder: (Solution solution) {
                    return solution.name;
                  },
                  onSelected: (Solution? solution) {
                    itemState!.entity.solution = solution ?? Solution();
                    itemState.react();
                  },
                ),
              ],
            ),
                
            FormInputGroup(
              spacing: 10,
              children: <Widget>[
                /// --> Feature
                EntityFinderSelector<Feature, IFeaturesService>(
                  entityBuilder: () => Feature(),
                  label: 'Select a Feature...',
                  initialValue: itemState?.entity.feature,
                  textBuilder: (Feature feature) {
                    return feature.name;
                  },
                  onSelected: (Feature? feature) {
                    itemState!.entity.feature = feature ?? Feature();
                    itemState.react();
                  },
                ),
                /// --> Feature
                EntityFinderSelector<Action, IActionsService>(
                  entityBuilder: () => Action(),
                  label: 'Select an Action...',
                  initialValue: itemState?.entity.action,
                  textBuilder: (Action action) {
                    return action.name;
                  },
                  onSelected: (Action? action) {
                    itemState!.entity.action = action ?? Action();
                    itemState.react();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
