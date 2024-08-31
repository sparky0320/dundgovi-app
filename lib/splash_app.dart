import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:lambda/modules/agent/agent_controller.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:lottie/lottie.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/splash_screen_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'package:move_to_earn/core/connection.dart';
import 'package:move_to_earn/core/constants/image_strings.dart';
import 'package:move_to_earn/core/constants/util.dart';
import 'package:move_to_earn/core/controllers/app_controller.dart';
import 'package:move_to_earn/core/controllers/firebase_remote_config.dart';
import 'package:move_to_earn/core/controllers/notification_controller.dart';
import 'package:move_to_earn/core/translate/language_ctrl.dart';
import 'package:move_to_earn/core/translate/locale.dart';
import 'package:move_to_earn/firebase_options.dart';
import 'package:move_to_earn/main.dart';
import 'package:move_to_earn/service.dart';

class SplashApp extends StatefulWidget {
  final ValueSetter<String> onInitializationComplete;
  final bool initializationShouldFail;

  const SplashApp({
    required Key key,
    required this.onInitializationComplete,
    this.initializationShouldFail = false,
  }) : super(key: key);

  @override
  _SplashAppState createState() => _SplashAppState();
}

class _SplashAppState extends State<SplashApp>
    with SingleTickerProviderStateMixin {
  bool _hasError = false;
  RxBool animate = false.obs;
  bool _isAnimating = false;

  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _fadeAnimation1;
  late Timer _timer;
  bool devS = false;

  late final ctrl;
  bool? isDevMode;

  @override
  void initState() {
    super.initState();
    print(selectedLocale1 + '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
    _getLang();
    _isDevMod();
    // splashAnimation();
    if (widget.initializationShouldFail) {
      // _animationController.addStatusListener((status) {
      //   if (status == AnimationStatus.completed) {
      loadingAndError();
      //   }
      // });
    } else {
      // _animationController.addStatusListener((status) {
      //   if (status == AnimationStatus.completed) {
      loadingAndSuccess();
      //   }
      // });
    }
  }

  _getLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedLocale1 = '${prefs.getString('selectedLocaleLast')}';
  }

  _isDevMod() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDevMode = prefs.getBool('isDev');
    });
  }

  Future<void> loadingAndError() async {
    Future.delayed(
      Duration(milliseconds: 1500),
      () {
        setState(() {
          _hasError = true;
        });
      },
    );
  }

  Future<void> _startOperation() async {
    _timer = Timer(const Duration(seconds: 5), () {
      print('LongPress Event');
      setState(() {
        devS = true;
      });

      toast("Dev mode-руу текст дарж шилжинэ үү...",
          print: true, textColor: greenColor, bgColor: black);
    });
  }

  _setDevs() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isDev') == true) {
      prefs.setBool('isDev', false);
      prefs.setBool('is_auth', false);
      setState(() {
        isDevMode = false;
      });
    } else {
      prefs.setBool('isDev', true);
      prefs.setBool('is_auth', false);
      setState(() {
        isDevMode = true;
      });
    }
    print(prefs.getBool('isDev'));
    // setState(() {
    //   isDev = true;
    // });
    // print(isDev);
  }

  Future<void> loadingAndSuccess() async {
    try {
      PackageInfo pInfo = await PackageInfo.fromPlatform();
      appVersion = pInfo.version + '+' + pInfo.buildNumber;
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
      await MobileAds.instance.initialize();

      Get.put(AppController());
      Get.put(AgentController());
      Get.put(NetworkUtil());
      Get.put(NotificationController());
      Get.put(LanguageController());

      if (Platform.isAndroid) {
        await AndroidAlarmManager.initialize();
        final int helloAlarmID = 0;
        DateTime now = DateTime.now();
        int initialMinute = 0;
        initialMinute = 60 - now.minute;
        await AndroidAlarmManager.periodic(
            const Duration(hours: 1), helloAlarmID, callbackDispatcher,
            wakeup: true,
            allowWhileIdle: true,
            startAt: now.add(Duration(minutes: initialMinute)));
      }
      Hive.init((await getApplicationDocumentsDirectory()).path);

      //Where i go
      ctrl = Get.put(SplashScreenController());
      String checkedRoute = await ctrl.checkNextRoute();
      // if (await checkConnection()) {
      await fetchConfig(checkedRoute);
      // }
    } catch (e, stackTrace) {
      print("Failed to initialize Firebase: $e");
      print(stackTrace);
    }
  }

  Future fetchConfig(checkedRoute) async {
    final prefs = await SharedPreferences.getInstance();
    // if (await checkConnection()) {
    try {
      if (await checkConnection()) {
        print("FETCH CONFIG");

        await FireBaseRemoteConfig(prefs.getBool('isDev'));
        await getTranslate();

        // save init date
        if (await prefs.getString('sendStepDate') == null) {
          await prefs.setString(
              "sendStepDate", DateTime.now().toIso8601String());
        }

        prefs.setInt('Connection', 1);
        Future.delayed(
          Duration(milliseconds: 200),
          () => widget.onInitializationComplete(checkedRoute),
        );
      } else {
        toast("Интернет холболтоо шалгана уу.".tr,
            print: true, textColor: greenColor, bgColor: black);
        prefs.setInt('Connection', 0);
        loadingAndError();
      }

      // } else {
    } catch (e) {
      toast("Интернет холболтоо шалгана уу.".tr,
          print: true, textColor: greenColor, bgColor: black);
      prefs.setInt('Connection', 0);
      loadingAndError();
    }
  }

  final NetworkUtil _http = Get.put(NetworkUtil());

  setTranslate() async {
    final prefs = await SharedPreferences.getInstance();
    final String? english = prefs.getString('en');
    final String? russian = prefs.getString('ru');
    final String? mongolia = prefs.getString('mn');
    // print('json decode -------${jsonDecode(english!)}');

    en = convertType(jsonDecode(english!));
    ru = convertType(jsonDecode(russian!));
    mn = convertType(jsonDecode(mongolia!));
  }

  convertType(data) {
    Map<String, String> convertedMap = Map.from(data.map((key, value) {
      return MapEntry<String, String>(key, value.toString());
    }));
    return convertedMap;
  }

  getTranslate() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // /// english
      final response = await _http.getTranslate('/i18n/en.json', base: baseUrl);
      if (response != null) {
        Map<String, dynamic> flatJson = Util.convertNestedJson(response);
        prefs.setString('en', jsonEncode(flatJson));
      }

      /// russia
      final responseRU =
          await _http.getTranslate('/i18n/ru.json', base: baseUrl);
      if (responseRU != null) {
        Map<String, dynamic> flatJson = Util.convertNestedJson(responseRU);
        prefs.setString('ru', jsonEncode(flatJson));
      }

      /// mongolia
      final responseMN = await _http.getTranslate('/i18n/mn.json');
      if (responseMN != null) {
        Map<String, dynamic> flatJsonMN = Util.convertNestedJson(responseMN);
        prefs.setString('mn', jsonEncode(flatJsonMN));
      }
      if (responseMN == null) {
        Get.defaultDialog(
            title: "alert_internet_shalgana_uu".tr,
            content: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: ColorConstants.primaryColor1,
                shape: StadiumBorder(),
                side: BorderSide(width: 2, color: Colors.white),
              ),
              onPressed: () {
                agentController.logout();
                appController.logout();
                appController.setUser(null);
                main();
              },
              child: Text(
                'Дахин ачааллах',
                style: TextStyle(color: white),
              ),
            ),
            barrierDismissible: false);
      }
      await setTranslate();
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  // splashAnimation() async {
  //   _animationController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 4000),
  //   );

  //   _rotateAnimation = TweenSequence(
  //     [
  //       TweenSequenceItem(
  //         tween: Tween(begin: 1.5 * pi, end: pi)
  //             .chain(CurveTween(curve: Curves.linear)),
  //         weight: 1,
  //       ),
  //       TweenSequenceItem<double>(
  //         tween: ConstantTween<double>(pi),
  //         weight: 1,
  //       ),
  //       TweenSequenceItem(
  //         tween: Tween(begin: pi, end: 0.0)
  //             .chain(CurveTween(curve: Curves.linear)),
  //         weight: 1,
  //       ),
  //       TweenSequenceItem<double>(
  //         tween: ConstantTween<double>(pi),
  //         weight: 1,
  //       ),
  //       TweenSequenceItem(
  //         tween: Tween(begin: 2 * pi, end: pi)
  //             .chain(CurveTween(curve: Curves.linear)),
  //         weight: 1,
  //       ),
  //     ],
  //   ).animate(
  //     CurvedAnimation(
  //       parent: _animationController,
  //       curve: Interval(
  //         0.2,
  //         0.7,
  //         curve: Curves.linear,
  //       ),
  //     ),
  //   );

  //   _scaleAnimation = TweenSequence(
  //     [
  //       TweenSequenceItem(
  //         tween: Tween(begin: 0.5, end: 1.0)
  //             .chain(CurveTween(curve: Curves.linear)),
  //         weight: 1,
  //       ),
  //       TweenSequenceItem<double>(
  //         tween: ConstantTween<double>(1.0),
  //         weight: 1,
  //       ),
  //       TweenSequenceItem(
  //         tween: Tween(begin: 1.0, end: 0.5)
  //             .chain(CurveTween(curve: Curves.linear)),
  //         weight: 1,
  //       ),
  //       TweenSequenceItem<double>(
  //         tween: ConstantTween<double>(0.5),
  //         weight: 1,
  //       ),
  //       TweenSequenceItem(
  //         tween: Tween(begin: 0.5, end: 20.0)
  //             .chain(CurveTween(curve: Curves.linear)),
  //         weight: 1,
  //       ),
  //     ],
  //   ).animate(
  //     CurvedAnimation(
  //       parent: _animationController,
  //       curve: Interval(
  //         0.2,
  //         0.7,
  //         curve: Curves.linear,
  //       ),
  //     ),
  //   );

  //   _slideAnimation = Tween<Offset>(
  //     begin: Offset(0, 10),
  //     end: Offset.zero,
  //   ).animate(
  //     CurvedAnimation(
  //       parent: _animationController,
  //       curve: Interval(0.0, 0.1, curve: Curves.easeOut),
  //     ),
  //   );

  //   _fadeAnimation = Tween<double>(
  //     begin: 1.0,
  //     end: 0.0,
  //   ).animate(
  //     CurvedAnimation(
  //       parent: _animationController,
  //       curve: Interval(0.6, 0.8, curve: Curves.easeIn), // Adjust timing here
  //     ),
  //   );

  //   _fadeAnimation1 = Tween<double>(
  //     begin: 0.0,
  //     end: 1.0,
  //   ).animate(
  //     CurvedAnimation(
  //       parent: _animationController,
  //       curve: Interval(0.8, 1.0, curve: Curves.easeIn), // Adjust timing here
  //     ),
  //   );

  //   _animationController.forward().then((_) {
  //     setState(() {
  //       _isAnimating = true;
  //     });
  //     // });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);

        return MediaQuery(
          child: child!,
          data: mediaQueryData.copyWith(
            textScaler: TextScaler.linear(1.0),
          ),
        );
      },
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_hasError) {
      return Scaffold(
        backgroundColor: Color(0xff0E1C26),
        body: Stack(
          alignment: Alignment.center,
          children: [
            // AnimatedBuilder(
            //   animation: _animationController,
            //   builder: (context, child) {
            //     return SlideTransition(
            //       position: _slideAnimation,
            //       child: Transform.rotate(
            //         angle: _rotateAnimation.value,
            //         child: Transform.scale(
            //           scale: _scaleAnimation.value,
            //           child: FadeTransition(
            //             opacity: _fadeAnimation,
            //             child: AnimatedContainer(
            //               duration: Duration(milliseconds: 350),
            //               width: 100,
            //               height: 100,
            //               decoration: BoxDecoration(
            //                 borderRadius:
            //                     BorderRadius.circular(_isAnimating ? 50 : 0),
            //                 image: DecorationImage(
            //                     alignment: Alignment(-.2, 0),
            //                     image: AssetImage(rectangle),
            //                     fit: BoxFit.cover),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
            // FadeTransition(
            //   opacity: _fadeAnimation1,
            //   child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 75,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(splashLogo),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTapDown: (_) {
                    _startOperation();
                  },
                  onTapUp: (_) {
                    _timer.cancel();
                    if (!devS) {
                      print("Is a onTap event");
                    } else {
                      devS = false;
                    }
                  },
                  child: Lottie.asset('assets/lottie/walk.json',
                      width: 70, fit: BoxFit.fill, repeat: true),
                ),
                Center(
                  child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered))
                              return Colors.blue.withOpacity(0.04);
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.pressed))
                              return Colors.blue.withOpacity(0.12);
                            return null; // Defer to the widget's default.
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: Text('АЛДАА ГАРЛАА')),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    side: BorderSide(width: 2, color: Colors.white),
                  ),
                  onPressed: () {
                    main();
                  },
                  child: Text(
                    'Дахин ачааллах',
                    style: TextStyle(color: white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                devS == true
                    ? Center(
                        child: TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered))
                                    return Colors.blue.withOpacity(0.04);
                                  if (states.contains(MaterialState.focused) ||
                                      states.contains(MaterialState.pressed))
                                    return Colors.blue.withOpacity(0.12);
                                  return null; // Defer to the widget's default.
                                },
                              ),
                            ),
                            onPressed: () {
                              // main();
                              _setDevs();
                            },
                            child: Text(
                                'Та developer mode-оор үргэлжлүүлэх гэж байна')),
                      )
                    : Text(''),
                isDevMode == true
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.hovered))
                                        return Colors.blue.withOpacity(0.04);
                                      if (states.contains(
                                              MaterialState.focused) ||
                                          states
                                              .contains(MaterialState.pressed))
                                        return Colors.blue.withOpacity(0.12);
                                      return null; // Defer to the widget's default.
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  // main();
                                  _setDevs();
                                },
                                child: Text(
                                  'Та тестийн орчинд байна.',
                                  style: TextStyle(color: redColor),
                                )),
                          ),
                        ],
                      )
                    : Text(''),
              ],
            ),
            // ),
          ],
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color(0xff0E1C26),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // AnimatedBuilder(
          //   animation: _animationController,
          //   builder: (context, child) {
          //     return SlideTransition(
          //       position: _slideAnimation,
          //       child: Transform.rotate(
          //         angle: _rotateAnimation.value,
          //         child: Transform.scale(
          //           scale: _scaleAnimation.value,
          //           child: FadeTransition(
          //             opacity: _fadeAnimation,
          //             child: AnimatedContainer(
          //               duration: Duration(milliseconds: 350),
          //               width: 100,
          //               height: 100,
          //               decoration: BoxDecoration(
          //                 borderRadius:
          //                     BorderRadius.circular(_isAnimating ? 50 : 0),
          //                 image: DecorationImage(
          //                     alignment: Alignment(-.2, 0),
          //                     image: AssetImage(rectangle),
          //                     fit: BoxFit.cover),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
          // FadeTransition(
          //   opacity: _fadeAnimation1,
          //   child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 75,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(splashLogo),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Lottie.asset('assets/lottie/walk.json',
                  width: 70, fit: BoxFit.fill, repeat: true),
            ],
          ),
          // )
        ],
      ),
    );
  }
}
