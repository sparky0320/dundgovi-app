// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:move_to_earn/core/constants/values.dart';
// import 'package:get/get.dart';
//
// deleteDialog(context, VoidCallback? onClicked) {
//   return showDialog(
//       context: context,
//       builder: (_) => Dialog(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0.r)),
//             child: Container(
//               // height: 480.h,
//               width: 380.w,
//               padding: EdgeInsets.all(24.r),
//               child: Wrap(
//                 children: [
//                   Center(
//                     child: Container(
//                       height: 80.h,
//                       width: 80.w,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(24.r),
//                         color: mainRed,
//                       ),
//                       margin: EdgeInsets.only(bottom: 24.h),
//                       padding: EdgeInsets.all(16.r),
//                       child: SvgPicture.asset(
//                         'assets/icon/accumulation/trush-square.svg',
//                         color: mainWhite,
//                         // height: 100.h,
//                         // width: 100.w,
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Text(
//                       "Та устгахдаа итгэлтэй байна уу ?",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: mainBlack, fontSize: 16.sp, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         splashColor: Colors.transparent,
//                         highlightColor: Colors.transparent,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(16.r),
//                             color: Colors.grey,
//                             // boxShadow: [
//                             //   BoxShadow(
//                             //     offset: Offset(0, 0),
//                             //     blurRadius: 4.r,
//                             //     color: Colors.grey.withOpacity(0.5),
//                             //   ),
//                             // ],
//                           ),
//                           width: 130.w,
//                           padding: EdgeInsets.symmetric(vertical: 14.h),
//                           margin: EdgeInsets.only(top: 40.h),
//                           child: Text(
//                             "Үгүй",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(color: mainWhite, fontSize: 12.sp, fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: onClicked,
//                         splashColor: Colors.transparent,
//                         highlightColor: Colors.transparent,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(16.r),
//                             color: mainRed,
//                             // boxShadow: [
//                             //   BoxShadow(
//                             //     offset: Offset(0, 0),
//                             //     blurRadius: 4.r,
//                             //     color: Colors.grey.withOpacity(0.5),
//                             //   ),
//                             // ],
//                           ),
//                           width: 130.w,
//                           padding: EdgeInsets.symmetric(vertical: 14.h),
//                           margin: EdgeInsets.only(top: 40.h),
//                           child: Text(
//                             "Тийм",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(color: mainWhite, fontSize: 12.sp, fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ));
// }
