

import '../../lib/csm_gate_foundation_view.dart';

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
