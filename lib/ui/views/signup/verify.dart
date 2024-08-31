import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:move_to_earn/core/constants/image_strings.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/authentication/verify_controller.dart';
import 'package:move_to_earn/core/controllers/timer_controller.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import 'package:move_to_earn/ui/component/headers/header_for_page.dart';
import 'package:move_to_earn/utils/shake_animation.dart';
import 'package:pinput/pinput.dart';

import '../../../core/constants/colors.dart';
import '../../component/input_number.dart';

class VerifyPage extends StatefulWidget {
  final String email;

  const VerifyPage({Key? key, required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage>
    with SingleTickerProviderStateMixin {
  VerifyController ctrl = Get.put(VerifyController());
  TimerState timerState = Get.put(TimerState());

  @override
  void initState() {
    super.initState();
    // ctrl.setPhoneNumber(widget.email);
    timerState.done = counterDone;
    timerState.setTime(300);
    timerState.startCountDown();
    ctrl.verCode.clear();
  }

  counterDone() async {
    print("done");
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<TimerState>();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyController>(
      init: ctrl,
      builder: (logic) {
        return Scaffold(
          backgroundColor: mainWhite,
          body: Stack(
            children: [
              BackColor(),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(signupImage3),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        HeaderForPage(
                          backArrow: BackArrow(),
                          text: 'r3_batalgaajuulah'.tr,
                        ),

                        // enter code field
                        Container(
                          padding: EdgeInsets.only(
                              top: 40.h, bottom: 32.h, left: 48.w, right: 48.w),
                          child: pinput(),
                        ),

                        // text for code
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 48.w),
                          child: Text(
                            '${'r3_tani'.tr} ${widget.email} ${'r3_dugaarruu_code_ilgeesn'.tr}',
                            //'Таны ${widget.phone}-руу баталгаажуулах 4 оронтой код илгээсэн!',
                            style: TextStyle(
                              color: textGrey,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                        GetBuilder<TimerState>(
                            init: timerState,
                            builder: (logic) {
                              return Column(
                                children: [
                                  Text(
                                    Duration(seconds: timerState.current)
                                        .toString()
                                        .substring(2, 7),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Ink(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.r)),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (timerState.current == 0) {
                                          timerState.reset();
                                          timerState.startCountDown();
                                          ctrl.resendEmail(
                                              context, widget.email);
                                        } else {
                                          if (!Get.isSnackbarOpen) {
                                            Get.snackbar("", "",
                                                icon: Icon(Iconsax.warning_2,
                                                    color: Colors.yellow,
                                                    size: 32.sp),
                                                snackPosition:
                                                    SnackPosition.TOP,
                                                titleText: Text(
                                                  'r3_tvr_hvleene_vv'.tr,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                messageText: Text(
                                                  '${'r3_ta'.tr} ${timerState.current} ${'r3_secundiin_daraa_dahin_hvselt_ilgee'.tr}',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12.sp),
                                                ),
                                                backgroundColor: Colors.white,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w,
                                                    vertical: 12.h));
                                          }
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.h, horizontal: 4.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Iconsax.refresh,
                                              size: 16.sp,
                                              color: timerState.current == 0
                                                  ? Colors.white
                                                  : textGrey,
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              'r3_dahin_ilgeeh'.tr,
                                              style: TextStyle(
                                                color: timerState.current == 0
                                                    ? Colors.white
                                                    : textGrey,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: InputNumberScreen(
                          maxLength: 4,
                          onCompleted: (text) {
                            ctrl.verCode.text = text;
                            ctrl.update();
                          },
                          onChanged: (String text) {
                            ctrl.verCode.text = text;
                            ctrl.update();
                          })),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget pinput() {
    final defaultPinTheme = PinTheme(
      width: 52.w,
      height: 52.h,
      textStyle: TextStyle(
        fontSize: 22.sp,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xff95C2FF),
        ),
        borderRadius: BorderRadius.circular(12.r),
        color: ColorConstants.roundedRectangleColor.withOpacity(0.4),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 4.r,
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: mainBlue),
    );
    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: mainBlue),
    );
    final errorTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color(0xffED0041)),
    );

    return Form(
        key: ctrl.verifyFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShakeWidget(
              key: ctrl.shakeKey,
              shakeCount: 3,
              shakeOffset: 10,
              shakeDuration: Duration(milliseconds: 500),
              child: Pinput(
                focusNode: ctrl.pinputFocusNode,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                controller: ctrl.verCode,
                forceErrorState: ctrl.isFail,
                keyboardType: TextInputType.none,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                errorPinTheme: errorTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                onChanged: (val) {
                  if (val.length > 0) {
                    ctrl.errorMsg = '';
                    ctrl.isFail = false;
                    ctrl.update();
                  }
                },
                onCompleted: (pin) async {
                  await ctrl.doVerify(context, widget.email);
                },
              ),
            ),
            SizedBox(height: 12.h),
            ctrl.isFail
                ? Text(ctrl.errorMsg,
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: mainRed,
                        fontWeight: FontWeight.w400))
                : SizedBox(),
          ],
        ));
  }
}