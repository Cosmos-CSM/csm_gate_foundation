import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_gate_foundation_view/src/core/constants/assets_constants.dart';
import 'package:csm_gate_foundation_view/src/core/constants/colors_constants.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

///
final class GateFoundationViewDarkTheme extends GateFoundationViewThemeBase {
  ///
  GateFoundationViewDarkTheme()
    : super(
        'csm_gate_foundation_dark',
        loginBusinessLogo: GateFoundationViewAssetsConstants.whiteLogo,
        icon: const Icon(
          Icons.abc_outlined,
        ),
        iconBackground: GateFoundationViewColorConstants.warmWhite,
        navigationLayout: const ThemingData(
          back: GateFoundationViewColorConstants.oceanBlue,
          fore: GateFoundationViewColorConstants.warmWhite,
          accent: GateFoundationViewColorConstants.warmWhite,
        ),
        page: const ThemingData(
          back: GateFoundationViewColorConstants.lightDark,
          fore: GateFoundationViewColorConstants.warmWhite,
          accent: GateFoundationViewColorConstants.oceanBlue,
          foreAlt: GateFoundationViewColorConstants.warmWhite,
          accentAlt: GateFoundationViewColorConstants.warmWhite,
        ),
        control: const ThemingData(
          back: GateFoundationViewColorConstants.oceanBlue,
          fore: GateFoundationViewColorConstants.warmWhite,
          accent: GateFoundationViewColorConstants.deepWine,
        ),
        controlError: const ThemingData(
          back: Color.fromARGB(255, 3, 5, 4),
          fore: Color.fromARGB(255, 255, 21, 0),
          accent: GateFoundationViewColorConstants.deepWine,
          foreAlt: GateFoundationViewColorConstants.warmWhite,
          accentAlt: GateFoundationViewColorConstants.oceanBlue,
        ),
        controlSuccess: const ThemingData(
          back: GateFoundationViewColorConstants.lightDark,
          fore: Colors.green,
          accent: Colors.green,
        ),
        controlDisabled: const ThemingData(
          back: GateFoundationViewColorConstants.darkGrey,
          fore: GateFoundationViewColorConstants.lightDark,
          accent: GateFoundationViewColorConstants.oceanBlue,
        ),
        categoryLayoutRibbonActionButton: const StateControlTheming(
          main: InputControlTheming(
            background: GateFoundationViewColorConstants.oceanBlue,
            foreground: GateFoundationViewColorConstants.warmWhite,
          ),
          hoverStruct: InputControlTheming(
            background: GateFoundationViewColorConstants.oceanBlueH,
          ),
          selectStruct: InputControlTheming(
            background: GateFoundationViewColorConstants.oceanBlueH,
          ),
        ),
      );
}
