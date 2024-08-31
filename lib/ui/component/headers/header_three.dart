import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:move_to_earn/core/constants/values.dart';

class HeaderThree extends StatelessWidget implements PreferredSizeWidget {
  final double? elevation;
  final Color? shadowColor;
  final Color? iconColor;

  const HeaderThree({
    Key? key,
    this.elevation,
    this.shadowColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: mainWhite,
        elevation: this.elevation != null ? this.elevation : 0,
        centerTitle: true,
        shadowColor: this.shadowColor != null ? this.shadowColor : null,
        title: SizedBox(
          height: 43.h,
          width: 43.w,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              "assets/icon-svg/icon/arrow-bottom.svg",
              width: 10.w,
              height: 16.h,
              colorFilter: ColorFilter.mode(
                  this.iconColor != null ? this.iconColor! : mainBlack,
                  BlendMode.srcIn),
            ),
          ),
        ));
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
