import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lambda/utils/hexColor.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/image_strings.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/ads_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pedometer_db/pedometer_db.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mdi/mdi.dart';
import '../../core/constants/controllers.dart';
import '../../core/controllers/main_page_tcr_ctr.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  MainPageTCRCtrl ctrl = Get.put(MainPageTCRCtrl());
  AdsController adsCtrl = Get.put(AdsController());

  int? connect;
  bool? isDev;
  int _selectedIndex = 0;
  int totalSteps = 0;
  String? badgesName;
  String? badgesImage;
  int? badgesKilo;
  int? badgesId;

  @override
  initState() {
    super.initState();
    getInitData();
    adsCtrl.loadAd();
  }

  Future<void> getInitData() async {
    final _pedometerDB = PedometerDb();
    _pedometerDB.initialize();

    await getInit();
    await appController.getAds();
    await appController.getInitData(context);
    await checkBadge();
  }

  Future<void> getInit() async {
    checkPermission();
    // connection();
    isDevMode();
    appController.initPlatformState();
    await appController.saveLoginLog();

    ctrl.locationService();
    ctrl.checkDailyGoal(context);
    final dynamic isCouponTransfer = Get.arguments;

    if (isCouponTransfer != null && isCouponTransfer == 'isCouponTransfer') {
      ctrl.selectedIndex = 0;
    }
  }

  Future isDevMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDev = prefs.getBool('isDev');
    });
  }

  Future checkPermission() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> checkBadge() async {
    for (var item in appController.userStepLog) {
      totalSteps += item.stepCount ?? 0;
    }
    var selectedBadge;

    for (var badge in appController.badgesList) {
      if (badge.kilo! <= ((totalSteps * 76.2) / 100000)) {
        selectedBadge = badge;
        break;
      }
    }

    if (selectedBadge != null) {
      setState(() {
        badgesImage = selectedBadge!.image;
        badgesId = selectedBadge!.id;
        badgesName = selectedBadge!.name;
        badgesKilo = selectedBadge!.kilo;
      });
    }
    // for (var badge in appController.badgesList) {
    //   // if (badge.id == 2) {
    //   if (badge.kilo! >= ((totalSteps * 76.2) / 100000)) {
    //     setState(() {
    //       badgesImage = badge.image;
    //       badgesId = badge.id;
    //       badgesName = badge.name;
    //       badgesKilo = badge.kilo;
    //     });
    //     break;
    //   }
    // }
    await appController.getAchievementBadge(context,
        badgeId: badgesId,
        badgeName: badgesName,
        badgeImage: badgesImage,
        badgeKilo: badgesKilo);

    print("$badgesName, $badgesId <<>><<>><<>>><<<<>>>");
  }

  // Future connection() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   connect = prefs.getInt('Connection');
  //   if (connect == 0) {
  //     final snackBar = SnackBar(
  //       duration: const Duration(seconds: 60),
  //       elevation: 0,
  //       behavior: SnackBarBehavior.floating,
  //       backgroundColor: Colors.transparent,
  //       content: AwesomeSnackbarContent(
  //         title: 'No Connection !',
  //         message:
  //             'Та интернэт сүлжээгээ асаан алхалтаас бусад бүх боломжоо ашиглаарай ;)',
  //         contentType: ContentType.help,
  //       ),
  //     );

  //     ScaffoldMessenger.of(context)
  //       ..hideCurrentSnackBar()
  //       ..showSnackBar(snackBar);
  //   }
  //   // else {
  //   // if (version == versionCode) {
  //   //   print("Using Last Version...");
  //   // } else {
  //   //   Get.dialog(
  //   //       AlertDialog(
  //   //         title: Text("Шинэ хувилбар"),
  //   //         content: Text('Апп-аа шинэчлээд ураад өгөөрэй...'),
  //   //         actions: <Widget>[
  //   //           MaterialButton(
  //   //             child: Text(
  //   //               "Алгасах",
  //   //               style: TextStyle(color: Color(0xff565656)),
  //   //             ),
  //   //             onPressed: () {
  //   //               Navigator.of(context, rootNavigator: true).pop();
  //   //             },
  //   //           ),
  //   //           MaterialButton(
  //   //             child: Container(
  //   //               padding:
  //   //                   EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
  //   //               decoration: BoxDecoration(
  //   //                   color: Colors.black,
  //   //                   borderRadius: BorderRadius.circular(4)),
  //   //               child: Text(
  //   //                 "Шинэчлэх",
  //   //                 style: TextStyle(color: Colors.white),
  //   //               ),
  //   //             ),
  //   //             onPressed: () {
  //   //               this._launchWeb(applink);
  //   //             },
  //   //           ),
  //   //         ],
  //   //       ),
  //   //       barrierDismissible: false);
  //   // }
  //   // }
  // }

  // Future<void> _launchWeb(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPageTCRCtrl>(
      init: ctrl,
      builder: (logic) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: ctrl.pages.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: Container(
            // padding: EdgeInsets.all(15),
            child: _getBtmNavBar(),
            decoration: BoxDecoration(
              color: ColorConstants.backGradientColor3,
            ),
          ),
        );
      },
    );
  }

  Widget bottomNavigate() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0x0E1C26).withOpacity(1),
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(15.r),
        //   topRight: Radius.circular(15.r),
        // ),
        // boxShadow: [
        //   BoxShadow(
        //     blurRadius: 20,
        //     color: Colors.black.withOpacity(.1),
        //   )
        // ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3),
          child: GNav(
            // backgroundColor: black,
            // rippleColor: Colors.grey[300]!,
            // hoverColor: Colors.grey[100]!,
            gap: 3,
            tabMargin: EdgeInsets.only(top: 12, bottom: 12),

            tabBorderRadius: 20,
            curve: Curves.easeInCubic,
            // tabActiveBorder: Colors.black,
            // tabBorder: Border.all(
            //     color: Colors.grey, width: 1), // tab button border
            // tabShadow: [
            //   BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
            // ],
            activeColor: const Color.fromARGB(255, 255, 255, 255),
            tabActiveBorder: Border.all(width: 0.1, color: black),
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            duration: Duration(milliseconds: 300),
            tabBackgroundGradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0x32434C).withOpacity(0.4),
                Color(0x759CB2).withOpacity(1),
              ],
            ),
            color: Colors.grey[500],
            tabs: [
              GButton(
                padding: EdgeInsets.all(10),
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                padding: EdgeInsets.all(10),
                icon: LineIcons.alternate_ticket,
                text: 'Coupon',
              ),
              GButton(
                padding: EdgeInsets.all(10),
                icon: LineIcons.trophy,
                text: 'Challenge',
              ),
              if (miniappIsHidden == false)
                GButton(
                  padding: EdgeInsets.all(10),
                  icon: LineIcons.search_plus,
                  text: 'Mini App',
                ),
              GButton(
                padding: EdgeInsets.all(10),
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex.clamp(0, ctrl.pages.length - 1),
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  Obx _getBtmNavBar() {
    return Obx(() => Container(
        child: adsCtrl.isAdLoaded.value
            ? Container(
                height: 113.h,
                // height: kToolbarHeight.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                  ],
                ),
                child: Column(
                  children: [
                    Obx(
                      () => Container(
                        child: adsCtrl.isAdLoaded.value
                            ? ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 59,
                                  minHeight: 59,
                                ),
                                child: AdWidget(ad: adsCtrl.nativeAd!))
                            : const SizedBox(),
                      ),
                    ),
                    ClipRRect(
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(20.0),
                      //   topRight: Radius.circular(20.0),
                      // ),
                      // borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      child: BottomNavigationBar(
                        backgroundColor: ColorConstants.backGradientColor1,
                        selectedItemColor: isDev == true
                            ? Color.fromARGB(255, 252, 0, 0)
                            : Color.fromARGB(255, 255, 255, 255),
                        unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
                        currentIndex: _selectedIndex,
                        showUnselectedLabels: false,
                        showSelectedLabels: true,
                        type: BottomNavigationBarType.fixed,
                        onTap: (int index) {
                          setState(() {
                            this._selectedIndex = index;
                          });
                        },
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home_outlined),
                            activeIcon: Icon(Icons.home),
                            label: 'nav_home'.tr,
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Mdi.ticketOutline),
                            activeIcon: Icon(Mdi.ticket),
                            label: 'nav_coupon'.tr,
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Mdi.trophyOutline),
                            activeIcon: Icon(Mdi.trophy),
                            label: 'nav_challenge'.tr,
                          ),
                          if (pendingVersion != versionCode)
                            BottomNavigationBarItem(
                              icon: Icon(Mdi.alphaMCircleOutline),
                              label: 'nav_miniapp'.tr,
                            ),
                          BottomNavigationBarItem(
                            // icon: Icon(LineIcons.set),
                            icon: Icon(LineIcons.user),
                            activeIcon: Icon(
                              LineIcons.user_1,
                            ),
                            label: 'nav_profile'.tr,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                // height: 113.h,
                // height: kToolbarHeight.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                  ],
                ),
                child: ClipRRect(
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(20.0),
                  //   topRight: Radius.circular(20.0),
                  // ),
                  // borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  child: BottomNavigationBar(
                    backgroundColor: ColorConstants.backGradientColor1,
                    selectedItemColor: isDev == true
                        ? Color.fromARGB(255, 252, 0, 0)
                        : Color.fromARGB(255, 255, 255, 255),
                    unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
                    currentIndex: _selectedIndex,
                    showUnselectedLabels: false,
                    showSelectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    onTap: (int index) {
                      setState(() {
                        this._selectedIndex = index;
                      });
                    },
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined),
                        activeIcon: Icon(Icons.home),
                        label: 'nav_home'.tr,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Mdi.ticketOutline),
                        activeIcon: Icon(Mdi.ticket),
                        label: 'nav_coupon'.tr,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Mdi.trophyOutline),
                        activeIcon: Icon(Mdi.trophy),
                        label: 'nav_challenge'.tr,
                      ),
                      if (pendingVersion != versionCode)
                        BottomNavigationBarItem(
                          icon: Icon(Mdi.alphaMCircleOutline),
                          label: 'nav_miniapp'.tr,
                        ),
                      BottomNavigationBarItem(
                        // icon: Icon(LineIcons.set),
                        icon: Icon(LineIcons.user),
                        activeIcon: Icon(
                          LineIcons.user_1,
                        ),
                        label: 'nav_profile'.tr,
                      ),
                    ],
                  ),
                ),
              )));
  }

  Widget bottomAppBarWidget() {
    return Container(
      decoration: BoxDecoration(color: black),
      height: 70.h,
      // margin: EdgeInsets.only(
      //   left: 10.w,
      //   right: 10.w,
      //   // bottom: 5.h,
      // ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
        ),
        child: BottomNavigationBar(
          currentIndex: ctrl.selectedIndex,
          selectedItemColor: isDev == true ? redColor : mainWhite,
          unselectedItemColor:
              isDev == true ? redColor : HexColor("CBCBCB").withOpacity(0.8),
          unselectedFontSize: 12.sp,
          selectedFontSize: 12.sp,
          backgroundColor: HexColor("1E6C8E"),
          onTap: ctrl.updateTabSelection,
          items: [
            new BottomNavigationBarItem(
              label: "Coupon",
              icon: SvgPicture.asset(
                couponIcon,
                height: 15.w,
                color: HexColor("CBCBCB"),
              ),
              activeIcon: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(colors: [
                    ColorConstants.buttonGradient2,
                    ColorConstants.buttonGradient1,
                  ]).createShader(bounds);
                },
                child: SvgPicture.asset(
                  couponIcon,
                  height: 26.w,
                ),
              ),
            ),
            new BottomNavigationBarItem(
              label: "GoCare",
              icon: SvgPicture.asset(
                careIcon,
                height: 15.w,
                color: HexColor("CBCBCB"),
              ),
              activeIcon: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(colors: [
                    ColorConstants.buttonGradient2,
                    ColorConstants.buttonGradient1,
                  ]).createShader(bounds);
                },
                child: SvgPicture.asset(
                  careIcon,
                  height: 26.w,
                ),
              ),
            ),
            new BottomNavigationBarItem(
              label: "Challenge",
              icon: SvgPicture.asset(
                peopleIcon,
                height: 15.w,
                color: HexColor("CBCBCB"),
              ),
              activeIcon: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(colors: [
                    ColorConstants.buttonGradient2,
                    ColorConstants.buttonGradient1,
                  ]).createShader(bounds);
                },
                child: SvgPicture.asset(
                  peopleIcon,
                  height: 26.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
