import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/controllers/authentication/get_info_controller.dart';

import 'package:move_to_earn/ui/views/signup/info_screen.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/values.dart';
import '../../component/buttons/gradient_button_small.dart';

class EnterStepCount extends StatefulWidget {
  final bool? isBack;
  final PageController? pageController;
  final GetInfoController? ctrl;
  final Function? updatevalue;
  final Function? pageNum;

  const EnterStepCount({
    super.key,
    required InfoScreenState infoScreenState,
    this.isBack = false,
    this.ctrl,
    this.updatevalue,
    this.pageNum,
    this.pageController,
  });

  @override
  State<EnterStepCount> createState() => _EnterStepCountState();
}

class _EnterStepCountState extends State<EnterStepCount> {
  int? selectedStepId;

  @override
  void initState() {
    super.initState();
    selectedStepId = stepsDayBefore[0]['steps_id'];
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
                    "Та өдөрт хэд алхдаг вэ?",
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
                    "Танд зориулсан хөтөлбөрийг санал болгоно",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: mainWhite.withOpacity(0.7),
                      fontSize: 18.sp,
                    ),
                  ),
                ),

                countSelector(fullHeight),

                // button
                Container(
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
                        widget.updatevalue!(1.0);
                        widget.pageNum!(7);
                      });

                      widget.ctrl!.stepsId = selectedStepId;

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

  countSelector(double fullHeight) {
    return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.only(bottom: fullHeight * 0.03),
                child: Image.asset(
                  "assets/icon-png/ic_select_pointer.png",
                  color: mainWhite.withOpacity(0.8),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Container(
              width: 260.w,
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
                    selectedStepId = value + 1;
                  });
                },
                itemExtent: 75.0,
                children: stepsDayBefore.map((e) {
                  return Text(
                    e['value'],
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 36.sp,
                        color: Colors.white),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
