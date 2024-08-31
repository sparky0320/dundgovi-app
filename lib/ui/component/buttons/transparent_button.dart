import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/models/model_button.dart';

class TransparentButton extends StatelessWidget {
  const TransparentButton({super.key, required this.model});

  final ButtonModel model;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: model.getTo,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonRadius.w),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: model.borderColor,
            width: 1.0.w,
          ),
          borderRadius: BorderRadius.circular(24),
          // gradient: LinearGradient(
          //   begin: AlignmentDirectional(-1, -1),
          //   end: AlignmentDirectional(1.3, 1),
          //   colors: [
          //     model.color1,
          //     model.color2,
          //   ],
          // ),
        ),
        // width: double.infinity,
        height: buttonHeight.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            model.icon == ""
                ? SizedBox(height: buttonHeight.w * 0.4)
                : SvgPicture.asset(model.icon),
            model.icon == "" ? SizedBox() : SizedBox(width: 20.w),
            Text(
              model.text,
              style: model.textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
