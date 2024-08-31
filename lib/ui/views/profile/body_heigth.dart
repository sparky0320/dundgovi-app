import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/profile/profile_controller.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/gradient_button_small.dart';

class BodyHeight extends StatefulWidget {
  const BodyHeight({super.key});

  @override
  State<BodyHeight> createState() => _BodyHeightState();
}

class _BodyHeightState extends State<BodyHeight> {
  ProfileCtrl ctrl = Get.put(ProfileCtrl());
  // SharedPreferences? _prefs;
  int? cmHeight = 170;
  int? _initialItem = 120;

  @override
  void initState() {
    super.initState();

    if (appController.user.value.height != null) {
      cmHeight = int.parse(appController.user.value.height!);
      _initialItem = int.parse(appController.user.value.height!) - 50;
    }
    print(appController.user.value.height);
  }

  _heightSelector(double fullHeight) {
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
              scrollController:
                  FixedExtentScrollController(initialItem: _initialItem!),
              useMagnifier: true,
              magnification: 1.05,
              looping: false,
              selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                background: Colors.transparent,
              ),
              onSelectedItemChanged: (value) {
                setState(() {
                  value += 50;
                  cmHeight = value;
                  ctrl.height = cmHeight.toString();
                });
              },
              itemExtent: 75.0,
              children: List.generate(191, (index) {
                index += 50;
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
          Container(
            child: Padding(
              padding: EdgeInsets.only(bottom: fullHeight * 0.025),
              child: Text(
                "cm",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    var fullHeight = MediaQuery.of(context).size.height;
    var fullWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        BackColor(),
        Container(
          height: fullHeight,
          width: fullWidth,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 48.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      iconSize: 32,
                      icon: Icon(
                        Icons.chevron_left,
                        color: mainWhite,
                      ),
                      onPressed: () => Get.back(),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        "pp_undur_hed_we".tr,
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                ),
              ),
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
                  onPressed: () async {
                    // widget.ctrl!.height = cmHeight.toString();
                    ctrl.editHeight(context);
                    // var _prefs = await SharedPreferences.getInstance();
                    // _prefs.setInt('body_height', cmHeight!);
                    // print(_prefs.getInt('body_height'));
                    // Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
