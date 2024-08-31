import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/ui/views/signup/info_screen.dart';

import '../../../core/controllers/authentication/get_info_controller.dart';
import '../../component/buttons/gradient_button_small.dart';

class HeightScreen extends StatefulWidget {
  final PageController? pageController;
  final Function? pageNum;
  final Function? updatevalue;
  final bool? isBack;
  final InfoScreenState infoScreenState;

  final GetInfoController? ctrl;
  final getTo;

  HeightScreen({
    required this.infoScreenState,
    this.pageNum,
    this.pageController,
    this.updatevalue,
    this.isBack = false,
    this.ctrl,
    this.getTo,
  });

  @override
  _HeightScreenState createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  bool cmSelected = true;
  bool ftSelected = false;
  bool unit = true;
  var ftHeight = 4;
  var inchHeight = 11;
  int? cmHeight = 150;

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
                    "Таны өндөр хэд вэ?",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: mainWhite,
                      fontSize: 30.sp,
                    ),
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
                _heightUnitPicker(fullHeight),
                _heightSelector(fullHeight),
                Container(
                  margin: EdgeInsets.only(
                    bottom: fullHeight * 0.08,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: GradientButtonSmall(
                    text: 'rp_vrgeljlvvleh'.tr,
                    isShadow: false,
                    color1: ColorConstants.buttonGradient2,
                    color2: ColorConstants.buttonGradient1,
                    textColor: mainWhite,
                    onPressed: () {
                      setState(() {
                        widget.updatevalue!(0.56);
                        widget.pageNum!(4);
                      });

                      convert();
                      widget.ctrl!.height = cmHeight.toString();

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
        });
  }

  _heightUnitPicker(double fullHeight) {
    return Container(
      margin: EdgeInsets.only(top: fullHeight * 0.03),
      height: 60.h,
      width: 205.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: mainGrey, width: 1.5),
        color: ColorConstants.progressBackgroundColor.withOpacity(0.4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                cmSelected = true;
                ftSelected = false;
                unit = true;
              });
            },
            child: Container(
              width: 100.w,
              child: Center(
                child: Text(
                  "CM",
                  style: TextStyle(
                      color: cmSelected ? mainWhite : mainGrey,
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
                cmSelected = false;
                ftSelected = true;
                unit = false;
              });
            },
            child: Container(
              width: 100.w,
              child: Center(
                child: Text(
                  "FT",
                  style: TextStyle(
                      color: ftSelected ? mainWhite : mainGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _heightSelector(double fullHeight) {
    if (unit == false) {
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
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
                  height: 300.h,
                  child: CupertinoPicker(
                    scrollController:
                        FixedExtentScrollController(initialItem: 4),
                    useMagnifier: true,
                    magnification: 1.05,
                    looping: true,
                    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                      background: Colors.transparent,
                    ),
                    onSelectedItemChanged: (value) {
                      setState(() {
                        ftHeight = value;
                      });
                    },
                    itemExtent: 75.0,
                    children: List.generate(14, (index) {
                      return Text(
                        "$index '",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold),
                      );
                    }),
                  ),
                ),
                Container(
                  width: 125.w,
                  height: 300.h,
                  child: CupertinoPicker(
                    scrollController:
                        FixedExtentScrollController(initialItem: 11),
                    useMagnifier: true,
                    magnification: 1.05,
                    looping: true,
                    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                      background: Colors.transparent,
                    ),
                    onSelectedItemChanged: (value) {
                      setState(() {
                        inchHeight = value;
                      });
                    },
                    itemExtent: 75.0,
                    children: List.generate(12, (index) {
                      return Text(
                        "$index \"",
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
          ],
        ),
      );
    } else {
      return Expanded(
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
              height: 300.h,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(initialItem: 130),
                useMagnifier: true,
                magnification: 1.05,
                looping: true,
                selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                  background: Colors.transparent,
                ),
                onSelectedItemChanged: (value) {
                  setState(() {
                    value += 20;
                    cmHeight = value;
                  });
                },
                itemExtent: 75.0,
                children: List.generate(381, (index) {
                  index += 20;
                  return Text(
                    "$index",
                    style: TextStyle(
                        color: mainWhite,
                        fontSize: 48.sp,
                        fontWeight: FontWeight.bold),
                  );
                }),
              ),
            ),
          ],
        ),
      );
    }
  }

  convert() {
    if (unit == false) {
      var h = (ftHeight * 30.48) + (inchHeight * 2.59);
      cmHeight = h.toInt();
    }
  }
}
