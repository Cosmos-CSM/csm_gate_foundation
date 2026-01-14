import 'dart:async';

import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// Represents a { View } whisper to create users.
final class CreateUsersWhisper extends ViewWhisperFormBase {
  /// Form controller.
  final CreateEntityFormController controller = CreateEntityFormController();

  /// Creates a new instance.
  CreateUsersWhisper()
    : super(
        title: 'Create Users',
      );

  @override
  FutureOr<void> onPerform() {
    debugPrint('Called performing form whisper');
    controller.create();
  }

  @override
  Widget composeForm(GlobalKey<FormState> formState, BuildContext buildContext, Size windowSize, Size pageSize) {
    return CreateEntityForm<User, IUsersService>(
      factory: () => User(),
      authFactory: (BuildContext context) {
        return '';
      },
      controller: controller,
      errorDesigner: (User entity) => 'User with username: ${entity.username}',
      recordDesigner: (User entity, bool selected, bool valid) {
        return CreateEntityFormRecord(
          selected: selected,
          fields: <CreateEntityFormRecordField>[
            /// --> User name.
            CreateEntityFormRecordField(
              label: '*Username',
              value: entity.username,
            ),

            /// --> Wildcard.
            CreateEntityFormRecordField(
              label: '*Wildcard',
              value: entity.isMaster.toString(),
            ),

            /// --> Contact name.
            CreateEntityFormRecordField(
              label: '*Name',
              value: entity.userInfo.name,
            ),

            /// --> Contact name.
            CreateEntityFormRecordField(
              label: '*Last Name',
              value: entity.userInfo.lastName,
            ),

            /// --> Contact email.
            CreateEntityFormRecordField(
              label: '*eMail',
              value: entity.userInfo.eMail,
            ),

            /// --> Contact lastname.
            CreateEntityFormRecordField(
              label: '*Phone',
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
                  validator: (String? val) {
                    if (val == null || val.isEmpty) {
                      return 'The username cannot be empty';
                    }

                    return null;
                  },
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
                  isEnabled: formDisabled,
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return 'The password cannot be empty';
                    }

                    return null;
                  },
                  controller: TextEditingController(
                    text: itemState?.entity.password,
                  ),
                  onChanged: (String text) {
                    User account = itemState!.entity;
                    account.password = text;
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
                          validator: (String? text) {
                            if (text == null || text.isEmpty) {
                              return 'Name cannot be empty';
                            }

                            return null;
                          },
                        ),

                        /// --> User's information [Last Name].
                        TextInput(
                          label: 'Last Name',
                          isEnabled: formDisabled,
                          validator: (String? text) {
                            if (text == null || text.isEmpty) {
                              return 'Last Name cannot be empty';
                            }

                            return null;
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
                          isEnabled: formDisabled,
                          validator: (String? text) {
                            if (text == null || text.isEmpty) {
                              return 'eMail cannot be empty';
                            }

                            return null;
                          },
                        ),

                        /// --> User's information [Phone].
                        TextInput(
                          label: 'Phone Number',
                          isEnabled: formDisabled,
                          formatter: <TextInputFormatter>[
                            MaskTextInputFormatter(
                              mask: '(###) ###-####',
                              filter: <String, RegExp>{
                                "#": RegExp(r'[0-9]'),
                              },
                            ),
                          ],
                          validator: (String? text) {
                            if (text == null || text.isEmpty) {
                              return 'Phone cannot be empty';
                            }

                            String digitsOnly = text.replaceAll(RegExp(r'\D'), '');

                            if (digitsOnly.length < 10) {
                              return 'Phone number must be 10 digits.';
                            }

                            return null;
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
