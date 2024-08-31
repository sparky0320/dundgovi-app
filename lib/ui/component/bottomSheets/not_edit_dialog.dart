// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:move_to_earn/core/constants/values.dart';
// import 'package:get/get.dart';
//
// notEditDialog(context) {
//   showModalBottomSheet(
//     context: context,
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
//                 margin: EdgeInsets.only(bottom: 18.h),
//                 padding: EdgeInsets.all(16.r),
//                 decoration: BoxDecoration(shape: BoxShape.circle, color: mainBlue),
//                 child: SvgPicture.asset('assets/icon/information_alert.svg', height: 48.sp, width: 48.w, color: mainWhite),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0.w),
//                 child: Text(
//                   "Зардал бүртгэсэн байна",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: mainBlack, fontSize: 16.sp, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ),
//             SizedBox(height: 32.h),
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0.w),
//                 child: Text(
//                   "Зардал руу бүртгэсэн тул засах боломжгүй",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: mainBlack, fontSize: 14.sp, fontWeight: FontWeight.w400),
//                 ),
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: ()=>Navigator.pop(context),
//                   splashColor: Colors.transparent,
//                   highlightColor: Colors.transparent,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16.r),
//                       color: mainBlue,
//                     ),
//                     width: double.infinity,
//                     padding: EdgeInsets.symmetric(vertical: 14.h),
//                     margin: EdgeInsets.only(top: 32.h, right: 16.w, left: 16.w),
//                     child: Text(
//                       "Хаах",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: mainWhite, fontSize: 16.sp, fontWeight: FontWeight.w500),
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
