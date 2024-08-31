import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';

class HeaderForBanner extends StatelessWidget {
  const HeaderForBanner({required this.text, required this.getTo});

  final String text;
  final getTo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30.w, right: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: TTextTheme.darkTextTheme.displayMedium
                  ?.merge(TextStyle(fontSize: 18)),
            ),
          ),
          IconButton(
            icon: Icon(Icons.keyboard_double_arrow_right),
            iconSize: 21.w,
            color: ColorConstants.neutralColor1,
            onPressed: getTo,
          )
        ],
      ),
    );
  }
}
