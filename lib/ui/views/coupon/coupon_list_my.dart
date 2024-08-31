// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:move_to_earn/core/constants/textstyle.dart';
import 'package:move_to_earn/core/constants/util.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/coupon/coupon_controller.dart';
import 'package:move_to_earn/core/controllers/loading_circle.dart';
import 'package:move_to_earn/ui/views/coupon/coupon_detail.dart';
import 'package:move_to_earn/ui/views/coupon/shape.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CouponListMy extends StatefulWidget {
  String type;
  CouponListMy({Key? key, required this.type}) : super(key: key);
  @override
  State<CouponListMy> createState() => _CouponListMyState(type);
}

class _CouponListMyState extends State<CouponListMy> {
  _CouponListMyState(this.type);
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
    getCoupon();

    if (controller.myCouponList != null) {
      controller.myCouponList.map((e) {
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
        await getCoupon();
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

  Future<bool> getCoupon() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() async {
        isLoading = await controller.getMyCouponList(controller.page);
      });
    });

    return isLoading;
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    setState(() {
      controller.myCouponList.clear();
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      controller.page = 1;
    });
    getCoupon();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    if (type == 2) return getChallengeList();
    return (isLoading)
        ? Center(
            child: LoadingCircle(),
          )
        : getChallengeList();
  }

  Widget getChallengeList() {
    if (controller.myCouponList.isEmpty) {
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
            ),
          ));
    } else {
      return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: const MaterialClassicHeader(
          color: greenColor,
        ),
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemCount: isLoadingMore
              ? controller.myCouponList.length + 1
              : controller.myCouponList.length,
          controller: scrollController,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            if (index < controller.myCouponList.length) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Container(
                      height: 191.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: ShapeDecoration(
                        shape: SwTicketBorder(
                          radius: 16,
                          fillColor: Colors.grey,
                          // borderColor: Colors.yellow,
                          // borderWidth: 4,
                          bottomLeft: true,
                          bottomRight: true,
                          topLeft: false,
                          topRight: false,
                        ),
                      ),
                      // child: Text('sss'),
                      child: getCouponTop(index),
                    ),
                    Container(
                      height: 180.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: ShapeDecoration(
                        shape: SwTicketBorder(
                          radius: 16,
                          fillColor: Colors.white,
                          bottomLeft: false,
                          bottomRight: false,
                          topLeft: true,
                          topRight: true,
                        ),
                      ),
                      child: getCouponBottom(index),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    }
  }

  Widget getCouponTop(index) {
    String logo = "$baseUrl${controller.myCouponList[index].logo}";
    return Container(
        decoration: ShapeDecoration(
      shape: SwTicketBorder(
        radius: 16,
        bottomLeft: true,
        bottomRight: true,
        topLeft: false,
        topRight: false,
      ),
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
    ));
  }

  Widget getCouponBottom(index) {
    var title = controller.myCouponList[index].title;
    var date = controller.myCouponList[index].endDate;
    var merchant = controller.myCouponList[index].merchantName;
    var status = controller.myCouponList[index].usageStatus;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 0.5.sw - 60.w,
                        child: Text(
                            'cp_hvchintei_hugatsaa'.tr + ' ' + date.toString(),
                            style: goTextStyle.copyWith(
                                fontSize: 12,
                                color: grey,
                                fontWeight: FontWeight.w700)),
                      ),
                      if (status.toString() == '0')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Util.fromHex("#EECB73"),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Text("cp_ashiglaagvi".tr,
                                  style: goTextStyle.copyWith(
                                      fontSize: 12, color: goTitleColor)),
                            ),
                          ],
                        ),
                      if (status.toString() == '4')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Util.fromHex("#EECB73"),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Text(
                                "Хүсэлт илгээсэн",
                                style: goTextStyle.copyWith(
                                    fontSize: 12, color: goTitleColor),
                              ),
                            ),
                          ],
                        ),
                      if (status.toString() == '1')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Text(
                                "mcp_ashiglasan".tr,
                                style: goTextStyle.copyWith(
                                    fontSize: 12, color: goTitleColor),
                              ),
                            ),
                          ],
                        ),
                      if (status.toString() == '2')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Util.fromHex("#EECB73"),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Text(
                                "cp_hvseltiig_zowshooroogvi".tr,
                                style: goTextStyle.copyWith(
                                    fontSize: 12, color: goTitleColor),
                              ),
                            ),
                          ],
                        ),
                      if (status.toString() == '3')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Text(
                                "cp_couponiig_tsutsalsan".tr,
                                style: goTextStyle.copyWith(
                                    fontSize: 12, color: goTitleColor),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    title.toString(),
                    style: goSecondTextStyle.copyWith(
                        fontSize: 19.sp,
                        color: black,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  Text(merchant.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: goSecondTextStyle.copyWith(
                          fontSize: 12.sp,
                          color: grey,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
              Positioned(
                bottom: 15,
                width: MediaQuery.of(context).size.width - 40 - 40,
                child: Center(
                  child: InkWell(
                    onTap: (() {
                      Get.to(() => CouponDetail(
                              data: controller.myCouponList[index]))!
                          .then((value) => _onRefresh());
                    }),
                    child: Container(
                      width: 270.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Color(0xEF566A).withOpacity(1),
                            Color(0x627AF7).withOpacity(1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Дэлгэрэнгүй',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
