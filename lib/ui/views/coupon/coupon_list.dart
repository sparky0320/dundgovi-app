// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:move_to_earn/core/constants/image_strings.dart';
import 'package:move_to_earn/core/constants/textstyle.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/coupon/coupon_controller.dart';
import 'package:move_to_earn/core/controllers/loading_circle.dart';
import 'package:move_to_earn/core/models/coupon/coupon_model.dart';
import 'package:move_to_earn/ui/views/coupon/coupon_detail.dart';
import 'package:move_to_earn/ui/views/coupon/coupon_special.dart';
import 'package:move_to_earn/ui/views/coupon/shape.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CouponListAll extends StatefulWidget {
  String type;
  CouponListAll({Key? key, required this.type}) : super(key: key);
  @override
  State<CouponListAll> createState() => _CouponListAllState(type);
}

class _CouponListAllState extends State<CouponListAll> {
  _CouponListAllState(this.type);
  String type;
  late List<String> value = [];
  CouponPageCtrl controller = Get.put(CouponPageCtrl());
  late bool isLoading = true;
  bool? isHavePin;
  bool isImageCached = false;
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  String? log;
  List? details;

  final orientation = 200;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(_scrollListener);
    // _onRefresh();

    if (controller.allCouponList.isNotEmpty) {
      getCoupon(3);
    } else {
      getCoupon(2);
    }
    if (controller.allCouponList != null) {
      controller.allCouponList.map((e) {
        setState(() {
          details = e as List?;
        });
      });
    }
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      if (controller.page < controller.lastPage) {
        controller.page = controller.page + 1;
        await getCoupon(1);
        setState(() {
          isLoadingMore = false;
        });
      } else {
        setState(() {
          isLoadingMore = false;
        });
      }
    }
  }

  Future<bool> getCoupon(type) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // setState(() async {
      isLoading = await controller.getAllCouponList(controller.page, type);
      // });
    });

    return isLoading;
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    setState(() {
      controller.allCouponList.clear();
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      controller.page = 1;
    });
    getCoupon(2);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    if (type == 3) return getChallengeList();

    return (isLoading)
        ? Center(
            child: LoadingCircle(),
          )
        : getChallengeList();
  }

  Widget getChallengeList() {
    if (controller.allCouponList.isEmpty) {
      return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: const MaterialClassicHeader(
          color: greenColor,
        ),
        onRefresh: _onRefresh,
        child: Center(
            child: Text(
          "cp_odoogoor_medeelel_bhgv_bn".tr,
          textAlign: TextAlign.center,
          style: goSecondTextStyle.copyWith(fontSize: 17, color: white),
        )),
      );
    } else {
      // controller.allCouponList
      //     .sort((a, b) => b.isPinned!.compareTo(a.isPinned as num));
      List<CouponModel> unpinnedCoupons = controller.allCouponList
          .where((coupon) => coupon.isPinned == 0)
          .toList();
      List<CouponModel> pinnedCoupons = controller.allCouponList
          .where((coupon) => coupon.isPinned == 1)
          .toList();
      return SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          header: const MaterialClassicHeader(
            color: greenColor,
          ),
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // specialCoupon(),
                pinnedCoupons.length != 0 && pinnedCoupons != null
                    ? Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => SpecialCoupon());
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 156.h,
                              decoration: BoxDecoration(
                                // color: yellow,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    '$specialCouponImage',
                                    maxWidth:
                                        (MediaQuery.of(context).size.width *
                                                MediaQuery.of(context)
                                                    .devicePixelRatio)
                                            .round(),
                                  ),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.low,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      )
                    : SizedBox(height: 0),
                ListView.builder(
                  itemCount: isLoadingMore
                      ? unpinnedCoupons.length + 1
                      : unpinnedCoupons.length,
                  controller: scrollController,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, index) {
                    if (index < unpinnedCoupons.length) {
                      return SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child:
                                // controller.allCouponList[index].isPinned != 1
                                //     ?
                                Row(
                              children: [
                                Container(
                                  height: 120.h,
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                  decoration: ShapeDecoration(
                                    shape: SwTicketBorder(
                                      radius: 10,
                                      fillColor: Colors.grey,
                                      // borderColor: Colors.yellow,
                                      // borderWidth: 4,
                                      bottomLeft: false,
                                      bottomRight: true,
                                      topLeft: false,
                                      topRight: true,
                                    ),
                                  ),
                                  child: getCouponLeft(index),
                                ),
                                Container(
                                  height: 120.h,
                                  width:
                                      MediaQuery.of(context).size.width / 1.65,
                                  decoration: ShapeDecoration(
                                    shape: SwTicketBorder(
                                      radius: 10,
                                      fillColor: Colors.white,
                                      // borderColor: Colors.yellow,
                                      // borderWidth: 4,
                                      bottomLeft: true,
                                      bottomRight: false,

                                      topLeft: true,
                                      topRight: false,
                                    ),
                                  ),
                                  child: getCouponRight(index),
                                ),
                              ],
                            )
                            // : Text(
                            //     'data',
                            //     style: TextStyle(color: white),
                            //   ),
                            ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ));
    }
  }

  Widget specialCoupon() {
    return InkWell(
      onTap: () {
        Get.to(() => SpecialCoupon());
      },
      child: Container(
        height: 156.h,
        decoration: BoxDecoration(
          color: yellow,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.only(right: 15),
              height: 30.h,
              decoration: BoxDecoration(
                color: black.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.arrow_back,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getCouponLeft(index) {
    var saleCalcul = controller.allCouponList[index].sale;
    var sale = "${controller.allCouponList[index].sale}%";
    List<Color> gradColor;
    if (saleCalcul! >= 0 && saleCalcul < 31) {
      gradColor = [
        Color(0x7EAEFF).withOpacity(1),
        Color(0xFCA6E9).withOpacity(1),
      ];
    } else if (saleCalcul >= 31 && saleCalcul < 51) {
      gradColor = [
        Color(0x6E6CD8).withOpacity(1),
        Color(0x40A0EF).withOpacity(1),
        Color(0x77E1EE).withOpacity(1)
      ];
    } else if (saleCalcul >= 51 && saleCalcul < 100) {
      gradColor = [
        Color(0x000074).withOpacity(1),
        Color(0x6211D2).withOpacity(1),
      ];
    } else {
      gradColor = [
        Color.fromARGB(0, 0, 133, 66).withOpacity(1),
        Color.fromARGB(0, 170, 247, 195).withOpacity(1),
      ];
    }
    return Container(
      decoration: ShapeDecoration(
        shape: SwTicketBorder(
          radius: 10,
          bottomLeft: false,
          bottomRight: true,
          topLeft: false,
          topRight: true,
        ),
        gradient: LinearGradient(
          colors: gradColor,
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            sale.toString(),
            style: TextStyle(
                color: white, fontSize: 16, fontWeight: FontWeight.w800),
          ),
          Text(
            'Хөнгөлөлт',
            style: TextStyle(
                color: white, fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }

  Widget getCouponRight(index) {
    String logo = "$baseUrl${controller.allCouponList[index].logo}";
    String title = "${controller.allCouponList[index].title}";
    var une = controller.allCouponList[index].price.toString();
    double une2 = double.parse(une);
    var limit = controller.allCouponList[index].limit;

    int convert = une2.toInt();
    var count = controller.allCouponList[index].count;
    var endDate =
        controller.allCouponList[index].date.toString().substring(0, 10);
    var uldegdel = limit! - count!;
    var saleCalcul = controller.allCouponList[index].sale;
    List<Color> gradColor;
    if (saleCalcul! >= 0 && saleCalcul < 31) {
      gradColor = [
        Color(0x7EAEFF).withOpacity(1),
        Color(0xFCA6E9).withOpacity(1),
      ];
    } else if (saleCalcul >= 31 && saleCalcul < 51) {
      gradColor = [
        Color(0x6E6CD8).withOpacity(1),
        Color(0x40A0EF).withOpacity(1),
        Color(0x77E1EE).withOpacity(1)
      ];
    } else if (saleCalcul >= 51 && saleCalcul < 100) {
      gradColor = [
        Color(0x000074).withOpacity(1),
        Color(0x6211D2).withOpacity(1),
      ];
    } else {
      gradColor = [
        Color.fromARGB(0, 0, 133, 66).withOpacity(1),
        Color.fromARGB(0, 65, 243, 122).withOpacity(1),
      ];
    }
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 10),
      child: InkWell(
        onTap: () {
          Get.to(() => CouponDetail(data: controller.allCouponList[index]))!
              .then((value) => _onRefresh());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        logo,
                        maxWidth: (MediaQuery.of(context).size.width *
                                MediaQuery.of(context).devicePixelRatio)
                            .round(),
                      ),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    title,
                    maxLines: 2,
                    style: TextStyle(
                        color: black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(
              'Хугацаа: ${endDate}',
              style: TextStyle(
                  color: Color(0x787878).withOpacity(1),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Үлдэгдэл: ' + uldegdel.toString(),
                  style: TextStyle(
                      color: Color(0x787878).withOpacity(1),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                uldegdel == 0 || uldegdel < 0
                    ? Container(
                        width: 65.w,
                        height: 22.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: <Color>[
                              Color(0x6E6CD8).withOpacity(1),
                              Color(0x40A0EF).withOpacity(1),
                              Color(0x77E1EE).withOpacity(1)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: Text(
                          'Дууссан',
                          style: TextStyle(
                              color: white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        )),
                      )
                    : Container(
                        width: 85.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: gradColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                newcoin,
                                height: 13,
                                width: 13,
                              ),
                              SizedBox(width: 2),
                              Text(
                                NumberFormat().format(convert),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
