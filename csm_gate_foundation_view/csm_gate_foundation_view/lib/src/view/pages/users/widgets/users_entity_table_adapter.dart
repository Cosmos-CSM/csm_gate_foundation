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
            /// --> created timestamp
            PropertyViewer<String>(
              label: 'Timestamp',
              value: entity.timestamp.toLocal().toString(),
            ),
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
              title: 'Access level details',
              children: <Widget>[
                SizedBox(
                  width: drawerWidth,
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    runAlignment: WrapAlignment.spaceEvenly,
                    children: <Widget>[
                      /// Profiles list
                      ListViewer<Profile>(
                        title: 'Profiles', 
                        tilesContent: entity.profiles,
                        tileTitle: (Profile set) {
                          return set.name;
                        },
                      ),

                      /// Permits list
                      ListViewer<Permit>(
                        title: 'Permits', 
                        tilesContent: entity.permits,
                        tileTitle: (Permit set) {
                          return '${set.solution.name} - ${set.name}';
                        },
                      )
                    ],
                  ),
                ),
              ],
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
      onUpdate: (EntityTableAdapterEditorData<User> data) {
        List<ObjectDifference> diffs = data.entity.compare(data.entityRef);
        debugPrint('Updating user');

        showDialog(
          context: data.context,
          builder: (BuildContext context) {
            return UpdateEntityDialog<User>(
              differences: diffs,
            );
          },
        );
      },
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
              onSelect: (UserTypes value) {
                entity.type = value;
                canSaveChanges(data);
              },
            ),

            /// User's [Is Master] input
            Padding(
              padding: EdgeInsetsGeometry.only(
                left: 8,
              ),
              child: CheckboxInput(
                label: 'Is Master',
                startChecked: entity.isMaster,
                onChanged: (bool? value) {
                  entity.isMaster = value ?? false;
                  canSaveChanges(data);
                },
              ),
            ),

            /// User's [User Info] input.
            ExpandibleSection(
              title: 'User Info',
              spacing: 16,
              startExpanded: false,
              children: <Widget>[
                /// --> User's information [Name].
                TextInput(
                  label: 'Name',
                  initialValue: entity.userInfo.name,
                  validator: (String? text) => ValidationUtils.stringValidator('Name', text),
                  onChanged: (String text) {
                    entity.userInfo.name = text;
                    canSaveChanges(data);
                  },
                ),

                /// --> User's information [Last Name].
                TextInput(
                  label: 'Last Name',
                  initialValue: entity.userInfo.lastName,
                  validator: (String? text) => ValidationUtils.stringValidator('Last Name', text),
                  onChanged: (String text) {
                    entity.userInfo.lastName = text;
                    canSaveChanges(data);
                  },
                ),

                /// --> User's information [eMail].
                TextInput(
                  label: 'eMail',
                  keyboardType: TextInputType.emailAddress,
                  initialValue: entity.userInfo.eMail,
                  validator: (String? text) => ValidationUtils.emailValidator('eMail', text),
                  onChanged: (String text) {
                    entity.userInfo.eMail = text;
                    canSaveChanges(data);
                  },
                ),

                /// --> User's information [Phone].
                TextInput(
                  label: 'Phone Number',
                  initialValue: entity.userInfo.phone,
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
                  onChanged: (String text) {
                    entity.userInfo.phone = text;
                    canSaveChanges(data);
                  },
                ),
                
                SelectableListAsync<Profile, ProfilesServiceI>(
                  height: 350,
                  title: 'Available Profiles',
                  entityBuilder: () => Profile(),
                  initialValues: data.entity.profiles,
                  tileTitle: (Profile profile) => profile.name, 
                  onSelect: (bool selected, Profile item) {  },
                ),

                SelectableListAsync<Permit, PermitsServiceI>(
                  height: 350,
                  title: 'Available Permits',
                  entityBuilder: () => Permit(),
                  initialValues: data.entity.permits,
                  tileTitle: (Permit permit) => '${permit.solution.name} - ${permit.name}', 
                  onSelect: (bool selected, Permit item) {  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
