import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ui/views/welcome/welcome_screen.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);
  RxInt currentIndex = 0.obs;

  void onPageChanged(int index) => currentIndex.value = index;
  skip() => Get.to(
        () => WelcomeScreen(),
        duration: const Duration(milliseconds: 800),
        transition: Transition.rightToLeftWithFade,
      );
  animateToNextSlide() {
    RxInt nextPage = currentIndex + 1;
    nextPage < 3
        ? pageController.animateToPage(nextPage.value,
            duration: const Duration(milliseconds: 800),
            curve: Curves.fastEaseInToSlowEaseOut)
        : Get.to(
            () => WelcomeScreen(),
            duration: const Duration(milliseconds: 800),
            transition: Transition.rightToLeftWithFade,
          );
  }
}
