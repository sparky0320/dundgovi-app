import 'package:get/get.dart';
import 'package:move_to_earn/ui/views/login/login_screen.dart';
import 'package:move_to_earn/ui/views/main_page.dart';
import 'package:move_to_earn/ui/views/onboarding/onboarding_screen.dart';
import 'package:move_to_earn/ui/views/select_language_page.dart';
import 'package:move_to_earn/ui/views/welcome/welcome_screen.dart';

class AppRouter {
  AppRouter._();

  static final routes = <GetPage>[
    GetPage(
      name: '/',
      page: () => SelectLanguagePage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 800),
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 800),
    ),
    GetPage(
      name: '/welcome-screen',
      page: () => WelcomeScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 800),
    ),
    GetPage(
      name: '/main-page',
      page: () => MainPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 800),
    ),
    GetPage(
      name: '/onboard',
      page: () => OnboardingScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 800),
    ),
    // GetPage(
    //   name: '/webViewContainer',
    //   page: () => WebViewContainer(),
    //   transition: Transition.rightToLeftWithFade,
    //   transitionDuration: Duration(milliseconds: 800),
    // ),
  ];
}
