import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lambda/utils/hexColor.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/loading_circle.dart';
import '../../../core/controllers/invite_friend/invite_friend_controller.dart';
import '../../component/backrounds/backColor.dart';
import '../../component/buttons/back_arrow.dart';

import '../../component/headers/header_for_page.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({super.key});

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  InviteFriendCtrl ctrl = Get.put(InviteFriendCtrl());

  // @override
  // void initState() {
  //   super.initState();
  //   // ctrl.getInvite();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackColor(),
          Column(
            children: [
              HeaderForPage(
                backArrow: BackArrow(),
                text: "if_urisan_naiz".tr,
              ),
              Expanded(
                child: ctrl.loading
                    ? Center(child: LoadingCircle())
                    : ListView(
                        padding:
                            EdgeInsets.only(left: 18.w, right: 18.w, top: 30),
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '№',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: mainWhite,
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Text(
                                      'if_utasnii_dugaar'.tr,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: mainWhite,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 30.w),
                                Padding(
                                  padding: EdgeInsets.only(right: 30.w),
                                  child: Text(
                                    'if_tolow'.tr,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: mainWhite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Divider(color: mainWhite, height: 2.h),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: ctrl.inviteApprovedList.length > 0
                                ? Column(
                                    children:
                                        ctrl.inviteApprovedList.map((item) {
                                      var index =
                                          ctrl.inviteApprovedList.indexOf(item);
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        (index + 1).toString() +
                                                            '.',
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: mainWhite,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 16.w),
                                                    IntrinsicWidth(
                                                      child: Text(
                                                        item.phone ?? 'N/A',
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: mainWhite,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.5),
                                                    // border: Border.all(
                                                    //     color:
                                                    //         Colors.white.withOpacity(0.20)),
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                                  child: IntrinsicWidth(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 2.w),
                                                      child: Text(
                                                        item.status != null
                                                            ? item.status == 1
                                                                ? '+500 care'
                                                                : '0 care'
                                                            : "N/A",
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: item.status ==
                                                                  1
                                                              ? HexColor(
                                                                  "#98FB4E")
                                                              : Colors.white,
                                                        ),
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
                                    }).toList(),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.5,
                                    child: Center(
                                      child: Text(
                                        'if_tani_urisan_naiz_bvrtgvvleed_end_hargdn'
                                            .tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          height: 2.h,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                          color: textGrey,
                                        ),
                                      ),
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
    );
  }
}
