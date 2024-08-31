// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import '../../../../core/constants/values.dart';
//
// void deleteBottomSheet(ctx, VoidCallback? onClicked) {
//   showModalBottomSheet(
//     context: ctx,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
//     ),
//     isScrollControlled: true,
//     backgroundColor: mainBgColor,
//     builder: (BuildContext context) {
//       return Padding(
//         padding: EdgeInsets.all(24.r),
//         child: Wrap(
//           children: [
//             Center(
//               child: Container(
//                 height: 88.h,
//                 width: 88.w,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: mainRed,
//                 ),
//                 margin: EdgeInsets.only(bottom: 32.h, top: 16.h),
//                 padding: EdgeInsets.all(16.r),
//                 child: SvgPicture.asset(
//                   'assets/icon/accumulation/trush-square.svg',
//                   color: mainWhite,
//                   height: 48.h,
//                   width: 48.w,
//                 ),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0.w),
//                 child: Text(
//                   "Та устгах гэж байгаадаа итгэлтэй байна уу!",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: mainBlack, fontSize: 16.sp, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: onClicked,
//                   splashColor: Colors.transparent,
//                   highlightColor: Colors.transparent,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16.r),
//                       color: mainRed,
//                     ),
//                     width: double.infinity,
//                     padding: EdgeInsets.symmetric(vertical: 14.h),
//                     margin: EdgeInsets.only(top: 32.h, right: 16.w, left: 16.w),
//                     child: Text(
//                       "Устгах",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: mainWhite, fontSize: 16.sp, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   splashColor: Colors.transparent,
//                   highlightColor: Colors.transparent,
//                   child: Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.symmetric(vertical: 14.h),
//                     margin: EdgeInsets.only(top: 8.h, right: 16.w, left: 16.w),
//                     child: Text(
//                       "Хаах",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: textGrey, fontSize: 16.sp, fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       );
//     },
//   );
// }
