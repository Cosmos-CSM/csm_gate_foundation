import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';

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

  @override
  EntityTableAdapterEditor<User>? composeEditor() {
    return EntityTableAdapterEditor<User>(
      onUpdate: (BuildContext buildContext, User entity) {},
      formBuilder: (BuildContext buildContext, User entity) {
        return Column(
          children: <Widget>[],
        );
      },
    );
  }
}
