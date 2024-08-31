import 'package:flutter/material.dart';

class ButtonModel {
  final Color color1;
  final Color color2;
  final Color color3;
  final Color color4;
  final Color color5;
  final Color borderColor;
  final String text;
  final String icon;
  final textStyle;
  final getTo;

  ButtonModel({
    required this.color1,
    required this.color2,
    required this.color3,
    required this.color4,
    required this.color5,
    required this.borderColor,
    required this.text,
    required this.textStyle,
    required this.getTo,
    required this.icon,
  });
}
