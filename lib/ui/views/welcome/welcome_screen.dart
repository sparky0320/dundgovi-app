import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/views/authentication/terms_of_service.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/image_strings.dart';
import '../../../core/constants/sizes.dart';
import '../../component/buttons/gradient_button_small.dart';
import '../login/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackColor(),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(welcomeBackImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Image(
              image: const AssetImage(
                welcomeIcon,
              ),
              width: resWidth(context) * 0.43,
            ),
          ),
          Positioned(
            bottom: buttonBottomSpace.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GradientButtonSmall(
                  text: 'l1_newtreh'.tr,
                  color1: ColorConstants.buttonGradient2,
                  color2: ColorConstants.buttonGradient1,
                  textColor: mainWhite,
                  isShadow: false,
                  onPressed: () {
                    Get.to(
                      () => const LoginScreen(),
                      duration: const Duration(milliseconds: 500),
                      transition: Transition.rightToLeftWithFade,
                    );
                  },
                ),
                SizedBox(height: buttonSpaceSize.h),
                GradientButtonSmall(
                  text: 'l1_bvrtgvvleh'.tr,
                  color1: ColorConstants.neutralColor2,
                  color2: ColorConstants.neutralColor2,
                  textColor: ColorConstants.primaryColor,
                  isShadow: false,
                  onPressed: () {
                    Get.to(
                      () => TermsOfService(view: false),
                      duration: const Duration(milliseconds: 500),
                      transition: Transition.rightToLeftWithFade,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
