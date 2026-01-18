import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

///
final class UsersEntityTableAdatper extends GateFoundationEntityTableAdapterBase<User> {
  /// Creates a new instance.
  UsersEntityTableAdatper();

  @override
  Widget composeViewer(BuildContext buildContext, User entity) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints boxConstraints) {
        double drawerWidth = boxConstraints.maxWidth;

        return EntityTableViewer(
          children: <Widget>[
            SizedBox(
              width: drawerWidth,
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                runAlignment: WrapAlignment.spaceEvenly,
                children: <Widget>[
                  PropertyViewer<String>(
                    label: 'Username',
                    value: entity.username,
                  ),
                  PropertyViewer<String>(
                    label: 'Password',
                    value: '*****',
                  ),
                ],
              ),
            ),
            SizedBox(
              width: drawerWidth,
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                runAlignment: WrapAlignment.spaceEvenly,
                children: <Widget>[
                  PropertyViewer<String>(
                    label: 'Type',
                    value: '${entity.type.name.toStartUpperCase()} (${entity.type.index})',
                  ),
                  PropertyViewer<bool>(
                    label: 'Is Master',
                    value: entity.isMaster,
                  ),
                ],
              ),
            ),

            ExpandibleSection(
              title: 'User Information',
              children: <Widget>[
                SizedBox(
                  width: drawerWidth,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.spaceEvenly,
                    runAlignment: WrapAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: drawerWidth,
                        child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          runAlignment: WrapAlignment.spaceEvenly,
                          children: <Widget>[
                            PropertyViewer<String>(
                              label: 'Name',
                              value: entity.userInfo.name,
                            ),
                            PropertyViewer<String>(
                              label: 'Last Name',
                              value: entity.userInfo.lastName,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: drawerWidth,
                        child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          runAlignment: WrapAlignment.spaceEvenly,
                          spacing: 8,
                          runSpacing: 12,
                          children: <Widget>[
                            PropertyViewer<String>(
                              label: 'eMail',
                              value: entity.userInfo.eMail,
                            ),
                            PropertyViewer<String>(
                              label: 'Phone Number',
                              value: entity.userInfo.phone,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void canSaveChanges(EntityTableAdapterEditorData<User> data) {
    List<ObjectDifference> difference = data.entity.compare(data.entityRef);
    data.toogleSaveButton(difference.isNotEmpty);
  }

  @override
  EntityTableAdapterEditor<User>? composeEditor() {
    return EntityTableAdapterEditor<User>(
      onUpdate: (EntityTableAdapterEditorData<User> data) {},
      formBuilder: (EntityTableAdapterEditorData<User> data) {
        User entity = data.entityRef;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: <Widget>[
            /// User's [Username] input.
            TextInput(
              label: 'Username',
              validator: (String? text) => ValidationUtils.stringValidator('Username', text),
              initialValue: entity.username,
              onChanged: (String text) {
                entity.username = text;
                canSaveChanges(data);
              },
            ),

            /// User's [Type] input.
            EnumSelector<UserTypes>(
              value: entity.type,
              values: UserTypes.values,
              onSelect: (UserTypes value) => entity.type = value,
            ),

            /// User's [Is Master] input
            Padding(
              padding: EdgeInsetsGeometry.only(
                left: 8,
              ),
              child: CheckboxInput(
                label: 'Is Master',
                startChecked: entity.isMaster,
                onChanged: (bool? value) => entity.isMaster,
              ),
            ),

            ExpandibleSection(
              title: 'User Info',
              spacing: 16,
              startExpanded: false,
              children: <Widget>[
                /// --> User's information [Name].
                TextInput(
                  label: 'Name',
                  controller: TextEditingController(
                    text: entity.userInfo.name,
                  ),
                  validator: (String? text) => ValidationUtils.stringValidator('Name', text),
                  onChanged: (String text) => entity.userInfo.name,
                ),

                /// --> User's information [Last Name].
                TextInput(
                  label: 'Last Name',
                  controller: TextEditingController(
                    text: entity.userInfo.lastName,
                  ),
                  validator: (String? text) => ValidationUtils.stringValidator('Last Name', text),
                  onChanged: (String text) => entity.userInfo.lastName = text,
                ),

                /// --> User's information [eMail].
                TextInput(
                  label: 'eMail',
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? text) => ValidationUtils.emailValidator('eMail', text),
                  onChanged: (String text) => entity.userInfo.eMail = text,
                ),

                /// --> User's information [Phone].
                TextInput(
                  label: 'Phone Number',
                  controller: TextEditingController(
                    text: entity.userInfo.phone,
                  ),
                  keyboardType: TextInputType.phone,
                  formatter: <TextInputFormatter>[
                    MaskTextInputFormatter(
                      mask: '(###) ###-####',
                      filter: <String, RegExp>{
                        "#": RegExp(r'[0-9]'),
                      },
                    ),
                  ],
                  validator: (String? text) => ValidationUtils.phoneValidator('Phone', text),
                  onChanged: (String text) => entity.userInfo.phone = text,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
