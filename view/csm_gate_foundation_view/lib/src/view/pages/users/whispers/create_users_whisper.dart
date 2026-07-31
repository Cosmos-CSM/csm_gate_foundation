import 'dart:async';
import 'dart:convert';

import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide TextInput;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// Represents a { View } whisper to create users.
final class CreateUsersWhisper extends ViewWhisperFormBase {
  /// Form controller.
  final CreateEntityFormController controller = CreateEntityFormController();

  /// [UsersCategoryPage] inner entity table adapter.
  final UsersEntityTableAdatper tableAdapter;

  /// Creates a new instance.
  CreateUsersWhisper({
    required this.tableAdapter,
  }) : super(
         title: 'Create Users',
       );

  @override
  FutureOr<void> onClose() {
    tableAdapter.refresh();
  }

  @override
  FutureOr<void> onPerform() {
    controller.create();
  }

  @override
  Widget composeForm(GlobalKey<FormState> formState, BuildContext buildContext, Size windowSize, Size pageSize) {
    return CreateEntityForm<User, IUsersService>(
      factory: () => User(),
      onClose: onClose,
      authFactory: (BuildContext context) {
        return '';
      },
      controller: controller,
      errorDesigner: (User entity) => 'User with username: ${entity.username}',
      recordDesigner: (User entity, bool selected, bool valid) {
        return CreateEntityFormRecord(
          valid: valid,
          selected: selected,
          fields: <CreateEntityFormRecordField<Object>>[
            /// --> User username.
            CreateEntityFormRecordField<String>(
              label: 'Username',
              value: entity.username,
            ),

            /// --> User password.
            CreateEntityFormRecordField<String>(
              label: 'Password',
              value: List<String>.filled(utf8.decode(base64.decode(entity.password)).length, '*').join(''),
            ),

            /// --> User type.
            CreateEntityFormRecordField<String>(
              label: 'Type',
              value: entity.type.name.toStartUpperCase(),
            ),

            /// --> User is master.
            CreateEntityFormRecordField<bool>(
              label: 'Is Master',
              value: entity.isMaster,
            ),

            /// --> User information name.
            CreateEntityFormRecordField<String>(
              label: 'Name',
              value: entity.userInfo.name,
            ),

            /// --> User information last name.
            CreateEntityFormRecordField<String>(
              label: 'Last Name',
              value: entity.userInfo.lastName,
            ),

            /// --> User information email.
            CreateEntityFormRecordField<String>(
              label: 'eMail',
              value: entity.userInfo.eMail,
            ),

            /// --> User information phone.
            CreateEntityFormRecordField<String>(
              label: 'Phone',
              value: entity.userInfo.phone,
            ),
          ],
        );
      },
      formDesigner: (CreateEntityFormRecordReactor<User>? itemState, _) {
        final bool formDisabled = !(itemState == null);

        return Column(
          spacing: 16,
          children: <Widget>[
            /// --> User's [Username] & [Password] group.
            FormInputGroup(
              children: <Widget>[
                /// --> User's [username]
                TextInput(
                  label: 'Username',
                  isEnabled: formDisabled,
                  maxLength: 50,
                  validator: (String? text) => ValidationUtils.stringValidator('Username', text),
                  controller: TextEditingController(
                    text: itemState?.entity.username,
                  ),
                  onChanged: (String text) {
                    User user = itemState!.entity;
                    user.username = text;
                    itemState.react();
                  },
                ),

                /// --> User's [password]
                TextInput(
                  label: 'Password',
                  isPrivate: true,
                  autofillHints: <String>[],
                  isEnabled: formDisabled,
                  validator: (String? text) => ValidationUtils.stringValidator('Password', text),
                  controller: TextEditingController(
                    text: itemState?.entity.password,
                  ),
                  onChanged: (String text) {
                    User account = itemState!.entity;

                    account.password = base64.encode(utf8.encode(text));
                    itemState.react();
                  },
                ),
              ],
            ),

            /// --> user's [Type] & [IsMaster] group.
            FormInputGroup(
              children: <Widget>[
                /// --> User's [Type].
                EnumSelector<UserTypes>(
                  label: 'User Type',
                  isRequired: true,
                  value: itemState?.entity.type,
                  values: UserTypes.values,
                  onSelect: (UserTypes value) {
                    User user = itemState!.entity;
                    user.type = value;
                    itemState.react();
                  },
                ),

                /// --> User's [IsMaster]
                CheckboxInput(
                  label: 'Is Master',
                  startChecked: itemState?.entity.isMaster ?? false,
                  onChanged: (bool? value) {
                    User user = itemState!.entity;
                    user.isMaster = value ?? false;
                    itemState.react();
                  },
                ),
              ],
            ),

            /// --> User's information section.
            SectionBox(
              title: 'User information',
              outterPadding: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 16,
                  children: <Widget>[
                    /// --> User's information [Name] & [Last Name] group.
                    FormInputGroup(
                      children: <Widget>[
                        /// --> User's information [Name].
                        TextInput(
                          label: 'Name',
                          isEnabled: formDisabled,
                          validator: (String? text) => ValidationUtils.stringValidator('Name', text),
                          onChanged: (String text) {
                            if (itemState?.entity == null) return;

                            itemState!.entity.userInfo.name = text;
                            itemState.react();
                          },
                        ),

                        /// --> User's information [Last Name].
                        TextInput(
                          label: 'Last Name',
                          isEnabled: formDisabled,
                          validator: (String? text) => ValidationUtils.stringValidator('Last Name', text),
                          onChanged: (String text) {
                            if (itemState?.entity == null) return;

                            itemState!.entity.userInfo.lastName = text;
                            itemState.react();
                          },
                        ),
                      ],
                    ),

                    /// --> User's information [eMail] & [Phone] group.
                    FormInputGroup(
                      children: <Widget>[
                        /// --> User's information [eMail].
                        TextInput(
                          label: 'eMail',
                          keyboardType: TextInputType.emailAddress,
                          isEnabled: formDisabled,
                          validator: (String? text) => ValidationUtils.emailValidator('eMail', text),
                          onChanged: (String text) {
                            if (itemState?.entity == null) return;

                            itemState?.entity.userInfo.eMail = text;
                            itemState?.react();
                          },
                        ),

                        /// --> User's information [Phone].
                        TextInput(
                          label: 'Phone Number',
                          keyboardType: TextInputType.phone,
                          isEnabled: formDisabled,
                          formatter: <TextInputFormatter>[
                            MaskTextInputFormatter(
                              mask: '(###) ###-####',
                              filter: <String, RegExp>{
                                "#": RegExp(r'[0-9]'),
                              },
                            ),
                          ],
                          validator: (String? text) => ValidationUtils.phoneValidator('Phone', text),
                          onChanged: (String text) {
                            if (itemState?.entity == null) return;

                            itemState?.entity.userInfo.phone = text;
                            itemState?.react();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
