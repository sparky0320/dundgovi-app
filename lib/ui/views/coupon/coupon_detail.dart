// ignore_for_file: unused_field, deprecated_member_use

import 'package:action_slider/action_slider.dart';
import 'package:app_settings/app_settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/image_strings.dart';
import 'package:move_to_earn/core/constants/sizes.dart';
import 'package:move_to_earn/core/constants/util.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/coupon/coupon_controller.dart';
import 'package:move_to_earn/core/models/coupon/coupon_model.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/headers/score_for_header.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../component/buttons/back_arrow.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class CouponDetail extends StatefulWidget {
  final CouponModel data;

  const CouponDetail({super.key, required this.data});

  @override
  State<CouponDetail> createState() => _CouponDetailState();
}

class _CouponDetailState extends State<CouponDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  CouponPageCtrl controller = Get.find();

  ActionSliderController? _controller;
  int isDelgerengui = 1;
  List<Color> selectedColor1 = [
    Color(0x0E1C26).withOpacity(1),
    Color(0x2A454B).withOpacity(1),
    Color(0x294861).withOpacity(1),
  ];
  List<Color> selectedColor2 = [
    Colors.transparent,
    Colors.transparent,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getUserCoupon(widget.data);
    });
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      _updatePositionList(
        _PositionItemType.log,
        _kLocationServicesDisabledMessage,
      );

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    permission = await _geolocatorPlatform.requestPermission();
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        permission = await _geolocatorPlatform.checkPermission();
        permission = await _geolocatorPlatform.requestPermission();
        permission = await Geolocator.checkPermission();
        permission = await Geolocator.requestPermission();
        _updatePositionList(
          _PositionItemType.log,
          _kPermissionDeniedMessage,
        );

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      permission = await _geolocatorPlatform.checkPermission();
      permission = await _geolocatorPlatform.requestPermission();
      permission = await Geolocator.checkPermission();
      permission = await Geolocator.requestPermission();
      _updatePositionList(
        _PositionItemType.log,
        _kPermissionDeniedForeverMessage,
      );

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _updatePositionList(
      _PositionItemType.log,
      _kPermissionGrantedMessage,
    );
    return true;
  }

  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final List<_PositionItem> _positionItems = <_PositionItem>[];

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  void _updatePositionList(_PositionItemType type, String displayValue) {
    _positionItems.add(_PositionItem(type, displayValue));
    setState(() {});
  }

  showWarning(BuildContext context) async {
    // await Future.delayed(Duration(milliseconds: 50));
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "Байршилийн тохиргоог зөвшөөрнө үү.",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 38,
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 20,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "pp_no".tr,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [Color(0xffEF566A), Color(0xff627AF7)],

                          // begin: Alignment.topLeft
                        ),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {
                          AppSettings.openAppSettings(
                              type: AppSettingsType.location);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Ok",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  void changeTabto2() {
    setState(() {
      isDelgerengui = 2;
      selectedColor2 = [
        Color(0x0E1C26).withOpacity(1),
        Color(0x2A454B).withOpacity(1),
        Color(0x294861).withOpacity(1),
      ];
      selectedColor1 = [
        Colors.transparent,
        Colors.transparent,
      ];
    });
    print(isDelgerengui);
  }

  void changeTabto1() {
    setState(() {
      isDelgerengui = 1;
      selectedColor1 = [
        Color(0x0E1C26).withOpacity(1),
        Color(0x2A454B).withOpacity(1),
        Color(0x294861).withOpacity(1),
      ];
      selectedColor2 = [
        Colors.transparent,
        Colors.transparent,
      ];
    });
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var une = widget.data.price.toString();
    double une2 = double.parse(une);
    int convert = une2.toInt();
    var address = widget.data.address;
    int uldegdel = widget.data.limit! - widget.data.count!;

    print(address);
    return GetBuilder(
        init: controller,
        builder: (_) {
          return Scaffold(
            body: Stack(
              children: [
                BackColor(),
                Column(
                  children: [
                    ClipRRect(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).viewPadding.top),
                        margin: EdgeInsets.only(
                            left: 10.w, right: 10.w, top: 10, bottom: 7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                BackArrow(),
                                Center(
                                  child: Text(
                                    'Купон',
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Nunito Sans',
                                        letterSpacing: -0.5),
                                  ),
                                ),
                                Spacer(),
                                ScoreForHeader(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: controller.loading
                          ? Center(
                              child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 8),
                                Text("cp_tvr_hvleene_vv".tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: mainWhite))
                              ],
                            ))
                          : SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      widget.data.image != null
                                          ? Container(
                                              foregroundDecoration:
                                                  RotatedCornerDecoration
                                                      .withGradient(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                    Colors.blue,
                                                    Colors.lightGreenAccent
                                                  ],
                                                ),
                                                badgePosition:
                                                    BadgePosition.bottomEnd,
                                                badgeSize: Size(74, 74),
                                                badgeShadow: BadgeShadow(
                                                  color: Colors.black,
                                                  elevation: 3,
                                                ),
                                                spanBaselineShift: 3,
                                                textSpan: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "${widget.data.sale}%",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: baseUrl +
                                                    widget.data.image!,
                                                memCacheWidth: (MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width *
                                                        MediaQuery.of(context)
                                                            .devicePixelRatio)
                                                    .round(),
                                                filterQuality:
                                                    FilterQuality.low,
                                                // height: resHeight(context) * .3,
                                                height: 209,
                                                width: double.infinity,
                                                fit: BoxFit.fitHeight,
                                                // assets/images/avatar.png
                                                errorWidget: (context, ss, ff) {
                                                  return Container(
                                                    height:
                                                        resHeight(context) * .3,
                                                    width: double.infinity,
                                                    color: Colors.black26,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(14),
                                                    child: Text(
                                                      "cp_unable_load_image".tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 10.sp,
                                                          color:
                                                              Colors.white54),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : Container(
                                              foregroundDecoration:
                                                  RotatedCornerDecoration
                                                      .withGradient(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                    Colors.blue,
                                                    Colors.lightGreenAccent
                                                  ],
                                                ),
                                                badgePosition:
                                                    BadgePosition.bottomEnd,
                                                badgeSize: Size(74, 74),
                                                badgeShadow: BadgeShadow(
                                                    color: Colors.black,
                                                    elevation: 42),
                                                spanBaselineShift: 3,
                                                textSpan: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "${widget.data.sale}%",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              child: Container(
                                                height: resHeight(context) * .3,
                                                width: double.infinity,
                                                color: Colors.black26,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(14),
                                                child: Text(
                                                  "cp_image_not_found".tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Colors.white54),
                                                ),
                                              ),
                                            ),
                                      SizedBox(height: 10),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 12),
                                              child: Text(
                                                  widget.data.title.toString(),
                                                  style: TTextTheme
                                                      .darkTextTheme
                                                      .displayMedium),
                                            ),
                                            if (widget.data.item != null)
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: 8.h),
                                                    widget.data.item[
                                                                'status'] ==
                                                            0
                                                        ? Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "cp_tolow"
                                                                          .tr,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              mainWhite,
                                                                          fontWeight:
                                                                              FontWeight.w700)),
                                                                  SizedBox(
                                                                      width:
                                                                          10.w),
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            4),
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            8,
                                                                        vertical:
                                                                            4),
                                                                    decoration: BoxDecoration(
                                                                        color: Util.fromHex(
                                                                            "#EECB73"),
                                                                        borderRadius:
                                                                            BorderRadius.circular(6)),
                                                                    child: Text(
                                                                        "cp_ashiglaagvi"
                                                                            .tr,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        : SizedBox(),
                                                    widget.data.item[
                                                                'status'] ==
                                                            4
                                                        ? Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "cp_tolow"
                                                                          .tr,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              mainWhite,
                                                                          fontWeight:
                                                                              FontWeight.w700)),
                                                                  SizedBox(
                                                                      width:
                                                                          10.w),
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            4),
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            8,
                                                                        vertical:
                                                                            4),
                                                                    decoration: BoxDecoration(
                                                                        color: Util.fromHex(
                                                                            "#EECB73"),
                                                                        borderRadius:
                                                                            BorderRadius.circular(6)),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          200, // Example width
                                                                      child:
                                                                          Text(
                                                                        "Ашиглах хүсэлт илгээсэн. Мерчант баталгаажуулалт хүлээгдэж байна",
                                                                        maxLines:
                                                                            3,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: 20.h),
                                                            ],
                                                          )
                                                        : SizedBox(),
                                                    widget.data.item[
                                                                'status'] ==
                                                            1
                                                        ? Column(
                                                            children: [
                                                              widget.data.item[
                                                                          'status'] ==
                                                                      1
                                                                  ? Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            "cp_tolow"
                                                                                .tr,
                                                                            style: TextStyle(
                                                                                fontSize: 16,
                                                                                color: mainWhite,
                                                                                fontWeight: FontWeight.w700)),
                                                                        SizedBox(
                                                                            width:
                                                                                10.w),
                                                                        Container(
                                                                          margin: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 4),
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 8,
                                                                              vertical: 4),
                                                                          decoration: BoxDecoration(
                                                                              color: Util.fromHex("#EECB73"),
                                                                              borderRadius: BorderRadius.circular(6)),
                                                                          child: Text(
                                                                              "mcp_ashiglasan".tr,
                                                                              style: TextStyle(fontSize: 12)),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : SizedBox(),
                                                              SizedBox(
                                                                  height: 24),
                                                            ],
                                                          )
                                                        : SizedBox(),
                                                    widget.data.item[
                                                                'status'] ==
                                                            2
                                                        ? Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "cp_tolow"
                                                                          .tr,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              mainWhite,
                                                                          fontWeight:
                                                                              FontWeight.w700)),
                                                                  SizedBox(
                                                                      width:
                                                                          10.w),
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            4),
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            8,
                                                                        vertical:
                                                                            4),
                                                                    decoration: BoxDecoration(
                                                                        color: Util.fromHex(
                                                                            "#EECB73"),
                                                                        borderRadius:
                                                                            BorderRadius.circular(6)),
                                                                    child: Text(
                                                                        "cp_hvseltiig_zowshooroogvi"
                                                                            .tr,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        : SizedBox(),
                                                    widget.data.item[
                                                                'status'] ==
                                                            3
                                                        ? Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "cp_tolow"
                                                                          .tr,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              mainWhite,
                                                                          fontWeight:
                                                                              FontWeight.w700)),
                                                                  SizedBox(
                                                                      width:
                                                                          10.w),
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            4),
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            8,
                                                                        vertical:
                                                                            4),
                                                                    decoration: BoxDecoration(
                                                                        color: Util.fromHex(
                                                                            "#EECB73"),
                                                                        borderRadius:
                                                                            BorderRadius.circular(6)),
                                                                    child: Text(
                                                                        "cp_couponiig_tsutsalsan"
                                                                            .tr,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        : SizedBox()
                                                  ],
                                                ),
                                              ),

                                            // information for coupon
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 110),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    top: 15,
                                                    right: 10,
                                                    bottom: 15),
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 20),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                  color: Color(0xFFFFFF)
                                                      .withOpacity(0.2),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                      height: 53,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(12),
                                                        ),
                                                        color: Color(0xFFFFFF)
                                                            .withOpacity(0.4),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              changeTabto1();
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                              height: 43,
                                                              decoration: BoxDecoration(
                                                                  gradient: LinearGradient(
                                                                      begin: Alignment
                                                                          .topLeft,
                                                                      end: Alignment
                                                                          .bottomRight,
                                                                      colors:
                                                                          selectedColor1),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              12))),
                                                              child: Center(
                                                                child: Text(
                                                                  "Дэлгэрэнгүй",
                                                                  style: TextStyle(
                                                                      color:
                                                                          white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              changeTabto2();
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                              height: 43,
                                                              decoration: BoxDecoration(
                                                                  gradient: LinearGradient(
                                                                      begin: Alignment
                                                                          .topLeft,
                                                                      end: Alignment
                                                                          .bottomRight,
                                                                      colors:
                                                                          selectedColor2),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              12))),
                                                              child: Center(
                                                                child: Text(
                                                                  "Холбоо барих",
                                                                  style: TextStyle(
                                                                      color:
                                                                          white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    isDelgerengui == 1
                                                        ? Column(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            12),
                                                                  ),
                                                                  color: Color(
                                                                          0xFFFFFF)
                                                                      .withOpacity(
                                                                          0.4),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Html(
                                                                      data: widget
                                                                          .data
                                                                          .subTitle,
                                                                      style: {
                                                                        "body":
                                                                            Style(
                                                                          fontSize:
                                                                              FontSize(16.0),
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      children: List.generate(
                                                                          150 ~/ 2,
                                                                          (index) => Expanded(
                                                                                child: Container(
                                                                                  color: index % 2 == 0 ? Colors.white : Colors.transparent,
                                                                                  height: 2,
                                                                                ),
                                                                              )),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.date_range,
                                                                            color:
                                                                                white,
                                                                            size:
                                                                                24,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                'Купоны хүчинтэй хугацаа',
                                                                                style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w700),
                                                                              ),
                                                                              Text(
                                                                                "${DateFormat('yyyy/MM/dd').format(DateTime.parse(widget.data.createdAt.toString()))} - ${DateFormat('yyyy/MM/dd').format(DateTime.parse(widget.data.date.toString()))} ",
                                                                                // "${widget.data.createdAt.toString().substring(0, 10)}-${widget.data.date.toString().substring(0, 10)}",
                                                                                style: TextStyle(color: white, fontSize: 16),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ]),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.sell,
                                                                            color:
                                                                                white,
                                                                            size:
                                                                                24,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                'Купоны үлдэгдэл',
                                                                                style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w700),
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "${uldegdel}",
                                                                                    // "${widget.data.limit! - widget.data.count!}",
                                                                                    style: TextStyle(color: uldegdel > 20 ? black : redColor, fontSize: 16, fontWeight: FontWeight.w700),
                                                                                  ),
                                                                                  Text(
                                                                                    " ширхэг",
                                                                                    style: TextStyle(
                                                                                      color: white,
                                                                                      fontSize: 16,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ]),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            12),
                                                                  ),
                                                                  color: Color(
                                                                          0xFFFFFF)
                                                                      .withOpacity(
                                                                          0.4),
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10,
                                                                          top:
                                                                              5),
                                                                      child:
                                                                          Text(
                                                                        'Хэрэглэх заавар:',
                                                                        style: TextStyle(
                                                                            color:
                                                                                white,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            fontSize: 16),
                                                                      ),
                                                                    ),
                                                                    Html(
                                                                      data: widget
                                                                          .data
                                                                          .description,
                                                                      style: {
                                                                        "body":
                                                                            Style(
                                                                          fontSize:
                                                                              FontSize(16.0),
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : Column(
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10,
                                                                        top: 20,
                                                                        right:
                                                                            10,
                                                                        bottom:
                                                                            30),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            12),
                                                                  ),
                                                                  color: Color(
                                                                          0xFFFFFF)
                                                                      .withOpacity(
                                                                          0.4),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.location_pin,
                                                                            color:
                                                                                white,
                                                                            size:
                                                                                24,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  'Салбарын байршил',
                                                                                  style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w700),
                                                                                ),
                                                                                Text(
                                                                                  address.toString(),
                                                                                  style: TextStyle(color: white, fontSize: 16),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ]),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.phone,
                                                                            color:
                                                                                white,
                                                                            size:
                                                                                24,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                'Холбогдох дугаар',
                                                                                style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w700),
                                                                              ),
                                                                              Text(
                                                                                "${widget.data.contactNumber}",
                                                                                style: TextStyle(
                                                                                  color: white,
                                                                                  fontSize: 16,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ]),
                                                                    SizedBox(
                                                                      height:
                                                                          30,
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        UrlLauncher.launch(
                                                                            'tel:${widget.data.contactNumber}');
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        height:
                                                                            43,
                                                                        decoration: BoxDecoration(
                                                                            gradient: LinearGradient(
                                                                              begin: Alignment.topLeft,
                                                                              end: Alignment.bottomRight,
                                                                              colors: [
                                                                                ColorConstants.buttonGradient2,
                                                                                ColorConstants.buttonGradient1,
                                                                              ],
                                                                            ),
                                                                            borderRadius: BorderRadius.all(Radius.circular(12))),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.phone,
                                                                              color: white,
                                                                              size: 24,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Text(
                                                                              "Холбоо барих",
                                                                              style: TextStyle(color: white, fontWeight: FontWeight.w700, fontSize: 16),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          30,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        widget.data.instaLink == null ||
                                                                                widget.data.instaLink == 'null' ||
                                                                                widget.data.instaLink == ''
                                                                            ? SizedBox(width: 0)
                                                                            : InkWell(
                                                                                onTap: () async {
                                                                                  // _launchURL(Uri.https('${widget.data.instaLink}', ''));
                                                                                  launchURL("${widget.data.instaLink}");
                                                                                },
                                                                                child: Image.asset(
                                                                                  insta,
                                                                                  height: careIconSize.w,
                                                                                  width: careIconSize.w,
                                                                                ),
                                                                              ),
                                                                        widget.data.fbLink == null ||
                                                                                widget.data.fbLink == 'null' ||
                                                                                widget.data.fbLink == ''
                                                                            ? SizedBox(width: 0)
                                                                            : InkWell(
                                                                                onTap: () async {
                                                                                  launchURL("${widget.data.fbLink}");
                                                                                  // const url = '${widget.data.fbLink}';
                                                                                  // if (await canLaunch(url)) {
                                                                                  //   await launch(url, forceWebView: true, enableJavaScript: true);
                                                                                  // } else {
                                                                                  //   throw 'Could not launch $url';
                                                                                  // }
                                                                                },
                                                                                child: Image.asset(
                                                                                  fb,
                                                                                  height: careIconSize.w,
                                                                                  width: careIconSize.w,
                                                                                ),
                                                                              ),
                                                                        widget.data.webLink == null ||
                                                                                widget.data.webLink == 'null' ||
                                                                                widget.data.webLink == ''
                                                                            ? SizedBox(width: 0)
                                                                            : InkWell(
                                                                                onTap: () async {
                                                                                  launchURL("${widget.data.webLink}");
                                                                                },
                                                                                child: Image.asset(
                                                                                  browser,
                                                                                  height: careIconSize.w,
                                                                                  width: careIconSize.w,
                                                                                ),
                                                                              ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
                if (widget.data.item != null)
                  Positioned(
                      bottom: 0,
                      left: 0.0,
                      right: 0.0,
                      child: Column(
                        children: [
                          SizedBox(height: 8.h),
                          widget.data.item['status'] == 0
                              ? Container(
                                  padding: EdgeInsets.only(
                                      left: 30, right: 30, top: 15, bottom: 15),
                                  decoration: BoxDecoration(
                                      color: Color(0x0E1C26).withOpacity(1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      )),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.useCoupon(context,
                                              widget.data.item['coupon_id']);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                top: 15,
                                                bottom: 15),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    ColorConstants
                                                        .buttonGradient2,
                                                    ColorConstants
                                                        .buttonGradient1,
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Center(
                                                child: Text(
                                              'Ашиглах',
                                              style: TextStyle(
                                                  color: white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ))),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.cancelCoupon(context,
                                              widget.data.item['coupon_id']);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                top: 15,
                                                bottom: 15),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Center(
                                                child: Text(
                                              'Цуцлах',
                                              style: TextStyle(
                                                  color: white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ))),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                        ],
                      )),
                widget.data.item == null
                    ? widget.data.limit! - widget.data.count! != 0 ||
                            widget.data.limit! - widget.data.count! < 0
                        ? une.toInt() >= appController.point.value.toInt()
                            ? Positioned(
                                bottom: 0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20, top: 20),
                                  decoration: BoxDecoration(
                                      color: Color(0x0E1C26).withOpacity(1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      )),
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 15,
                                          bottom: 15),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              ColorConstants.buttonGradient2,
                                              ColorConstants.buttonGradient1,
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Center(
                                          child: Text(
                                        'Таны оноо хүрэхгүй байна.',
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ))),
                                ))
                            : Positioned(
                                bottom: 0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20, top: 20),
                                  decoration: BoxDecoration(
                                      color: Color(0x0E1C26).withOpacity(1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      )),
                                  child: ActionSlider.custom(
                                    controller: _controller,
                                    toggleWidth: 60.0,
                                    height: 60.0,
                                    backgroundColor:
                                        Color(0xffffff).withOpacity(0.5),
                                    foregroundChild: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.0)),
                                        ),
                                        child: const Icon(Icons.check_rounded,
                                            color: Colors.white)),
                                    foregroundBuilder: (BuildContext,
                                        ActionSliderState, Widget) {
                                      return Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Icon(
                                            Icons.keyboard_double_arrow_right),
                                      );
                                    },
                                    backgroundChild: Center(
                                      child: Text(
                                          '      ' +
                                              NumberFormat().format(convert) +
                                              ' care оноогоор авах',
                                          style: TextStyle(
                                              color: white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16)),
                                    ),
                                    backgroundBuilder:
                                        (context, state, child) => ClipRect(
                                            child: OverflowBox(
                                                maxWidth:
                                                    state.standardSize.width,
                                                maxHeight:
                                                    state.toggleSize.height,
                                                minWidth:
                                                    state.standardSize.width,
                                                minHeight:
                                                    state.toggleSize.height,
                                                child: child!)),
                                    backgroundBorderRadius:
                                        BorderRadius.circular(12.0),
                                    action: (actionController) async {
                                      if (widget.data.long != 0 &&
                                          widget.data.lat != 0 &&
                                          widget.data.distance != 0) {
                                        final hasPermission =
                                            await _handlePermission();

                                        if (!hasPermission) {
                                          showWarning(context);
                                        }
                                        Position position =
                                            await Geolocator.getCurrentPosition(
                                                desiredAccuracy:
                                                    LocationAccuracy.low);
                                        double distanceInMeters =
                                            Geolocator.distanceBetween(
                                                widget.data.lat!,
                                                widget.data.long!,
                                                position.latitude,
                                                position.longitude);
                                        if (distanceInMeters <=
                                            widget.data.distance!) {
                                          actionController.loading();
                                          await controller.addCoupon(
                                              context, widget.data);
                                          actionController.reset();
                                        } else {
                                          showModalBottomSheet<void>(
                                            backgroundColor: Color(0xffFFFFFF),
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (BuildContext context) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2.2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20,
                                                            bottom: 20,
                                                            right: 30,
                                                            left: 30),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  size: 17,
                                                                )),
                                                          ],
                                                        ),
                                                        Image.asset(
                                                            locationIcon),
                                                        RichText(
                                                          text: TextSpan(
                                                            text:
                                                                'alert_location'
                                                                    .tr,
                                                            style: TextStyle(
                                                                color: black),
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                  text: '  ',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              TextSpan(
                                                                  text: widget
                                                                      .data
                                                                      .locationDetail,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.0)),
                                                            gradient:
                                                                LinearGradient(
                                                                    colors: [
                                                                      const Color(
                                                                              0x627AF7)
                                                                          .withOpacity(
                                                                              1),
                                                                      const Color(
                                                                              0xEF566A)
                                                                          .withOpacity(
                                                                              1),
                                                                    ],
                                                                    begin:
                                                                        const FractionalOffset(
                                                                            0.0,
                                                                            0.0),
                                                                    end: const FractionalOffset(
                                                                        1.0, 0.0),
                                                                    stops: [
                                                                      0.0,
                                                                      1.0
                                                                    ],
                                                                    tileMode:
                                                                        TileMode
                                                                            .clamp),
                                                          ),
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Center(
                                                              child: Text(
                                                                "Ok",
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      mainWhite,
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        // Text(
                                                        //   'alert_location'.tr +
                                                        //       " " +
                                                        //       widget.data
                                                        //           .locationDetail
                                                        //           .toString(),
                                                        //   style: TextStyle(
                                                        //       fontWeight:
                                                        //           FontWeight
                                                        //               .w700),
                                                        // ),
                                                        // Text(widget
                                                        //     .data.locationDetail
                                                        //     .toString()),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                          // showDialog(
                                          //   context: context,
                                          //   builder: (BuildContext context) {
                                          //     return AlertDialog(
                                          //       title:
                                          //           Text('alert_location'.tr),
                                          //       actions: [
                                          //         Container(
                                          //           decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius.circular(
                                          //                     20),
                                          //             gradient: LinearGradient(
                                          //               colors: [
                                          //                 Color(0xffEF566A),
                                          //                 Color(0xff627AF7)
                                          //               ],

                                          //               // begin: Alignment.topLeft
                                          //             ),
                                          //           ),
                                          //           child: ElevatedButton(
                                          //             style: ButtonStyle(
                                          //               backgroundColor:
                                          //                   MaterialStateProperty
                                          //                       .all(Colors
                                          //                           .transparent),
                                          //               shadowColor:
                                          //                   MaterialStateProperty
                                          //                       .all(Colors
                                          //                           .transparent),
                                          //             ),
                                          //             onPressed: () {
                                          //               Navigator.pop(context);
                                          //             },
                                          //             child: Text(
                                          //               "Ok",
                                          //               style: TextStyle(
                                          //                   color:
                                          //                       Colors.white),
                                          //             ),
                                          //           ),
                                          //         )
                                          //       ],
                                          //     );
                                          //   },
                                          // );
                                        }
                                      } else {
                                        actionController.loading();
                                        await controller.addCoupon(
                                            context, widget.data);
                                        actionController.reset();
                                      }
                                    },
                                  ),
                                ))
                        : Positioned(
                            bottom: 0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20, top: 20),
                              decoration: BoxDecoration(
                                  color: Color(0x0E1C26).withOpacity(1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  )),
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      // gradient: LinearGradient(
                                      //   begin: Alignment.topLeft,
                                      //   end: Alignment.bottomRight,
                                      //   colors: [
                                      //     ColorConstants.buttonGradient2,
                                      //     ColorConstants.buttonGradient1,
                                      //   ],
                                      // ),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                      child: Text(
                                    'Зарагдаж дууссан байна.',
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ))),
                            ),
                          )
                    : const SizedBox(),
              ],
            ),
          );
        });
  }
}

enum _PositionItemType {
  log,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
