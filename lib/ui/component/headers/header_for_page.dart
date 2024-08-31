import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';

class HeaderForPage extends StatelessWidget {
  const HeaderForPage({this.backArrow, required this.text, this.iconButton});

  final Widget? backArrow;
  final String text;
  final Widget? iconButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 48.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          backArrow ??
              SizedBox(
                width: 50,
              ),
          Expanded(
            child: Text(
              overflow: TextOverflow.ellipsis,
              text,
              style: TTextTheme.darkTextTheme.displayMedium,
            ),
          ),
          iconButton ??
              SizedBox(
                width: 50,
              ),
        ],
      ),
    );
  }
}
