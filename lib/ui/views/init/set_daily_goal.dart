import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lambda/plugins/bottom_modal/bottom_modal.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/main_page_tcr_ctr.dart';

import '../../../core/constants/colors.dart';
import '../../../utils/theme/widget_theme/text_theme.dart';

setDailyGoalDialog(context) {
  MainPageTCRCtrl controller = Get.put(MainPageTCRCtrl());
  controller.goalCtrl.clear();
//   return showModalBottomSheet<void>(
//     context: context,
//     isScrollControlled: true,
//     builder: (BuildContext context) {
//       return ListView(
//         shrinkWrap: true, // Make the ListView shrink-wrap its content
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height / 2.8,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Text(
//                     'Зорилго оруулах',
//                     style: goSecondTextStyle.copyWith(
//                         fontSize: 18, fontWeight: FontWeight.w700),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Wrap(
//                     spacing: 15.0,
//                     children: [
//                       for (int index in [
//                         stepgoal1!.toInt(),
//                         stepgoal2!.toInt(),
//                         stepgoal3!.toInt()
//                       ])
//                         ChoiceChip(
//                           label: Text('$index'),
//                           selected: controller.stepGoal == index,
//                           onSelected: (bool selected) {
//                             controller.stepGoal = selected ? index : null;
//                             print(controller.stepGoal);
//                           },
//                         ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 38.h,
//                     child: TextFormField(
//                       style: TTextTheme.darkTextTheme.bodySmall,
//                       controller: controller.goalCtrl,
//                       maxLength: 6,
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         filled: true,
//                         fillColor: ColorConstants.neutralColor4,
//                         contentPadding: EdgeInsets.only(
//                             top: 0, right: 12.w, left: 12.w, bottom: 0),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: Colors.black, width: 0.5),
//                         ),
//                         counterText: "",
//                         counterStyle: TTextTheme.darkTextTheme.headlineSmall,
//                         focusedBorder: const OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 0.5),
//                         ),
//                         hintText: 'Зорилго оруулах',
//                         hintStyle: TTextTheme.darkTextTheme.headlineMedium,
//                         suffixIcon: IconButton(
//                           onPressed: () =>
//                               controller.createAndEditGoal(context),
//                           icon: Icon(
//                             Icons.send,
//                             color: mainPurple,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ElevatedButton(
//                         child: const Text('Close BottomSheet'),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                       ElevatedButton(
//                         child: const Text('Close BottomSheet'),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );

  return showBottomModal(
      context: context,
      builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0.r)),
            child: GetBuilder<MainPageTCRCtrl>(builder: (logic) {
              return Padding(
                padding: EdgeInsets.only(
                    left: 24.w, right: 24.w, top: 24.h, bottom: 6.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "dss_odriin_alhaltiin_hemjee_oruulnuu".tr,
                          style: TextStyle(
                            color: Color(0xff878787),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 28.h),
                        SizedBox(
                          height: 38.h,
                          child: TextFormField(
                            // maxLength: model.maxLength,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: TTextTheme.darkTextTheme.bodySmall,
                            keyboardType: TextInputType.number,
                            controller: controller.goalCtrl,
                            maxLength: 6,
                            autofocus: true,
                            focusNode: logic.inputNode,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: ColorConstants.neutralColor4,
                              contentPadding: EdgeInsets.only(
                                  top: 0, right: 12.w, left: 12.w, bottom: 0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              counterText: "",
                              counterStyle:
                                  TTextTheme.darkTextTheme.headlineSmall,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              hintText: '',
                              hintStyle:
                                  TTextTheme.darkTextTheme.headlineMedium,
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    controller.createAndEditGoal(context),
                                icon: Icon(
                                  Icons.send,
                                  color: mainPurple,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ));
}
