import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_to_earn/core/constants/colors.dart';

class GradientButtonSmall extends StatelessWidget {
  final String text;
  final Color color1;
  final Color color2;
  final Color textColor;
  final Function? onPressed;
  final bool isShadow;
  final bool isBorder;

  const GradientButtonSmall(
      {Key? key,
      required this.text,
      required this.color1,
      required this.color2,
      this.onPressed,
      this.isShadow = true,
      this.isBorder = false,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      height: 52.h,
      decoration: BoxDecoration(
        border: isBorder
            ? Border.all(
                color: ColorConstants.neutralColor2,
                width: 1.0.w,
              )
            : null,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            color1,
            color2,
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          isShadow
              ? BoxShadow(
                  offset: Offset(0.0, 5),
                  spreadRadius: 5,
                  blurRadius: 30,
                  color: ColorConstants.purpleGradientShadow,
                )
              : BoxShadow(
                  offset: Offset(0.0, 5),
                  spreadRadius: 5,
                  blurRadius: 30,
                  color: Colors.transparent,
                ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed as void Function()?,
            child: Center(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
            )),
      ),
    );
  }
}
