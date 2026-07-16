import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/src/data/session_storage.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Action;

/// {whisper} class.
final class ProfilesPageCreateWhisper extends ViewWhisperFormBase {

  /// Controller for the creation form.
  static CreateEntityFormController _creationController = CreateEntityFormController();


  /// Creates a new [ProfilesPageCreateWhisper] instance.
  const ProfilesPageCreateWhisper({
    super.title = 'Create Profile(s)'
  });

  @override
  onPerform() {
    _creationController.create();
  }

  @override
  Widget composeForm(GlobalKey<FormState> formState, BuildContext context, Size windowSize, Size pageSize) {
    _creationController = CreateEntityFormController();
    return CreateEntityForm<Profile, IProfilesService>(
      factory: () => Profile(),
      controller: _creationController,
      authFactory: (BuildContext context) {
        SessionStorage sessionStorage = InjectorUtils.get();
        return sessionStorage.token;
      },
      recordDesigner: (Profile entity, bool selected, bool valid) {
        return CreateEntityFormRecord(
          selected: selected,
          fields: <CreateEntityFormRecordField<Object>>[

            /// --> Profile name.
            CreateEntityFormRecordField<String>(
              label: '*Name',
              value: entity.name,
            ),

            /// --> Profile description.
            CreateEntityFormRecordField<String>(
              label: 'Description',
              value: entity.description.cleaned,
            ),
            
            /// --> Profile permits.
            for(int i = 0; i < entity.permits.length; i++)
            CreateEntityFormRecordField<String>(
              label: 'Permit #${i+1}',
              value: entity.permits[i].name,
            ),
          ],
        );
      },
      formDesigner: (CreateEntityFormRecordReactor<Profile>? itemState, ScrollController scrollController) {
        final bool formDisabled = !(itemState == null);
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 12,
            children: <Widget>[
              Row(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// --> Profile Name
                  Expanded(
                    child: TextInput(
                      label: '*Name',
                      isEnabled: formDisabled,
                      maxLength: 100,
                      controller: TextEditingController(
                        text: itemState?.entity.name,
                      ),
                      onChanged: (String text) {
                        Profile profile = itemState!.entity;
                        profile.name = text;
                        itemState.react();
                      },
                    ),
                  ),
                    /// --> Description
                  Expanded(
                    child: TextInput(
                      label: 'Description',
                      isEnabled: formDisabled,
                      maxLength: 200,
                      controller: TextEditingController(
                        text: itemState?.entity.description,
                      ),
                      onChanged: (String text) {
                        Profile profile = itemState!.entity;
                        profile.description = text.cleaned;
                        itemState.react();
                      },
                    ),
                  ),
                ],
              ),
              SelectableListAsync<Permit, IPermitsService>(
                height: 500,
                title: 'Available Permits',
                entityBuilder: () => Permit(),
                initialValues: itemState?.entity.permits,
                tileTitle:(Permit permit) => '${permit.solution.name} - ${permit.name}',
                onSelect:(bool selected, Permit item) {
                  itemState?.react();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
