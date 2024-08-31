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

class BodyWeight extends StatefulWidget {
  const BodyWeight({super.key});

  @override
  State<BodyWeight> createState() => _BodyWeightState();
}

class _BodyWeightState extends State<BodyWeight> {
  ProfileCtrl ctrl = Get.put(ProfileCtrl());
  int? weightKG = 50;
  int? _initialItem = 30;

  @override
  void initState() {
    if (appController.user.value.weight != null) {
      weightKG = int.parse(appController.user.value.weight!);
      _initialItem = int.parse(appController.user.value.weight!) - 20;
    }
    super.initState();
  }

  weightSelector(double fullHeight) {
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
                looping: false,
                scrollController:
                    FixedExtentScrollController(initialItem: _initialItem!),
                onSelectedItemChanged: (value) {
                  setState(() {
                    value += 20;
                    weightKG = value;
                    ctrl.weight = weightKG.toString();
                    print(ctrl.weight);
                  });
                },
                itemExtent: 75.0,
                children: List.generate(150, (index) {
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
            Container(
              child: Padding(
                padding: EdgeInsets.only(bottom: fullHeight * 0.025),
                child: Text(
                  "kg",
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var fullHeight = MediaQuery.of(context).size.height / 2;
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
                        "pp_jin_hed_we".tr,
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
                  onPressed: () async {
                    ctrl.editWeight(context);
                    // var _prefs = await SharedPreferences.getInstance();
                    // _prefs.setInt('body_weight', weightKG!);
                    // print(_prefs.getInt('body_weight'));
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
