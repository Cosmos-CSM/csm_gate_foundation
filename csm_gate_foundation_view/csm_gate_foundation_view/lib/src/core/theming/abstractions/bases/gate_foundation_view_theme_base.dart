import 'package:csm_gate_foundation_view/src/core/theming/abstractions/interfaces/igate_foundation_view_theme.dart';
import 'package:csm_view/csm_view.dart';

/// Represents a { Gate Foundation View } theming data.
abstract class GateFoundationViewThemeBase extends ThemeDataBase implements IGateFoundationViewTheme {
  @override
  /// Asset access for the business logo image.
  late final String loginBusinessLogo;

  /// { CSM } foundation navigation layout theming data.
  @override
  final ThemingData navigationLayout;

  @override
  final StateControlTheming categoryLayoutRibbonActionButton;

  /// Creates a new instance.
  GateFoundationViewThemeBase(
    super.identifier, {
    required super.icon,
    required super.page,
    required super.dialog,
    required super.control,
    required super.controlError,
    required super.iconBackground,
    required super.controlSuccess,
    required super.controlDisabled,

    required this.navigationLayout,
    required this.loginBusinessLogo,
    required this.categoryLayoutRibbonActionButton,
  });
}
