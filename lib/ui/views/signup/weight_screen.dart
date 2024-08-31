import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/ui/views/signup/info_screen.dart';

import '../../../core/controllers/authentication/get_info_controller.dart';
import '../../component/buttons/gradient_button_small.dart';

class WeightScreen extends StatefulWidget {
  final PageController? pageController;
  final Function? updatevalue;
  final Function? pageNum;
  final InfoScreenState infoScreenState;
  final bool? isBack;
  final GetInfoController? ctrl;

  WeightScreen({
    this.pageController,
    this.updatevalue,
    this.pageNum,
    required this.infoScreenState,
    this.isBack = false,
    this.ctrl,
  });

  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  bool kgSelected = true;
  bool lbsSelected = false;

  bool unit = true;
  int? weightKG = 50;
  int weightLBS = 74;

  // void onWeight(int weightKG) {
  //   setState(() {
  //     widget.ctrl!.weight = weightKG.toString();
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
                  "Таны жин хэд вэ?",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 30.sp),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.h),
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  "Алхалтын зорилго биелэгдэж байгаа эсэхийг мэдэх",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: mainWhite.withOpacity(0.7),
                    fontSize: 18.sp,
                  ),
                ),
              ),
              weightUnitPicker(fullHeight),
              weightSelector(fullHeight),
              Container(
                margin: EdgeInsets.only(
                  bottom: fullHeight * 0.08,
                ),
                alignment: Alignment.bottomCenter,
                child: GradientButtonSmall(
                  isShadow: false,
                  text: 'rp_vrgeljlvvleh'.tr,
                  textColor: mainWhite,
                  color1: ColorConstants.buttonGradient2,
                  color2: ColorConstants.buttonGradient1,
                  onPressed: () {
                    setState(() {
                      widget.updatevalue!(0.42);
                      widget.pageNum!(3);
                    });

                    convert();
                    widget.ctrl!.weight = weightKG.toString();

                    widget.pageController!.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  weightUnitPicker(double fullHeight) {
    return Container(
      margin: EdgeInsets.only(
        top: fullHeight * 0.03,
      ),
      height: 60.h,
      width: 205.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: mainGrey, width: 1.5.w),
        color: ColorConstants.roundedRectangleColor.withOpacity(0.4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                kgSelected = true;
                lbsSelected = false;
                unit = true;
              });
            },
            child: Container(
              width: 100.w,
              child: Center(
                child: Text(
                  "KG",
                  style: TextStyle(
                      color: kgSelected ? mainWhite : mainGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp),
                ),
              ),
            ),
          ),
          Container(
            height: 23.h,
            child: VerticalDivider(
              color: mainGrey,
              width: 1,
              thickness: 1,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                kgSelected = false;
                lbsSelected = true;
                unit = false;
              });
            },
            child: Container(
              width: 100.w,
              child: Center(
                child: Text(
                  "LBS",
                  style: TextStyle(
                      color: lbsSelected ? mainWhite : mainGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  weightSelector(double fullHeight) {
    if (unit == false) {
      return Expanded(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(bottom: fullHeight * 0.025),
                  child: Image.asset(
                    "assets/icon-png/ic_select_pointer.png",
                  ),
                ),
              ),
              Container(
                width: 125.w,
                height: fullHeight * 0.32,
                child: CupertinoPicker(
                  useMagnifier: true,
                  magnification: 1.05,
                  selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                    background: Colors.transparent,
                  ),
                  scrollController: FixedExtentScrollController(initialItem: 0),
                  looping: true,
                  onSelectedItemChanged: (value) {
                    setState(() {
                      value += 44;
                      weightLBS = value;
                    });
                  },
                  itemExtent: 75.0,
                  children: List.generate(397, (index) {
                    index += 44;
                    return Text(
                      "$index",
                      style: TextStyle(
                          color: mainWhite,
                          fontSize: 48.sp,
                          fontWeight: FontWeight.bold),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(bottom: fullHeight * 0.025),
                  child: Image.asset(
                    "assets/icon-png/ic_select_pointer.png",
                    color: mainWhite.withOpacity(0.8),
                  ),
                ),
              ),
              Container(
                width: 125.w,
                height: fullHeight * 0.32,
                child: CupertinoPicker(
                  useMagnifier: true,
                  magnification: 1.05,
                  selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                    background: Colors.transparent,
                  ),
                  looping: true,
                  scrollController:
                      FixedExtentScrollController(initialItem: 30),
                  onSelectedItemChanged: (value) {
                    setState(() {
                      value += 20;
                      weightKG = value;
                    });
                  },
                  itemExtent: 75.0,
                  children: List.generate(180, (index) {
                    index += 20;
                    return Text(
                      "$index",
                      style: TextStyle(
                        color: mainWhite,
                        fontSize: 48.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  convert() {
    if (unit == false) {
      var w = weightLBS * 0.45;
      weightKG = w.toInt();
    }
  }
}
