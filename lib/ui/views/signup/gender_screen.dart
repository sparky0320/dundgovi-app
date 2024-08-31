import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/authentication/get_info_controller.dart';
import 'package:move_to_earn/ui/views/signup/info_screen.dart';
import '../../component/buttons/gradient_button_small.dart';

enum Gender { M, F }

class GenderScreen extends StatefulWidget {
  final PageController? pageController;
  final Function? updatevalue;
  final Function? pageNum;
  final InfoScreenState infoScreenState;
  final bool? isBack;
  final GetInfoController? ctrl;
  // final getTo;

  GenderScreen({
    this.pageController,
    this.updatevalue,
    this.pageNum,
    required this.infoScreenState,
    this.isBack = false,
    this.ctrl,
    // this.getTo,
  });

  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  Gender? gender = Gender.M;

  // void onGender(String gender) {
  //   setState(() {
  //     widget.ctrl!.selectedGender = gender;
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var fullHeight = MediaQuery.of(context).size.height;
    var fullWidth = MediaQuery.of(context).size.width;
    return GetBuilder<GetInfoController>(
      init: widget.ctrl,
      builder: (logic) {
        return Container(
          height: fullHeight,
          width: fullWidth,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.only(top: fullHeight * 0.04),
                child: Text(
                  "Та хүйсээ сонгоно уу",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: mainWhite,
                    fontSize: 30.sp,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20.h,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
                child: Text(
                  "Алхалтын тоо болон энерги зарцуулалтыг тооцоход ашиглагдана",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: mainWhite.withOpacity(0.7),
                    fontSize: 18.sp,
                  ),
                ),
              ),
              _maleContanier(fullHeight),
              _femaleContainer(fullHeight),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: fullHeight * 0.08,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: GradientButtonSmall(
                    isShadow: false,
                    text: 'rp_vrgeljlvvleh'.tr,
                    color1: ColorConstants.buttonGradient2,
                    color2: ColorConstants.buttonGradient1,
                    textColor: mainWhite,
                    onPressed: () {
                      setState(() {
                        widget.pageNum!(2);
                        widget.updatevalue!(0.28);
                      });
                      if (gender == Gender.M) {
                        widget.ctrl!.selectedGender = "m";
                      } else {
                        widget.ctrl!.selectedGender = "f";
                      }
                      widget.pageController!.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _maleContanier(double fullHeight) {
    return InkWell(
      onTap: () {
        setState(() {
          gender = Gender.M;
        });
      },
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorConstants.roundedRectangleColor.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(30.r),
          ),
          color: ColorConstants.roundedRectangleColor.withOpacity(0.3),
        ),
        margin: EdgeInsets.only(
          top: fullHeight * 0.1,
          left: 60.w,
          right: 60.w,
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 30.w),
              child: Image.asset(
                'assets/icon-png/ic_male.png',
                width: 40.w,
                height: 40.h,
                color: ColorConstants.buttonGradient1,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'rp_eregtei'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 21.sp,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 30.w),
              child: Radio(
                fillColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                value: Gender.M,
                groupValue: gender,
                onChanged: (Gender? value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _femaleContainer([double? fullHeight]) {
    return InkWell(
      onTap: () {
        setState(() {
          gender = Gender.F;
        });
      },
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
            border: Border.all(
              color: ColorConstants.roundedRectangleColor.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: ColorConstants.roundedRectangleColor.withOpacity(0.3)),
        margin: EdgeInsets.only(
          top: 15.h,
          left: 60.w,
          right: 60.w,
          bottom: 20.h,
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 30.w),
              child: Image.asset(
                'assets/icon-png/ic_female.png',
                width: 40.w,
                height: 40.h,
                color: ColorConstants.buttonGradient2,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'rp_emegtei'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 21.sp,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 30.w),
              child: Radio(
                fillColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                value: Gender.F,
                groupValue: gender,
                onChanged: (Gender? value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
