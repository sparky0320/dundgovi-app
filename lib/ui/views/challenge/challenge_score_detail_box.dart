import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/challenge_controller.dart';
import 'package:move_to_earn/core/models/challenge/challenge_model.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';

class ChallengeScoreDetailBox extends StatefulWidget {
  final ChallengeModel challenge;
  const ChallengeScoreDetailBox({super.key, required this.challenge});

  @override
  State<ChallengeScoreDetailBox> createState() =>
      _ChallengeScoreDetailBoxState();
}

class _ChallengeScoreDetailBoxState extends State<ChallengeScoreDetailBox> {
  ChallengeController controller = Get.find();
  List<dynamic> scoreDetail = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  getData() async {
    controller.getChallengeScoreDetail(widget.challenge).then((value) {
      if (value != null && mounted) {
        setState(() {
          scoreDetail = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: controller.scoreLoading
            ? Center(
                child: SpinKitRipple(
                  color: mainWhite,
                  size: 50.0.r,
                ),
              )
            : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: scoreDetail.length,
                        itemBuilder: (context, index) {
                          final e = scoreDetail[index];
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  e['date'].toString(),
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: mainWhite),
                                                ),
                                              ),
                                              Text(
                                                'cp_alhalt_too'.tr,
                                                style: TTextTheme
                                                    .darkTextTheme.labelSmall,
                                              )
                                            ],
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            e['step_count'] != null
                                                ? "${NumberFormat().format(e['step_count'])}"
                                                : "",
                                            style: TextStyle(
                                              color: mainWhite,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.white,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    if (controller.invites.isNotEmpty)
                      Container(
                        padding: EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'cp_urisan'.tr,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: mainWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Container(
                      child: controller.invites.isNotEmpty
                          ? Expanded(
                              child: ListView(
                                children: controller.invites.map(
                                  (item) {
                                    // var index = controller.invites.indexOf(item);
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.start,
                                              //   crossAxisAlignment:
                                              //       CrossAxisAlignment.start,
                                              // children: [
                                              IntrinsicWidth(
                                                child: Text(
                                                  item.phone ?? 'N/A',
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: mainWhite,
                                                  ),
                                                ),
                                              ),
                                              // ],
                                              // ),
                                              IntrinsicWidth(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 4,
                                                      horizontal: 8),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Text(
                                                    item.createdAt != null
                                                        ? DateFormat.yMd()
                                                            .format(DateTime
                                                                .parse(item
                                                                    .createdAt!))
                                                        : "N/A",
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: mainWhite,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.white,
                                        )
                                      ],
                                    );
                                  },
                                ).toList(),
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ));
  }
}
