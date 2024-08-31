import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/coupon/coupon_controller.dart';
import 'package:move_to_earn/core/models/model_button.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/gradient_button_old.dart';
import 'package:move_to_earn/ui/component/headers/score_header.dart';
import 'package:move_to_earn/ui/views/coupon/coupon_card.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';

class MyCouponPage extends StatefulWidget {
  const MyCouponPage({super.key});

  @override
  State<MyCouponPage> createState() => _MyCouponPageState();
}

class _MyCouponPageState extends State<MyCouponPage>
    with SingleTickerProviderStateMixin {
  CouponPageCtrl controller = Get.put(CouponPageCtrl());
  late TabController tabBarController;
  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 2, vsync: this);
    controller.getCoupon();
    controller.getInactiveCoupon();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponPageCtrl>(
        init: controller,
        builder: (logic) {
          return Scaffold(
            body: Stack(
              children: [
                BackColor(),
                controller.loading
                    ? Center(
                        child: SpinKitRipple(
                          color: mainWhite,
                          size: 50.0.r,
                        ),
                      )
                    : Column(
                        children: [
                          ScoreHeader(),
                          Container(
                            child: TabBar(
                              controller: tabBarController,
                              indicatorColor: Colors.white,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorWeight: 4,
                              tabs: [
                                Tab(
                                  child: Text(
                                    'cp_idevhtei'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'mcp_ashiglasan'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                                controller: tabBarController,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(right: 20, left: 20),
                                    child: controller.myCouponList.isEmpty
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 24),
                                                child: Text(
                                                  "cp_odoogoor_cupon_bhgv_bn"
                                                      .tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: mainWhite,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              LoginSignUpButton(
                                                model: ButtonModel(
                                                  icon: "",
                                                  color1: ColorConstants
                                                      .gradientColor1,
                                                  color2: ColorConstants
                                                      .gradientColor2,
                                                  color3: ColorConstants
                                                      .gradientColor3,
                                                  color4: ColorConstants
                                                      .gradientColor4,
                                                  color5: ColorConstants
                                                      .gradientColor5,
                                                  borderColor:
                                                      Colors.transparent,
                                                  text: "cp_coupon_harah".tr,
                                                  textStyle: TTextTheme
                                                      .lightTextTheme.bodySmall,
                                                  getTo: () => Get.offAllNamed(
                                                      '/main-page',
                                                      arguments:
                                                          'isCouponTransfer'),
                                                ),
                                              )
                                            ],
                                          )
                                        : SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(height: 18),
                                                Column(
                                                  children: controller
                                                      .myCouponList
                                                      .map((e) {
                                                    return CouponCard(
                                                        coupon: e);
                                                  }).toList(),
                                                ),
                                                const SizedBox(height: 140)
                                              ],
                                            ),
                                          ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(right: 20, left: 20),
                                    child: controller.inactive.isEmpty
                                        ? Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 24),
                                                  child: Text(
                                                    "mcp_counpon_none".tr,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: mainWhite,
                                                        fontSize: 16),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(height: 18),
                                                Column(
                                                  children: controller.inactive
                                                      .map((e) {
                                                    return CouponCard(
                                                        coupon: e);
                                                  }).toList(),
                                                ),
                                                const SizedBox(height: 140)
                                              ],
                                            ),
                                          ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
              ],
            ),
          );
        });
  }
}
