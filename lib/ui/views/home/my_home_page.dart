// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'dart:ui';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lambda/modules/gcm/notify.dart';
import 'package:lambda/utils/hexColor.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/image_strings.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/app_controller.dart';
import 'package:move_to_earn/core/controllers/firebase_remote_config.dart';
import 'package:move_to_earn/core/controllers/invite_friend/invite_friend_controller.dart';
import 'package:move_to_earn/core/controllers/notification_controller.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/views/home/ads.dart';
import 'package:move_to_earn/ui/views/banners/home_slider_banner.dart';
import 'package:move_to_earn/ui/views/home/banner.dart';
import 'package:move_to_earn/ui/views/home/birthday_page.dart';
import 'package:move_to_earn/ui/views/home/check_version.dart';
import 'package:move_to_earn/ui/views/home/modalbottoms.dart';
import 'package:move_to_earn/ui/views/home/profile_noti.dart';
import 'package:move_to_earn/ui/component/headers/score_for_header.dart';
import 'package:move_to_earn/ui/views/home/steps_history.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pedometer_db/pedometer_db.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/controllers/homepage/my_home_page_controller.dart';
import 'invite_friend_home.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final MyHomePageCtrl controller = Get.put(MyHomePageCtrl());
  late AnimationController _breathingController;
  Notify notify = Notify();
  NotificationController notificationController = Get.find();
  final AppController appController = Get.put(AppController());
  InviteFriendCtrl ctrl = Get.put(InviteFriendCtrl());

  late List<bool> itemLocks;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final _pedometerDB = PedometerDb();

  final formattedYear = DateFormat('yyyy').format(DateTime.now());
  final formattedDay = DateFormat('MM-dd').format(DateTime.now());
  // // String formatter = DateFormat('yMd').format(now);
  // // final now = new DateTime.now();
  // var year = DateFormat('yyyy');
  // var bday = DateFormat('MM-dd');
  // // String formattedYear = year.format(now);
  // // String formattedDay = bday.format(now);
  String userBday = '';
  String userBday_gift_year = '';
  String userBday_gift_day = '';
  var _breathe = 0.0;
  var breathSec = 500;

  @override
  void initState() {
    super.initState();
    itemLocks = List.generate(10, (index) => index == 0 ? false : true);
    initFcm();
    FootBreath();
    _pedometerDB.initialize();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        notificationController.listenNotification();

        if (Platform.isIOS) {
          await appController.refreshStepDataIos(_pedometerDB);
        }

        // await appController.getAds();
        if (Platform.isAndroid) {
          if (appController.stepCount.value != null &&
              appController.stepCount.value != 0 &&
              appController.dailyGoal.value != null &&
              appController.dailyGoal.value != 0) {
            checkDailyGoalPercent();
          }
        } else {
          if (appController.healthStep.value != null &&
              appController.healthStep.value != 0 &&
              appController.dailyGoal.value != null &&
              appController.dailyGoal.value != 0) {
            checkDailyGoalPercent();
          }
        }

        await Future.delayed(Duration(seconds: 2));

        if (await appController.isDateDifferent()) {
          // await appController.checkBeforeDays();
          appController.stepsLastMoth();

          await Future.delayed(Duration(seconds: 1));
        }
        await sendStepV1();
      },
    );
    checkBday();
  }

  void FootBreath() {
    _breathingController = AnimationController(
        vsync: this, duration: Duration(milliseconds: breathSec));
    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _breathingController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _breathingController.forward();
      }
    });

    _breathingController.addListener(() {
      setState(() {
        _breathe = _breathingController.value;
      });
    });
    _breathingController.forward();
  }

  checkBday() async {
    await Future.delayed(Duration(seconds: 2));
    await bDayFormatter();
    await bDayChecker();
  }

  bDayFormatter() async {
    if (appController.user.value.birthday != null) {
      userBday = appController.user.value.birthday!.substring(5, 10);
    }
    if (appController.user.value.bdayGiftDate != null) {
      userBday_gift_day =
          appController.user.value.bdayGiftDate!.substring(5, 10);
      userBday_gift_year =
          appController.user.value.bdayGiftDate!.substring(0, 4);
    }
  }

  bDayChecker() async {
    if (formattedDay == userBday && userBday_gift_year != formattedYear) {
      Get.to(
        BirthdayPage(),
        duration: const Duration(milliseconds: 1000),
        transition: Transition.zoom,
      );
    }
  }

  sendStepV1() async {
    if (Platform.isAndroid) {
      await appController.todaySendStepAndroid();
    } else {
      await appController.todaySendStepIOS();
    }

    final cron = Cron();

    cron.schedule(Schedule.parse('* */24 * * *'), () async {
      if (Platform.isAndroid) {
        await appController.todaySendStepAndroid();
      } else {
        await appController.todaySendStepIOS();
      }
    });
  }

  checkDailyGoalPercent() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    if (Platform.isIOS || Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          iOS: DarwinInitializationSettings(),
          android: AndroidInitializationSettings('app_icon'),
        ),
      );
    }

    var goal = appController.dailyGoal.value;
    var stepCount;
    if (Platform.isAndroid) {
      stepCount = appController.stepCount.value;
    } else {
      stepCount = appController.healthStep.value - appController.addedStepData;
    }

    if (goal <= stepCount) {
      if (!await appController.checkIsTodayShowDone()) {
        flutterLocalNotificationsPlugin.show(
          777,
          'GoCare',
          "Баяр хүргэе. Та өнөөдөр ${NumberFormat().format(goal)} алхам хийж чадлаа.",
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'gocare_foreground',
              'GOCARE FOREGROUND SERVICE',
              icon: 'app_icon',
              ongoing: true,
            ),
          ),
        );
      }
    }

    if (goal / 2 <= stepCount && goal / 5 * 4 >= stepCount) {
      if (!await appController.checkIsTodayShowPercent50()) {
        flutterLocalNotificationsPlugin.show(
          777,
          'GoCare',
          "Та ${NumberFormat().format(stepCount)} алхам хийсэн байна. ${NumberFormat().format(goal)} алхам болоход ${NumberFormat().format(goal - stepCount)} алхам үлдлээ",
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'gocare_foreground',
              'GOCARE FOREGROUND SERVICE',
              icon: 'app_icon',
              ongoing: true,
            ),
          ),
        );
      }
    }

    if (goal / 5 * 4 <= stepCount && goal >= stepCount) {
      if (!await appController.checkIsTodayShowPercent80()) {
        flutterLocalNotificationsPlugin.show(
          777,
          'GoCare',
          "Та ${NumberFormat().format(stepCount)} алхам хийсэн байна. ${NumberFormat().format(goal)} алхам болоход ${NumberFormat().format(goal - stepCount)} алхам үлдлээ",
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'gocare_foreground',
              'GOCARE FOREGROUND SERVICE',
              icon: 'app_icon',
              ongoing: true,
            ),
          ),
        );
      }
    }
  }

  initFcm() async {
    final prefs = await SharedPreferences.getInstance();
    if (!appController.fcmLoaded && appController.isAuth()) {
      notify.initNotify(
        appController.user.value.id.toString(),
        context,
      );
      appController.fcmLoaded = true;
    }

    await FireBaseRemoteConfig(prefs.getBool('isDev'));
    controller.update();
  }

  @override
  void dispose() {
    super.dispose();
    print("DISPOSE");
    if (appController.timer != null) {
      appController.timer!.cancel();
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    print("DEACTIVATE");
  }

  @override
  Widget build(BuildContext context) {
    final size = 50.0 - 5.0 * _breathe;
    return GetBuilder(
        init: controller,
        builder: (_) {
          return Stack(
            children: [
              // Background color
              BackColor(),

              // scrolll --------
              SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: resHeight(context) * 0.14.h,
                        ),

                        // circle progress for step count
                        Container(
                          height: 220.w,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.transparent,
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(100.r),
                                    color: Colors.transparent,
                                  ),
                                  // width: 326.w,
                                  // height: 80
                                  // alignment: Alignment.center,
                                  // padding: EdgeInsets.only(
                                  //     top: resHeight(context) *
                                  //             0.055 +
                                  //         2.5,
                                  //     right:
                                  //         resWidth(context) * 0.06),
                                  child: Obx(
                                    () => CircularPercentIndicator(
                                      radius: 102.0.w,
                                      lineWidth: 15.0.w,
                                      arcType: ArcType.FULL,
                                      arcBackgroundColor:
                                          HexColor("C8C8C8").withOpacity(0.3),
                                      linearGradient: LinearGradient(
                                        colors: [
                                          HexColor("627AF7"),
                                          HexColor("EF566A"),
                                          HexColor("627AF7"),
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                      animation: true,
                                      animationDuration: 1200,
                                      animateFromLastPercent: true,
                                      percent: Platform.isAndroid
                                          ? appController.dailyGoal.value ==
                                                      0 ||
                                                  appController
                                                          .stepCount.value >
                                                      appController
                                                          .dailyGoal.value
                                              ? 1.0
                                              : appController.stepCount.value /
                                                  appController.dailyGoal.value
                                          : appController.dailyGoal.value ==
                                                      0 ||
                                                  (appController.healthStep
                                                              .value -
                                                          appController
                                                              .addedStepData) >
                                                      appController
                                                          .dailyGoal.value
                                              ? 1.0
                                              : (appController
                                                          .healthStep.value -
                                                      appController
                                                          .addedStepData) /
                                                  appController.dailyGoal.value,
                                      // percent: 0.8,

                                      circularStrokeCap:
                                          CircularStrokeCap.round,

                                      center: // Count the steps
                                          Container(
                                        alignment: Alignment.center,
                                        child:
                                            // Obx(
                                            //   () {
                                            // if (appController
                                            //     .hasStepPermission.value) {
                                            Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Text(
                                                'gop_onoodor'.tr,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.w),
                                              ),
                                            ),
                                            SizedBox(height: 10.w),
                                            appController.stepLoading.value
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator())
                                                : Text(
                                                    NumberFormat().format(Platform
                                                            .isAndroid
                                                        ? appController
                                                            .stepCount.value
                                                        : appController
                                                                .healthStep
                                                                .value -
                                                            appController
                                                                .addedStepData),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 47.sp,
                                                    ),
                                                  ),
                                            SizedBox(
                                              height: 6.w,
                                            ),
                                            Container(
                                              child: Text(
                                                'gop_alhsan_baina'.tr,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.w),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // }
                                        // return Padding(
                                        //   padding: EdgeInsets.only(
                                        //       right: 20.w, left: 20.w),
                                        //   child: Column(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.center,
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.center,
                                        //     children: [
                                        //       Text(
                                        //         'gop_alhalt_tooloh_zowshoorol_tohiruulnuu'
                                        //             .tr,
                                        //         textAlign:
                                        //             TextAlign.center,
                                        //         style: TextStyle(
                                        //             color: Colors.white,
                                        //             fontWeight:
                                        //                 FontWeight.w500),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // );
                                        //   },
                                        // ),
                                      ),
                                      // arcBackgroundColor: Colors.yellow,
                                      // arcType: ArcType.FULL,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                    child: Obx(
                                  () => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "${'goal'.tr}: ${NumberFormat().format(appController.dailyGoal.value)} ",
                                        style: TextStyle(
                                          color: mainWhite,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      // Text(
                                      //   "Health: ${appController.healthStep.value - appController.addedStepData} ",
                                      //   style: TextStyle(
                                      //     color: mainWhite,
                                      //     fontSize: 16.sp,
                                      //     fontWeight: FontWeight.w700,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),

                        // Obx(
                        //   () => Text(appController.isDarkhan.value),
                        // ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                version != versionCode
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CheckVersion(),
                                          SizedBox(height: 22.h),
                                        ],
                                      )
                                    : SizedBox(
                                        height: 0,
                                      ),
                                // step history and goal buttons
                                Container(
                                  // padding:
                                  //     EdgeIns ets.symmetric(horizontal: 10.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Step history button
                                      InkWell(
                                        onTap: () {
                                          // Get.to(() => BirthdayPage());
                                          Get.to(() => StepHistory());
                                        },
                                        child: Container(
                                          width: (Get.width - 60.w) / 2,
                                          height: 45.h,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 18.w,
                                            vertical: 8.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Color(0x445C63).withOpacity(1),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color: Colors.black
                                            //         .withOpacity(0.5),
                                            //     spreadRadius: 1,
                                            //     blurRadius: 1,
                                            //     offset: Offset(0,
                                            //         1), // changes position of shadow
                                            //   ),
                                            // ],
                                            // gradient: LinearGradient(
                                            //   colors: [
                                            //     Color(0x0E1C26).withOpacity(1),
                                            //     Color(0x2A454B).withOpacity(1),
                                            //   ],
                                            //   begin: Alignment.topCenter,
                                            //   end: Alignment.bottomCenter,
                                            // ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12.r),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "pp_alhaltiin_tvvh".tr,
                                              style: TextStyle(
                                                color: mainWhite,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      InkWell(
                                        onTap: () {
                                          // setDailyGoalDialog(context);
                                          dialogGoal(context);
                                        },
                                        child: Container(
                                          width: (Get.width - 60.w) / 2,
                                          height: 45.h,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 18.w,
                                            vertical: 8.h,
                                          ),
                                          decoration: BoxDecoration(
                                              // color: Color(0xff1F9BD8),
                                              color: Color(0x445C63)
                                                  .withOpacity(1),
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //     color: Colors.black
                                              //         .withOpacity(0.5),
                                              //     spreadRadius: 1,
                                              //     blurRadius: 1,
                                              //     offset: Offset(0,
                                              //         1), // changes position of shadow
                                              //   ),
                                              // ],
                                              // gradient: LinearGradient(
                                              //   colors: [
                                              //     Color(0x0E1C26)
                                              //         .withOpacity(1),
                                              //     Color(0x2A454B)
                                              //         .withOpacity(1),
                                              //   ],
                                              //   begin: Alignment.topCenter,
                                              //   end: Alignment.bottomCenter,
                                              // ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.r))),
                                          child: Center(
                                            child: Text(
                                              "pp_odriin_alhalt_tohiruulah".tr,
                                              style: TextStyle(
                                                color: mainWhite,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                SizedBox(height: 30.h),

                                // Invite
                                InviteFriendHome(),
                                SizedBox(
                                  height: 30.h,
                                ),

                                BannerHome(),

                                // SizedBox(
                                //   height:
                                //       appController.smallBannerList.length > 0
                                //           ? 30.h
                                //           : 0.h,
                                // ),

                                // Container(
                                //   padding: EdgeInsets.all(20),
                                //   child: ListView.builder(
                                //     itemCount: itemLocks.length,
                                //     shrinkWrap: true,
                                //     itemBuilder: (context, index) {
                                //       return ListTile(
                                //         title: Text('Item ${index + 1}'),
                                //         leading: itemLocks[index]
                                //             ? Icon(Icons.lock)
                                //             : Icon(Icons
                                //                 .check_circle), // Display different icon for done items
                                //         onTap: () {
                                //           setState(() {
                                //             // Unlock the next item if it exists
                                //             if (index + 1 < itemLocks.length) {
                                //               itemLocks[index + 1] = false;
                                //             }
                                //           });
                                //         },
                                //         enabled: !itemLocks[
                                //             index], // Enable/disable based on lock status
                                //       );
                                //     },
                                //   ),
                                // ),

                                //Ads
                                showAd && appController.ads.obs != null
                                    ? AdsWidget()
                                    : const SizedBox(),

                                SizedBox(height: 30.h),
                              ],
                            )),

                        // slide big banner
                        controller.loading
                            ? Center(
                                child: SpinKitRipple(
                                  color: mainWhite,
                                  size: 50.0.r,
                                ),
                              )
                            : HomeSlideBanner(),

                        SizedBox(
                          height: 20.w,
                        ),

                        // // My challenges
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                        //   child: Builder(builder: (context) {
                        //     if (controller.myChallengeLoading) {
                        //       return Container(
                        //           height: 100,
                        //           child: Center(
                        //               child: SpinKitRipple(
                        //             color: mainWhite,
                        //             size: 50.0.r,
                        //           )));
                        //     }
                        //     if (controller.activeChallenge.isEmpty) {
                        //       return SizedBox(height: 20.w);
                        //     }
                        //     return Container(
                        //       height: 200,
                        //       width: double.infinity,
                        //       child: SingleChildScrollView(
                        //         scrollDirection: Axis.horizontal,
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: controller.activeChallenge.map((e) {
                        //             return ChallengeHomeBox(e: e);
                        //           }).toList(),
                        //         ),
                        //       ),
                        //     );
                        //   }),
                        // ),

                        SizedBox(
                          height: 42.w,
                        ),
                        // News
                        // News(),
                      ],
                    ),
                    // Text(
                    //   'version: ${appVersion}',
                    //   style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    // ),
                    // SizedBox(height: 20.h),
                  ],
                ),
              ),
              Column(
                children: [
                  ClipRRect(
                    child: BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).viewPadding.top),
                        margin: EdgeInsets.only(
                            left: 15.w, right: 15.w, bottom: 30.h),
                        child: ProAndNotiWidget(
                          scoreHead: ScoreForHeader(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Positioned(
              //   top: 80.h,
              //   left: 20.w,
              //   child: Image.asset(
              //     careBoot,
              //     width: size,
              //     height: size,
              //   ),
              // ),
              Positioned(
                top: 100.h,
                left: 80.w,
                child: takingPoint(),
              ),
            ],
          );
        });
  }

  Widget takingPoint() {
    return Text(
      "Hello World!",
      style: TextStyle(color: white),
    )
        .animate()
        .fadeIn() // uses `Animate.defaultDuration`
        .scale() // inherits duration from fadeIn
        .move(
            delay: 300.ms,
            duration: 600.ms) // runs after the above w/new duration
        .fadeOut();
  }
}
