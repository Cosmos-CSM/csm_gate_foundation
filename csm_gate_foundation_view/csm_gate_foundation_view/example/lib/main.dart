

import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
    GateFoundationViewModule(
      signature: 'CSMGF',
      developmentUserData: AuthInput.a(
        'CSMGF',
        'local_user',
        'local_user'.bytes,
      ),
    ),
  );
}
