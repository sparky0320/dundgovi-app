import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/values.dart';

class HeaderFour extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? elevation;
  final Color? shadowColor;

  const HeaderFour({
    Key? key,
    required this.title,
    this.elevation,
    this.shadowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: mainWhite,
      elevation: this.elevation != null ? this.elevation : 0,
      centerTitle: true,
      shadowColor: this.shadowColor != null ? this.shadowColor : null,
      automaticallyImplyLeading: false,
      leading: IconButton(
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset(
          'assets/icon-svg/icon/back.svg',
          height: 16.h,
          width: 9.w,
          colorFilter: ColorFilter.mode(
            mainGreyColor,
            BlendMode.srcIn,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 6.w),
          child: IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            onPressed: () {
              Get.offAllNamed("/home-student");
            },
            icon: SvgPicture.asset('assets/icon-svg/icon/home.svg',
                height: 20.h,
                width: 20.w,
                colorFilter: ColorFilter.mode(
                  mainPurple,
                  BlendMode.srcIn,
                )),
          ),
        ),
      ],
      title: Text(
        this.title,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: mainTextBlack,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
