import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mdi/mdi.dart';
import 'package:move_to_earn/core/constants/textstyle.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/invite_friend/invite_friend_controller.dart';
import 'package:move_to_earn/core/controllers/main_page_tcr_ctr.dart';
import 'package:move_to_earn/ui/component/buttons/gradient_button_small.dart';
import 'package:move_to_earn/ui/views/home/invite_friend.dart';
import 'package:move_to_earn/utils/number.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../core/constants/colors.dart';

void dialogGoal(context) {
  MainPageTCRCtrl controller = Get.put(MainPageTCRCtrl());
  // controller.goalCtrl.clear();
  showModalBottomSheet<void>(
    backgroundColor: Color(0x556B73).withOpacity(1),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, right: 30, left: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'set_goal'.tr,
                          style: goSecondTextStyle.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: white),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'x',
                            style: goSecondTextStyle.copyWith(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w400,
                                color: white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: List.generate(
                        150 ~/ 2,
                        (index) => Expanded(
                          child: Container(
                            color: index % 2 == 0
                                ? Colors.white
                                : Colors.white, // Only set color when needed
                            margin: EdgeInsets.zero, // Remove any margin
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.setGoal.value = stepgoal1!;
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: transparentColor,
                              border: Border.all(width: 0.5, color: white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r)),
                            ),
                            child: Text(
                              stepgoal1.toString(),
                              style: TextStyle(
                                color: white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.setGoal.value = stepgoal2!;
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                                color: transparentColor,
                                border: Border.all(width: 0.5, color: white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r))),
                            child: Text(
                              stepgoal2.toString(),
                              style: TextStyle(
                                color: white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.setGoal.value = stepgoal3!;
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                                color: transparentColor,
                                border: Border.all(width: 0.5, color: white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r))),
                            child: Text(
                              stepgoal3.toString(),
                              style: TextStyle(
                                color: white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 55.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.setGoal.value -= 500;
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFF).withOpacity(0.4),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Icon(
                                Mdi.minus,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              formatNumber(controller.setGoal.value.toString()),
                              style: TextStyle(
                                  color: white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'steps'.tr,
                              style: TextStyle(
                                  color: white,
                                  height: 1 / 2,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            controller.setGoal.value += 500;
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFF).withOpacity(0.4),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Icon(
                                Mdi.plus,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        gradient: LinearGradient(
                            colors: [
                              const Color(0x627AF7).withOpacity(1),
                              const Color(0xEF566A).withOpacity(1),
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        onPressed: () {
                          controller.createAndEditGoal(context);
                        },
                        child: Center(
                          child: Text(
                            "submit".tr,
                            style: TextStyle(
                              color: mainWhite,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );
    },
  );
}

void dialogInvite(context) {
  InviteFriendCtrl ctrl = Get.put(InviteFriendCtrl());
  ctrl.isClicked = false;
  showModalBottomSheet<void>(
    backgroundColor: Color(0x556B73).withOpacity(1),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            height: MediaQuery.of(context).size.height / 2 + 30.h,
            child:
                // Obx(
                //   () =>
                Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 20, right: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Найзаа урих',
                    style: goSecondTextStyle.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withOpacity(0.6700000166893005),
                      letterSpacing: -0.50,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Найзаа урихын тулд урих кодоо хуулж эсвэл найзаа урих товчийг товшино уу.',
                    style: goSecondTextStyle.copyWith(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: white,
                      letterSpacing: -0.50,
                    ),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        'Таны урилгын код :',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.699999988079071),
                          fontSize: 18,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w600,
                          height: 0.04,
                          letterSpacing: -0.50,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: InkWell(
                      onTap: () async {
                        if (ctrl.isClicked == false) {
                          await FlutterClipboard.copy(ctrl.code.toString())
                              .then(
                            (value) {
                              return Get.snackbar('', '',
                                  backgroundColor: mainGreen,
                                  colorText: Colors.black,
                                  titleText: Text(
                                    '${'if_amjilttai_huulagdlaa'.tr} ${ctrl.code}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: mainWhite,
                                    ),
                                  ),
                                  padding: EdgeInsets.only(
                                      top: 8.h,
                                      bottom: 4,
                                      right: 10.w,
                                      left: 10.w),
                                  messageText: SizedBox(),
                                  borderRadius: 18.r,
                                  maxWidth: 240.w,
                                  margin: EdgeInsets.only(
                                      bottom: 140.h, left: 24.w, right: 24.w),
                                  snackPosition: SnackPosition.BOTTOM);
                            },
                          );
                          ctrl.isClicked = true;
                        } else {
                          null;
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color(0x8798A1).withOpacity(1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.sp),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ctrl.code != null ? ctrl.code.toString() : '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 32.sp,
                                color: white,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Iconsax.copy,
                              color: mainWhite,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: Column(
                      children: [
                        GradientButtonSmall(
                          text: "Найзаа урих",
                          color1: ColorConstants.buttonGradient2,
                          color2: ColorConstants.buttonGradient1,
                          isShadow: false,
                          textColor: whiteColor,
                          onPressed: () async {
                            await FlutterShare.share(
                              title: 'Gocare',
                              text: ctrl.shareText,
                            );
                          },
                        ),
                        GradientButtonSmall(
                          text: "Урьсан найз",
                          color1: transparentColor,
                          color2: transparentColor,
                          isShadow: false,
                          textColor: whiteColor,
                          onPressed: () {
                            Get.to(() => InviteFriend());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // ),
            )),
      );
    },
  );
}
