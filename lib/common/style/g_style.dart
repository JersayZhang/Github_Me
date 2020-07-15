import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GColors {
  static const int primaryIntValue = 0xFF24292E;

  static const MaterialColor primarySwatch = const MaterialColor(
    primaryIntValue,
    const <int, Color>{
      50: const Color(primaryIntValue),
      100: const Color(primaryIntValue),
      200: const Color(primaryIntValue),
      300: const Color(primaryIntValue),
      400: const Color(primaryIntValue),
      500: const Color(primaryIntValue),
      600: const Color(primaryIntValue),
      700: const Color(primaryIntValue),
      800: const Color(primaryIntValue),
      900: const Color(primaryIntValue),
    },
  );

  static const Color primaryValue = Color(0xFF24292E);
  static const Color primaryDarkValue = Color(0xFF121917);

  static const Color white = Color(0xFFFFFFFF);
}

class GIcons {
  static const String FONT_FAMILY = 'wxcIconFont';

  static const IconData MAIN_DT = const IconData(0xe684, fontFamily: GIcons.FONT_FAMILY);
  static const IconData MAIN_QS = const IconData(0xe818, fontFamily: GIcons.FONT_FAMILY);
  static const IconData MAIN_MY = const IconData(0xe6d0, fontFamily: GIcons.FONT_FAMILY);
  static const IconData MAIN_SEARCH = const IconData(0xe61c, fontFamily: GIcons.FONT_FAMILY);
}
