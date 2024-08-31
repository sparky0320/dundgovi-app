import 'package:flutter/material.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: const MaterialColor(0xFF584a73, <int, Color>{
        50: Color(0xFF584a73),
        100: Color(0xFF4F4267),
        200: Color(0xFF463B5C),
        300: Color(0xFF3D3350),
        400: Color(0xFF342C45),
        500: Color(0xFF2C2539),
        600: Color(0xFF231D2E),
        700: Color(0xFF1A1622),
        800: Color(0xFF110E17),
        900: Color(0xFF08070B),
      }),
      textTheme: TTextTheme.lightTextTheme,
      fontFamily: 'Nunito');

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: const MaterialColor(0xFF584a73, <int, Color>{
      50: Color(0xFF584a73),
      100: Color(0xFF4F4267),
      200: Color(0xFF463B5C),
      300: Color(0xFF3D3350),
      400: Color(0xFF342C45),
      500: Color(0xFF2C2539),
      600: Color(0xFF231D2E),
      700: Color(0xFF1A1622),
      800: Color(0xFF110E17),
      900: Color(0xFF08070B),
    }),
    textTheme: TTextTheme.darkTextTheme,
  );
}
