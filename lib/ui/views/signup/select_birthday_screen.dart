import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/ui/views/signup/info_screen.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/values.dart';
import '../../../core/controllers/authentication/get_info_controller.dart';
import '../../component/buttons/gradient_button_small.dart';

class SelectBirthdayScreen extends StatefulWidget {
  final PageController? pageController;
  final Function? pageNum;
  final Function? updatevalue;
  final bool? isBack;
  final GetInfoController? ctrl;
  final getTo;
  final InfoScreenState infoScreenState;

  const SelectBirthdayScreen({
    super.key,
    this.pageController,
    this.pageNum,
    required this.infoScreenState,
    this.updatevalue,
    this.isBack = false,
    this.ctrl,
    this.getTo,
  });

  @override
  State<SelectBirthdayScreen> createState() => _SelectBirthdayScreenState();
}

class _SelectBirthdayScreenState extends State<SelectBirthdayScreen> {
  var year = 2000;
  var month = 1;
  var day = 1;

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
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Төрсөн өдрөө сонгоно уу",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: mainWhite,
                      fontSize: 30.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                _birthdaySelector(fullHeight),
                Expanded(
                  child: Container(
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
                      onPressed:
                          // widget.getTo
                          () async {
                        setState(() {
                          widget.updatevalue!(0.70);
                          widget.pageNum!(5);
                        });

                        // widget.ctrl!.selectedDate =
                        //     year.toString() + month.toString() + day.toString();

                        widget.ctrl!.selectedDate = year.toString() +
                            "-" +
                            month.toString() +
                            "-" +
                            day.toString();

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
        });
  }

  _birthdaySelector(double fullHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                    color: mainWhite.withOpacity(0.8),
                  ),
                ),
              ),
              Container(
                width: 105.w,
                height: 300.h,
                child: CupertinoPicker(
                  scrollController:
                      FixedExtentScrollController(initialItem: 100),
                  useMagnifier: true,
                  magnification: 1.05,
                  looping: true,
                  selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                    background: Colors.transparent,
                  ),
                  onSelectedItemChanged: (value) {
                    setState(() {
                      year = 1900 + value;
                    });
                  },
                  itemExtent: 75.0,
                  children: List.generate(123, (index) {
                    return Text(
                      "${1900 + index}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold),
                    );
                  }),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 30.h,
                  left: 15.w,
                ),
                child: Text(
                  "-",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 80.w,
                height: 300.h,
                child: CupertinoPicker(
                  useMagnifier: true,
                  magnification: 1.05,
                  looping: true,
                  selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                    background: Colors.transparent,
                  ),
                  onSelectedItemChanged: (value) {
                    setState(() {
                      month = value + 1;
                    });
                  },
                  itemExtent: 75.0,
                  children: List.generate(12, (index) {
                    return Text(
                      "${1 + index}",
                      style: TextStyle(
                          color: mainWhite,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold),
                    );
                  }),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 30.h,
                ),
                child: Text(
                  "-",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 80.w,
                height: 300.h,
                child: CupertinoPicker(
                  useMagnifier: true,
                  magnification: 1.05,
                  looping: true,
                  selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                    background: Colors.transparent,
                  ),
                  onSelectedItemChanged: (value) {
                    setState(() {
                      day = value + 1;
                    });
                  },
                  itemExtent: 75.0,
                  children: List.generate(31, (index) {
                    return Text(
                      "${1 + index}",
                      style: TextStyle(
                          color: mainWhite,
                          fontSize: 40.sp,
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
  }
}
