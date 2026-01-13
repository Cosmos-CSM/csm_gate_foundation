import 'dart:async';

import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a { View } whisper to create users.
final class CreateUsersWhisper extends ViewWhisperFormBase {
  /// Creates a new instance.
  const CreateUsersWhisper()
    : super(
        title: 'Create Users',
      );

  @override
  FutureOr<void> onPerform() {
    debugPrint('Called performing form whisper');
  }

  @override
  Widget composeForm(BuildContext buildContext, Size windowSize, Size pageSize) {
    return CreateEntityForm<User, IUsersService>(
      entityFactory: () => Account(),
      controller: creationController,
      buildEntityTag: (Account entity) {
        return 'Account with name: ${entity.user}';
      },
      recordDesigner: (Account entity, bool selected, bool valid) {
        return CreateEntityFormRecord(
          selected: selected,
          fields: <CreateEntityFormRecordField>[
            /// --> User name.
            CreateEntityFormRecordField(
              label: '*Username',
              value: entity.user,
            ),

            /// --> Wildcard.
            CreateEntityFormRecordField(
              label: '*Wildcard',
              value: entity.wildcard.toString(),
            ),

            /// --> Profiles selected.
            for (int i = 0; i < entity.profiles.length; i++)
              CreateEntityFormRecordField(
                label: 'Profile #${i + 1}',

                value: entity.profiles[i].name,
              ),

            /// --> Permits.
            CreateEntityFormRecordField(
              label: 'Permits',
              value: entity.profiles.length.toString(),
            ),

            /// --> Contact name.
            CreateEntityFormRecordField(
              label: '*Name',
              value: entity.contact.name,
            ),

            /// --> Contact name.
            CreateEntityFormRecordField(
              label: '*Lastname',
              value: entity.contact.lastName,
            ),

            /// --> Contact email.
            CreateEntityFormRecordField(
              label: '*Email',
              value: entity.contact.eMail,
            ),

            /// --> Contact lastname.
            CreateEntityFormRecordField(
              label: '*Phone',
              value: entity.contact.phone,
            ),

            /// --> Contact email.
            CreateEntityFormRecordField(
              label: '*Email',
              value: entity.contact.eMail,
            ),
          ],
        );
      },
      formDesigner: (CreateEntityFormRecordReactor<Account>? itemState) {
        final bool formDisabled = !(itemState == null);

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 12,
              children: <Widget>[
                Row(
                  spacing: 10,
                  children: <Widget>[
                    /// --> User name
                    Expanded(
                      child: TextInput(
                        label: '*Name',
                        isEnabled: formDisabled,
                        maxLength: 50,
                        controller: TextEditingController(
                          text: itemState?.entity.user,
                        ),
                        onChanged: (String text) {
                          Account account = itemState!.entity;
                          account.user = text;
                          itemState.react();
                        },
                      ),
                    ),

                    /// --> Password
                    Expanded(
                      child: TextInput(
                        label: '*Password',
                        isEnabled: formDisabled,
                        controller: TextEditingController(
                          text: itemState?.entity.password,
                        ),
                        onChanged: (String text) {
                          Account account = itemState!.entity;
                          account.password = text;
                          itemState.react();
                        },
                      ),
                    ),
                  ],
                ),

                EntityFinderSelector<Contact, ContactsServiceI>(
                  entityBuilder: () => Contact(),
                  label: 'Select the contact information...',
                  initialValue: itemState?.entity.contact,
                  textBuilder: (Contact contact) {
                    return '${contact.name} ${contact.lastName}';
                  },
                  onSelected: (Contact? solution) {
                    itemState?.entity.contact = solution ?? Contact();
                    itemState?.react();
                  },
                ),

                FoldPanelWidget(
                  title: 'Add Contact',
                  child: _CreateWhisperContactsSection(
                    itemState: itemState,
                    isEnabled: formDisabled,
                  ),
                ),
                OptionsSelector<bool>(
                  title: 'Wildcard',
                  preSelected: <bool>[itemState!.entity.wildcard],
                  options: <OptionsSelectorOption<bool>>[
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
                    Account account = itemState.entity;
                    account.wildcard = selected.isNotEmpty ? selected.first : false;
                    itemState.react();
                  },
                ),

                SelectableList<Profile, ProfilesServiceI>(
                  heigth: 500,
                  title: 'Available Profiles',
                  entityBuilder: () => Profile(),
                  initialValues: itemState.entity.profiles,
                  tileTitle: (Profile profile) => profile.name,
                  onSelect: (bool selected, Profile item) {
                    itemState.react();
                  },
                ),

                SelectableList<Permit, PermitsServiceI>(
                  heigth: 500,
                  title: 'Available Permits',
                  entityBuilder: () => Permit(),
                  initialValues: itemState.entity.permits,
                  tileTitle: (Permit permit) => '${permit.solution.name} - ${permit.name}',
                  onSelect: (bool selected, Permit item) {
                    itemState.react();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
