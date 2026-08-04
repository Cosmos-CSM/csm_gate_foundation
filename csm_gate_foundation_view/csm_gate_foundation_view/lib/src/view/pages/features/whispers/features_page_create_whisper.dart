import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/src/data/session_storage.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Action;


/// {whisper} class.
final class FeaturePageCreateWhispers extends ViewWhisperFormBase {

  /// Controller for the creation form.
  static CreateEntityFormController _creationController = CreateEntityFormController();

  /// Creates a new [FeaturePageCreateWhispers] instance.
  const FeaturePageCreateWhispers({
    super.title = 'Create Permit(s)'
  });

  @override
  onPerform() {
    _creationController.create();
  }

  @override
  Widget composeForm(GlobalKey<FormState> formState, BuildContext context, Size windowSize, Size pageSize) {
    _creationController = CreateEntityFormController();

    return CreateEntityForm<Feature, IFeaturesService>(
      factory: () => Feature(),
      controller: _creationController,
      authFactory: (BuildContext context) {
        SessionStorage sessionStorage = InjectorUtils.get();
        return sessionStorage.token;
      },
      recordDesigner: (Feature entity, bool selected, bool valid) {
        return CreateEntityFormRecord(
          valid: valid, //TODO add this to all formdesigners
          selected: selected,
          fields: <CreateEntityFormRecordField<Object>>[
            /// --> Feature name.
            CreateEntityFormRecordField<String>(
              label: '*Name',
              value: entity.name,
            ),

            /// --> Feature description.
            CreateEntityFormRecordField<String>(
              label: 'Description',
              value: entity.description.cleaned,
            ),

            /// --> Feature enabled status.
            CreateEntityFormRecordField<String>(
              label: '*Enabled',
              value: entity.isEnabled ? 'Yes' : 'No',
            ),

            /// --> Feature reference.
            CreateEntityFormRecordField<String>(
              label: '*Reference',
              value: entity.reference,
            ),

            /// --> Feature enabled status.
            CreateEntityFormRecordField<String>(
              label: 'Permits count',
              value: entity.permits.length.toString(),
            ),
          ],
        );
      },
      formDesigner: (CreateEntityFormRecordReactor<Feature>? itemState, ScrollController scrollController) {
        final bool formDisabled = !(itemState == null);

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 12,
            children: <Widget>[
              /// --> Feature [Enabled]
              CheckboxInput(
                label: 'Is enabled',
                startChecked: itemState?.entity.isEnabled ?? false,
                onChanged: (bool? value) {
                  Feature feature = itemState!.entity;
                  feature.isEnabled = value ?? false;
                  itemState.react();
                },
              ),

              FormInputGroup(
                children: <Widget>[
                    /// --> Feature Name
                  TextInput(
                    label: '*Name',
                    isEnabled: formDisabled,
                    maxLength: 100,
                    controller: TextEditingController(
                      text: itemState?.entity.name,
                    ),
                    onChanged: (String text) {
                      Feature feature = itemState!.entity;
                      feature.name = text.cleaned;
                      itemState.react();
                    },
                  ),

                  /// --> Feature Description
                  TextInput(
                    label: 'Description',
                    isEnabled: formDisabled,
                    maxLength: 200,
                    controller: TextEditingController(
                      text: itemState?.entity.description,
                    ),
                    onChanged: (String text) {
                      Feature feature = itemState!.entity;
                      feature.description = text.cleaned;
                      itemState.react();
                    },
                  ),
                ],
              ),
              SectionBox(
                title: 'Available Permits',
                outterPadding: EdgeInsets.zero,
                child: SelectableListAsync<Permit, IPermitsService>(
                  height: 500,
                  title: 'Available Permits',
                  entityBuilder: () => Permit(),
                  initialValues: itemState.entity.permits,
                  tileTitle: (Permit permit) => permit.name,
                  onSelect: (bool selected, Permit item) {
                    itemState!.react();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
