import 'package:flutter/material.dart';

class InputModel {
  final String hintText;
  final TextEditingController? controller;
  final prefixIcon;
  final Widget? suffixIcon;
  final onChanged;
  final validator;
  final int maxLength;
  final inputType;
  final bool? obscureText;

  InputModel({
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.validator,
    required this.maxLength,
    this.inputType,
    this.obscureText,
  });
}
