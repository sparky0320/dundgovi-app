import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/profile/profile_controller.dart';
import 'package:nb_utils/nb_utils.dart';

void updateGender(ctx) {
  ProfileCtrl ctrl = Get.put(ProfileCtrl());
  showModalBottomSheet(
    context: ctx,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
    ),
    isScrollControlled: true,
    // backgroundColor: Colors.white,
    backgroundColor: Color(0x556B73).withOpacity(1),
    builder: (BuildContext context) {
      // bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
      return GetBuilder<ProfileCtrl>(
        init: ctrl,
        builder: (logic) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 18.h),
                    Align(
                        alignment: Alignment.center,
                        child: Text('pep_huis_songoh'.tr,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: white))),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                      child: Divider(color: mainGreyColor),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 46.w, top: 0.h, right: 46.w, bottom: 40.h),
                      child: Column(
                        children: ctrl.data.map((item) {
                          return Column(
                            children: [
                              Ink(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                    color: Colors.transparent),
                                child: InkWell(
                                  onTap: () {
                                    ctrl.selectedGender = item['type'];
                                    ctrl.update();
                                    Navigator.pop(context);
                                  },
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.r)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.w),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item['title'],
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            // item.id == 2
                                            ctrl.selectedGender == item['type']
                                                ? Icon(
                                                    Icons.check_circle,
                                                    // color: Colors.purple[900],
                                                    color: white,
                                                    size: 18.sp,
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
