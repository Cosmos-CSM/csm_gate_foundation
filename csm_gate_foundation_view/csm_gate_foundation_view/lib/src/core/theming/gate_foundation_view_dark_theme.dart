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
        loginBusinessLogo: GateFoundationViewAssetsConstants.fullLogoWhiteWebp,
        icon: const Icon(
          Icons.abc_outlined,
        ),
        iconBackground: GateFoundationViewColorConstants.warmWhite,
        page: ThemingData(
          back: GateFoundationViewColorConstants.lightDark,
          fore: GateFoundationViewColorConstants.warmWhite,
          accent: GateFoundationViewColorConstants.oceanBlue,
          foreAlt: GateFoundationViewColorConstants.warmWhite,
          accentAlt: GateFoundationViewColorConstants.warmWhite,
        ),
        control: const ThemingData(
          back: GateFoundationViewColorConstants.lightDark,
          fore: Color(0xffdddddd),
          accent: Color(0xff04548c),
        ),
        controlError: const ThemingData(
          back: Color.fromARGB(255, 3, 5, 4),
          fore: Color.fromARGB(255, 255, 21, 0),
          accent: GateFoundationViewColorConstants.deepWine,
          foreAlt: GateFoundationViewColorConstants.warmWhite,
          accentAlt: GateFoundationViewColorConstants.oceanBlue,
        ),
        controlSuccess: ThemingData(
          back: GateFoundationViewColorConstants.lightDark,
          fore: Colors.green,
          accent: Colors.green,
        ),
      );
}
