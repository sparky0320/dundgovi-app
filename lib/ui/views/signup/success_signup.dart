import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/views/login/login_screen.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/image_strings.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/text_strings.dart';
import '../../../core/models/model_button.dart';
import '../../component/buttons/gradient_button_old.dart';

class SuccessSignupScreen extends StatelessWidget {
  const SuccessSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginButton = LoginSignUpButton(
      model: ButtonModel(
        color1: ColorConstants.gradientColor1,
        color2: ColorConstants.gradientColor2,
        color3: ColorConstants.gradientColor3,
        color4: ColorConstants.gradientColor4,
        color5: ColorConstants.gradientColor5,
        borderColor: Colors.transparent,
        text: loginText,
        icon: "",
        textStyle: TTextTheme.lightTextTheme.bodySmall,
        getTo: () {
          Get.to(
            () => LoginScreen(),
            duration: const Duration(milliseconds: 500),
            transition: Transition.rightToLeftWithFade,
          );
        },
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          BackColor(),
          Center(
            child: SvgPicture.asset(successIcon),
          ),
          Positioned(
            bottom: buttonBottomSpace.h,
            left: 0,
            right: 0,
            child: Column(
              children: [loginButton],
            ),
          ),
        ],
      ),
    );
  }
}
