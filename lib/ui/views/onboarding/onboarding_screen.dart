import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/image_strings.dart';
import 'package:move_to_earn/ui/component/buttons/gradient_button_small.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/controllers/onboarding_controller.dart';
import '../../views/onboarding/onboarding_page.dart';
import '../../../core/models/model_onbaording.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  OnboardingController onboardingController = OnboardingController();
  @override
  void initState() {
    super.initState();
  }

  // Future<void> getData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var lang = prefs.getString("locale");
  // }

  @override
  Widget build(BuildContext context) {
    final pages = [
      OnboardingPage(
        model: OnboardingModel(
          backImage: onboardingBack1,
          image: onboardingIcon1,
          text: 'ob_1_alhaad_mongo_oltsgooy'.tr,
          description: 'ob_1_description'.tr,
        ),
      ),
      OnboardingPage(
        model: OnboardingModel(
          backImage: onboardingBack2,
          image: onboardingIcon2,
          text: 'ob_2_alhah_ervvl_mended_sain'.tr,
          description: 'ob_2_description'.tr,
        ),
      ),
      OnboardingPage(
        model: OnboardingModel(
          backImage: onboardingBack3,
          image: onboardingIcon3,
          text: 'ob_3_vildel_bvriig_uramshuulna'.tr,
          description: 'ob_3_description'.tr,
        ),
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: onboardingController.pageController,
            onPageChanged: onboardingController.onPageChanged,
            children: pages,
          ),
          Positioned(
            bottom: 62.h,
            right: defaultSize.w,
            left: defaultSize.w,
            child: GradientButtonSmall(
              text: "Үргэлжлүүлэх",
              color1: ColorConstants.buttonGradient2,
              color2: ColorConstants.buttonGradient1,
              isShadow: false,
              textColor: white,
              onPressed: () => onboardingController.animateToNextSlide(),
            ),
          ),
          Obx(
            () => Positioned(
              bottom: defaultSize * 1,
              right: defaultSize,
              left: defaultSize,
              child: Container(
                alignment: Alignment.center,
                child: AnimatedSmoothIndicator(
                  count: 3,
                  activeIndex: onboardingController.currentIndex.value,
                  effect: WormEffect(
                      activeDotColor: const Color.fromARGB(255, 255, 255, 255),
                      dotHeight: slideIconSize.h,
                      dotWidth: slideIconSize.h,
                      dotColor: Color.fromARGB(255, 228, 87, 157)),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50.h,
            right: defaultSize.w,
            child: TextButton(
              onPressed: () => onboardingController.skip(),
              child: Text(
                'ob1_algasah'.tr,
                // style: TTextTheme.lightTextTheme.displaySmall,
                style: TextStyle(color: white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
