import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/models/model_name_input.dart';

class NamePassInput extends StatelessWidget {
  const NamePassInput({super.key, required this.model});

  final InputModel model;

  // get primaryColor => null
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 70.w,
      width: 350.w,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(inputRadius.w),
      //   ),
      //   // color:
      // ),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        maxLength: model.maxLength,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(
          fontSize: 17.w,
          color: mainWhite,
          fontWeight: FontWeight.w600,
        ),
        keyboardType: model.inputType,
        controller: model.controller,
        onChanged: model.onChanged,
        obscureText: model.obscureText ?? false,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(inputRadius.r),
            borderSide: const BorderSide(color: Colors.red),
          ),
          errorStyle: TextStyle(fontSize: 0),
          filled: true,
          fillColor: mainWhite.withOpacity(0.2),
          // fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(inputRadius.w),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          counterText: "",
          counterStyle: TTextTheme.darkTextTheme.headlineSmall,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(inputRadius.w),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(inputRadius.w),
            borderSide: const BorderSide(color: Colors.white),
          ),
          prefixIcon: Icon(
            model.prefixIcon,
            color: ColorConstants.neutralColor4,
          ),
          hintText: model.hintText,
          hintStyle: TextStyle(
            fontSize: 17.w,
            color: mainWhite.withOpacity(0.5),
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: model.suffixIcon,
        ),
        validator: model.validator,
      ),
    );
  }
}
