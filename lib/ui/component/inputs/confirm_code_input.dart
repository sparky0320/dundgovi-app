import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';

class CodeInput extends StatelessWidget {
  const CodeInput({required this.onChanged});

  final onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      style: TTextTheme.darkTextTheme.displaySmall,
      maxLength: 4,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "4 оронтой баталгаажуулах кодоо оруулна уу!",
        hintStyle: TextStyle(
          color: Colors.white30,
          fontSize: 12.w,
        ),
        counterText: "Баталгаажуулах код илгээх",
        counterStyle: TextStyle(
          color: Colors.white70,
          fontSize: 15.w,
        ),
      ),
    );
  }
}
