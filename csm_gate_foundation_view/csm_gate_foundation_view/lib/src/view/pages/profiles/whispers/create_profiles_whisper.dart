import 'dart:async';

import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_gate_foundation_view/src/data/session_storage.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Action;

/// {whisper} class.
final class CreateProfilesWhisper extends ViewWhisperFormBase {

   /// Form controller.
  final CreateEntityFormController controller = CreateEntityFormController();

  /// [ProfilesEntityTableAdapter] inner entity table adapter.
  final ProfilesEntityTableAdapter tableAdapter;

  /// Creates a new instance.
  CreateProfilesWhisper({
    required this.tableAdapter,
  }) : super(
         title: 'Create Profiles',
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
    return CreateEntityForm<Profile, IProfilesService>(
      factory: () => Profile(),
      controller: controller,
      onClose: onClose,
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
        return Column(
          spacing: 12,
          children: <Widget>[
            FormInputGroup(
              children: <Widget>[
                /// --> Profile Name
                TextInput(
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
                  /// --> Description
                TextInput(
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
        );
      },
    );
  }
}
