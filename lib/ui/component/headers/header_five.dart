import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:move_to_earn/core/constants/values.dart';

class HeaderFive extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? elevation;
  final Color? shadowColor;

  const HeaderFive({
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
      leading: Padding(
        padding: EdgeInsets.only(left: 34.w),
        child: IconButton(
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
      ),
      title: Text(
        this.title,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: mainTextBlack,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
