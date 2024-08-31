import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:move_to_earn/core/constants/values.dart';

class HeaderOne extends StatefulWidget {
  final String title;
  final Color? color;
  final VoidCallback onclick;

  const HeaderOne(
      {Key? key, required this.title, required this.onclick, this.color})
      : super(key: key);

  @override
  _HeaderOneState createState() => _HeaderOneState();
}

class _HeaderOneState extends State<HeaderOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: mainWhite, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 0,
          blurRadius: 6,
          offset: Offset(0, 6), // changes position of shadow
        ),
      ]),
      width: resWidth(context),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top,
        bottom: 10.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 6.w, right: 6.w),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(
                'assets/icon-svg/icon/back.svg',
                height: 16.67.h,
                width: 9.67.w,
                colorFilter: ColorFilter.mode(
                  widget.color != null ? widget.color! : mainBlack,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(
            width: resWidth(context) / 2,
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18.sp,
                color: mainTextBlack,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 6.w, right: 6.w),
            child: IconButton(
              onPressed: widget.onclick,
              icon: SvgPicture.asset(
                'assets/icon-svg/icon/search.svg',
                height: 20.h,
                width: 20.w,
                colorFilter: ColorFilter.mode(
                  mainGrey,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
