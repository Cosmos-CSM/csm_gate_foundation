
import '../csm_gate_foundation_view.dart';

///
final class GateFoundationViewModule extends GateFoundationViewModuleBase {
  /// On development mode, user data to set to bypass login page.
  final AuthInput? developmentUserData;

  /// Creates a new instance.
  GateFoundationViewModule({
    required super.signature,
    this.developmentUserData,
  });

  @override
  AuthInput? developmentUser() => developmentUserData;
}
