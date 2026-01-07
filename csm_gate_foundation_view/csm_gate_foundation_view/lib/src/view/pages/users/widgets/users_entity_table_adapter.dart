import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

///
final class UsersEntityTableAdatper extends GateFoundationEntityTableAdapterBase<User> {
  /// Creates a new instance.
  UsersEntityTableAdatper();

  @override
  Widget composeViewer(BuildContext buildContext, User entity) {
    return EntityTableViewer(
      children: <Widget>[
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
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
      ],
    );
  }
}
