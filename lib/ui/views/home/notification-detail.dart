import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lambda/utils/date.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/notification_controller.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import 'package:move_to_earn/ui/component/headers/header_for_page.dart';

class NotificationDetailPage extends StatefulWidget {
  final dynamic data;

  const NotificationDetailPage({Key? key, this.data}) : super(key: key);
  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  NotificationController notificationController = Get.find();
  @override
  void initState() {
    super.initState();
    // model.getNotification();
  }

  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // print(widget.data['items']);
    return GetBuilder<NotificationController>(
        init: notificationController,
        builder: (logic) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
                body: Stack(
              children: [
                BackColor(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Header
                    HeaderForPage(text: 'Дэлгэрэнгүй', backArrow: BackArrow()),

                    //body
                    SizedBox(height: 32.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data['title'] ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18.sp,
                                color: Colors.white),
                          ),
                          SizedBox(height: 48.h),
                          Text(
                            widget.data['msg'] ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 40.h),
                          widget.data['created_at'] != null
                              ? Text(
                                  getDateTime(
                                      widget.data['created_at'].toDate()),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: textGreyColor,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
          );
        });
  }
}
