// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';

// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:lambda/modules/agent/agent_controller.dart';
// import 'package:lambda/modules/network_util.dart';
// import 'package:lottie/lottie.dart';
// import 'package:move_to_earn/core/controllers/notification_controller.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:move_to_earn/core/connection.dart';

// import 'package:move_to_earn/core/constants/values.dart';
// import 'package:move_to_earn/core/controllers/app_controller.dart';
// import 'package:move_to_earn/core/controllers/firebase_remote_config.dart';
// import 'package:move_to_earn/core/models/user.dart';
// import 'package:move_to_earn/service.dart';
// import 'package:move_to_earn/ui/views/main_page.dart';
// import 'package:move_to_earn/ui/views/select_language_page.dart';

// import '../../../core/constants/image_strings.dart';
// import '../../../core/controllers/splash_screen_controller.dart';
// import '../../../core/translate/language_ctrl.dart';
// import '../../../core/translate/locale.dart';
// import '../../views/welcome/welcome_screen.dart';

// class SplashScreen extends StatefulWidget {
//   SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   final ctrl = Get.put(SplashScreenController());
//   final AgentController _agentController = Get.put(AgentController());
//   final LanguageController languageController = Get.find();
//   final AppController _appController = Get.find();
//   NetworkUtil netUtil = Get.find();
//   RxBool animate = false.obs;
//   late AnimationController _animationController;
//   late Animation<double> _rotateAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _fadeAnimation1;
//   bool _isAnimating = false;

//   @override
//   void initState() {
//     super.initState();
//     // await Permission.activityRecognition.request();
//     // await Permission.location.request();
//     initConfig();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   splashAnimation() async {
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 4000),
//     );

//     _rotateAnimation = TweenSequence(
//       [
//         TweenSequenceItem(
//           tween: Tween(begin: 1.5 * pi, end: pi)
//               .chain(CurveTween(curve: Curves.linear)),
//           weight: 1,
//         ),
//         TweenSequenceItem<double>(
//           tween: ConstantTween<double>(pi),
//           weight: 1,
//         ),
//         TweenSequenceItem(
//           tween: Tween(begin: pi, end: 0.0)
//               .chain(CurveTween(curve: Curves.linear)),
//           weight: 1,
//         ),
//         TweenSequenceItem<double>(
//           tween: ConstantTween<double>(pi),
//           weight: 1,
//         ),
//         TweenSequenceItem(
//           tween: Tween(begin: 2 * pi, end: pi)
//               .chain(CurveTween(curve: Curves.linear)),
//           weight: 1,
//         ),
//       ],
//     ).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Interval(
//           0.2,
//           0.7,
//           curve: Curves.linear,
//         ),
//       ),
//     );

//     _scaleAnimation = TweenSequence(
//       [
//         TweenSequenceItem(
//           tween: Tween(begin: 0.5, end: 1.0)
//               .chain(CurveTween(curve: Curves.linear)),
//           weight: 1,
//         ),
//         TweenSequenceItem<double>(
//           tween: ConstantTween<double>(1.0),
//           weight: 1,
//         ),
//         TweenSequenceItem(
//           tween: Tween(begin: 1.0, end: 0.5)
//               .chain(CurveTween(curve: Curves.linear)),
//           weight: 1,
//         ),
//         TweenSequenceItem<double>(
//           tween: ConstantTween<double>(0.5),
//           weight: 1,
//         ),
//         TweenSequenceItem(
//           tween: Tween(begin: 0.5, end: 20.0)
//               .chain(CurveTween(curve: Curves.linear)),
//           weight: 1,
//         ),
//       ],
//     ).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Interval(
//           0.2,
//           0.7,
//           curve: Curves.linear,
//         ),
//       ),
//     );

//     _slideAnimation = Tween<Offset>(
//       begin: Offset(0, 10),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Interval(0.0, 0.1, curve: Curves.easeOut),
//       ),
//     );

//     _fadeAnimation = Tween<double>(
//       begin: 1.0,
//       end: 0.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Interval(0.6, 0.8, curve: Curves.easeIn), // Adjust timing here
//       ),
//     );

//     _fadeAnimation1 = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Interval(0.8, 1.0, curve: Curves.easeIn), // Adjust timing here
//       ),
//     );

//     _animationController.forward().then((_) {
//       setState(() {
//         _isAnimating = true;
//       });
//       // });
//     });

//     ctrl.checkAll();
//   }

//   initConfig() async {
//     await splashAnimation();

//     if (Platform.isAndroid) {
//       await AndroidAlarmManager.initialize();
//       final int helloAlarmID = 0;
//       DateTime now = DateTime.now();
//       int initialMinute = 0;
//       initialMinute = 60 - now.minute;
//       await AndroidAlarmManager.periodic(
//           const Duration(hours: 1), helloAlarmID, callbackDispatcher,
//           wakeup: true,
//           allowWhileIdle: true,
//           startAt: now.add(Duration(minutes: initialMinute)));
//     }
//     Hive.init((await getApplicationDocumentsDirectory()).path);

//     await ctrl.checkAll();
//     await startAnimation();
//   }

//   Future fetchConfig() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (await checkConnection()) {
//       print("FETCH CONFIG");
//       await FireBaseRemoteConfig();
//       prefs.setInt('Connection', 1);
//     } else {
//       toast("Интернет холболтоо шалгана уу...",
//           print: true, textColor: greenColor, bgColor: black);
//       prefs.setInt('Connection', 0);
//     }
//   }

//   Future startAnimation({bool version = true}) async {
//     await netUtil.initNetwork(baseUrl);
//     bool isAuth = await _agentController.checkAuth();

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool? hideIntro = prefs.getBool("hideIntro");
//     await Future.delayed(const Duration(microseconds: 500));

//     await Future.delayed(const Duration(milliseconds: 6000));

//     if (isAuth) {
//       User user =
//           new User.fromJson(jsonDecode(_agentController.userData.value));
//       _appController.setUser(user);
//       registerOpenApp(user.id);
//       Get.off(
//         () => MainPage(),
//         duration: const Duration(milliseconds: 500),
//         transition: Transition.rightToLeftWithFade,
//       );
//     } else if (hideIntro != null && hideIntro == true) {
//       Get.to(
//         () => WelcomeScreen(),
//         duration: const Duration(milliseconds: 800),
//         transition: Transition.rightToLeftWithFade,
//       );
//     } else {
//       Get.offAll(
//         () => SelectLanguagePage(),
//         duration: const Duration(milliseconds: 800),
//         transition: Transition.rightToLeftWithFade,
//       );
//     }
//   }

//   Future registerOpenApp(userId) async {
//     final response = await netUtil.get('/api/register-open-app/$userId');
//     debugPrint('open app register response -----$response');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff0E1C26),
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           AnimatedBuilder(
//             animation: _animationController,
//             builder: (context, child) {
//               return SlideTransition(
//                 position: _slideAnimation,
//                 child: Transform.rotate(
//                   angle: _rotateAnimation.value,
//                   child: Transform.scale(
//                     scale: _scaleAnimation.value,
//                     child: FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: AnimatedContainer(
//                         duration: Duration(milliseconds: 350),
//                         width: 100,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               BorderRadius.circular(_isAnimating ? 50 : 0),
//                           image: DecorationImage(
//                               alignment: Alignment(-.2, 0),
//                               image: AssetImage(rectangle),
//                               fit: BoxFit.cover),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           FadeTransition(
//             opacity: _fadeAnimation1,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 150,
//                       height: 75,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage(splashLogo),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Lottie.asset('assets/lottie/walk.json',
//                     width: 70, fit: BoxFit.fill, repeat: true),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
