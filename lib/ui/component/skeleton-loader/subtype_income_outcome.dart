import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubtypeIncomeOutcome extends StatelessWidget {
  const SubtypeIncomeOutcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 24.w, right: 24.w),
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
            color: Colors.grey,
          ),
          child: SizedBox(
            width: 120.w,
            height: 14.h,
          ),
        );
      },
    );
  }
}
