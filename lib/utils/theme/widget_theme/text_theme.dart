import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/colors.dart';

class TTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    displayMedium: TextStyle(
      color: ColorConstants.primaryColor,
      fontSize: 22.w,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      color: ColorConstants.accentColor,
      fontSize: 17.w,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: TextStyle(
      color: ColorConstants.neutralColor1,
      fontSize: 17.w,
      fontWeight: FontWeight.w600,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      color: ColorConstants.whiteColor,
      fontSize: 34.w,
      fontWeight: FontWeight.w600,
    ),
    displayMedium: TextStyle(
      color: ColorConstants.whiteColor,
      fontSize: 22.w,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      color: ColorConstants.neutralColor2,
      fontSize: 17.w,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      color: ColorConstants.neutralColor2,
      fontSize: 28.w,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      color: ColorConstants.whiteColor,
      fontSize: 22.w,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: TextStyle(
      color: ColorConstants.neutralColor5,
      fontSize: 17.w,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      color: ColorConstants.neutralColor5,
      fontSize: 15.w,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      color: Color(0xFFEEEEEE),
      fontSize: 12.w,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      color: ColorConstants.neutralColor2,
      fontSize: 15.w,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      color: Color(0xFFEEEEEE).withOpacity(0.6),
      fontSize: 13.w,
      fontWeight: FontWeight.w400,
    ),
  );
}
