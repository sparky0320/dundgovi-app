import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/gradient_button_small.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepLength extends StatefulWidget {
  const StepLength({super.key});

  @override
  State<StepLength> createState() => _StepLengthState();
}

class _StepLengthState extends State<StepLength> {
  double? cmStepLength;

  int h = 170;

  bool auto = true;

  @override
  void initState() {
    autoCalc();
    super.initState();
  }

  _stepLengthSelector(double fullHeight) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    auto = false;
                    cmStepLength = cmStepLength! - 1;
                  });
                },
                child: Icon(Icons.remove, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  backgroundColor: mainGrey, // <-- Button color
                  // foregroundColor: Colors.red, // <-- Splash color
                ),
              ),
              Container(
                width: 125.w,
                height: 150.h,
                child: Center(
                    child: Text(
                  "${(cmStepLength!.toInt())} cm",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                )),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    auto = false;
                    cmStepLength = cmStepLength! + 1;
                  });
                },
                child: Icon(Icons.add, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  backgroundColor: mainGrey, // <-- Button color
                  // foregroundColor: Colors.red, // <-- Splash color
                ),
              )
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Text(
                    "Таны $h см өндөрт тулгуурлан автоматаар тооцоол",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  height: 60,
                  child: Switch(
                    // This bool value toggles the switch.
                    value: auto,
                    activeColor: mainGreen,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        auto = value;
                        if (auto == true) {
                          autoCalc();
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void autoCalc() {
    setState(() {
      if (appController.user.value.height != null) {
        h = int.parse(appController.user.value.height!);
      } else {
        h = 170;
      }
      cmStepLength = h * 0.4;
    });
  }

  @override
  Widget build(BuildContext context) {
    var fullHeight = MediaQuery.of(context).size.height;
    var fullWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
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
                          "pp_alham_urt_hed_we".tr,
                          maxLines: 2,
                          textAlign: TextAlign.center,
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
                _stepLengthSelector(fullHeight),
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
                      var _prefs = await SharedPreferences.getInstance();
                      _prefs.setDouble('step_length', cmStepLength!);
                      print(_prefs.getDouble('step_length'));
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
