// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mdi/mdi.dart';
import 'package:move_to_earn/core/constants/image_strings.dart';
import 'package:move_to_earn/core/constants/textstyle.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/challenge_controller.dart';
import 'package:move_to_earn/core/controllers/loading_circle.dart';
import 'package:move_to_earn/ui/views/challenge/challenge_detail.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChallengeListMy extends StatefulWidget {
  String type;
  ChallengeListMy({Key? key, required this.type}) : super(key: key);
  @override
  State<ChallengeListMy> createState() => _ChallengeListMyState(type);
}

class _ChallengeListMyState extends State<ChallengeListMy> {
  _ChallengeListMyState(this.type);
  String type;
  late List<String> value = [];
  ChallengeController controller = Get.put(ChallengeController());
  late bool isLoading = true;
  bool? isHavePin;
  bool isImageCached = false;
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  String? log;
  List? details;
  // NetworkUtil _netUtil = NetworkUtil();

  @override
  void initState() {
    super.initState();
    getChallenge();
  }

  Future<bool> getChallenge() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // setState(() async {
      isLoading = await controller.getChallengesListMy(controller.page);
      // });
    });

    return isLoading;
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    setState(() {
      controller.myChallenges.clear();
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));
    getChallenge();
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
    if (controller.myChallenges.length == 0) {
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
            itemCount: controller.myChallenges.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (_, index) {
              return Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Card(
                      child: Container(
                    height: 300.h,
                    child: getAllChallenges(index),
                  )));
            },
          ));
    }
  }

  Widget getAllChallenges(index) {
    var title = controller.myChallenges[index].title;
    String imgurl = "$baseUrl${controller.myChallenges[index].logoImg}";
    var joined = controller.myChallenges[index].joined;
    var score = controller.myChallenges[index].score;
    var userCount = controller.myChallenges[index].userCount;
    var limit = controller.myChallenges[index].limit;
    var endDate = controller.myChallenges[index].endDate.toString();
    if (endDate != null) {
      endDate = endDate.substring(0, 16);
    }
    return GestureDetector(
        onTap: (() {
          Get.to(() => ChallengeDetail(data: controller.myChallenges[index]))!
              .then((value) => initState());
        }),
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 190.h,
                decoration: ShapeDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(11),
                        topLeft: Radius.circular(11),
                      ),
                    )),
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(11),
                              topRight: Radius.circular(11),
                            ),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: imgurl,
                                  memCacheWidth:
                                      (MediaQuery.of(context).size.width *
                                              MediaQuery.of(context)
                                                  .devicePixelRatio)
                                          .round(),
                                  filterQuality: FilterQuality.low,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: new BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 30.0,
                                      sigmaY: 30.0,
                                    ),
                                    child: new CachedNetworkImage(
                                      imageUrl: imgurl,
                                      memCacheWidth:
                                          (MediaQuery.of(context).size.width *
                                                  MediaQuery.of(context)
                                                      .devicePixelRatio)
                                              .round(),
                                      filterQuality: FilterQuality.low,
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                    ),
                                  ),
                                )
                              ],
                            ))),
                    Positioned(
                      right: 16.75,
                      top: 16.75,
                      child: Container(
                        padding: const EdgeInsets.all(5.58),
                        decoration: ShapeDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Дуусах хугацаа :\n$endDate',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w700,
                                height: 0,
                                letterSpacing: -0.50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              height: 110.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    title.toString(),
                    style: goSecondTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        letterSpacing: -0.2),
                  ),
                  Row(
                    children: [
                      joined != true
                          ? Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text(
                                    'Хураамж:',
                                    style: goSecondTextStyle.copyWith(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Nunito Sans',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.40,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        newcoin,
                                        height: 22.w,
                                        width: 22.w,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        NumberFormat().format(score),
                                        // score.toString() + ' care',
                                        style: new TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0x434343).withOpacity(1),
                                          // foreground: Paint()
                                          //   ..shader = LinearGradient(
                                          //     colors: <Color>[
                                          //       Color(0xFFEF566A),
                                          //       Color(0xFF627AF7)
                                          //     ],
                                          //   ).createShader(Rect.fromLTWH(
                                          //       50.0, 0.0, 180.0, 70.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]))
                          : Text(
                              'Та нэгдсэн байна',
                              style: TextStyle(
                                color: Colors.purple,
                                fontSize: 14,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w700,
                                height: 0,
                                letterSpacing: -0.10,
                              ),
                            ),
                      Spacer(),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  userCount.toString() + ' / ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Nunito Sans',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                      letterSpacing: 1),
                                ),
                                limit == 0 || limit == null
                                    ? Icon(
                                        Mdi.infinity,
                                        size: 13,
                                      )
                                    : Text(
                                        limit.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Nunito Sans',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                            letterSpacing: 1),
                                      ),
                              ],
                            ),
                            Text(
                              'Оролцогч',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1),
                            )
                          ]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
