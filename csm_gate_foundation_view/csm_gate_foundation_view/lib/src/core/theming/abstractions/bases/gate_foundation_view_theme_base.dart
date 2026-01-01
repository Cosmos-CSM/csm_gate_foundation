import 'package:csm_gate_foundation_view/src/core/theming/abstractions/interfaces/igate_foundation_view_theme.dart';
import 'package:csm_view/csm_view.dart';

/// Represents a { Gate Foundation View } theming data.
abstract class GateFoundationViewThemeBase extends ThemeDataBase implements IGateFoundationViewTheme {
  @override
  /// Asset access for the business logo image.
  final String loginBusinessLogo;

  /// Creates a new instance.
  GateFoundationViewThemeBase(
    super.identifier, {
    required super.icon,
    required super.iconBackground,

    required this.loginBusinessLogo,
  });
}
