import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lambda/utils/hexColor.dart';
import 'package:move_to_earn/core/constants/textstyle.dart';
import 'package:move_to_earn/core/controllers/app_controller.dart';
import 'package:move_to_earn/core/controllers/loading_circle.dart';
import 'package:move_to_earn/core/controllers/notification_controller.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import 'package:move_to_earn/ui/component/headers/header_for_page.dart';
import 'package:move_to_earn/ui/views/home/notification-detail.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationPage extends StatefulWidget {
  // final dynamic data;

  const NotificationPage({Key? key}) : super(key: key);
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationController notifController = Get.find();
  AppController appController = Get.find();

  final List<String> items = [
    "np_clear_notification".tr,
    "np_read_all_notification".tr,
  ];
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    notifController.getNotifications();
  }

  dynamic deleteNotification(BuildContext context, dynamic item) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("alert_delete_notification".tr),
          actions: <Widget>[
            MaterialButton(
              child: Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(4)),
                child: Text(
                  "pp_yes".tr,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                notifController.deleteNotification(item);
                notifController.readNotification(item);
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              child: Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(4)),
                child: Text(
                  "pp_no".tr,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  dynamic clearNotification(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text('alert_delete_all_notification'.tr),
          actions: [
            Container(
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Colors.black),
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shadowColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "pp_no".tr,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Container(
              width: 120,
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
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  notifController.clearNotifications();
                  Navigator.pop(context);
                },
                child: Text(
                  "pp_yes".tr,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  moreButton() async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.black, width: 1),
                      bottom: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      clearNotification(context);
                    },
                    child: Text(
                      "np_clear_notification".tr,
                      style: TTextTheme.darkTextTheme.headlineMedium,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.black, width: 1),
                      bottom: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      notifController.readAllNotification();
                    },
                    child: Text(
                      "np_read_all_notification".tr,
                      style: TTextTheme.darkTextTheme.headlineMedium,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
        init: notifController,
        builder: (logic) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
                body: Stack(
              children: [
                BackColor(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Header

                    HeaderForPage(
                      backArrow: BackArrow(),
                      text: "np_medegdel".tr,
                      iconButton: Row(
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              underline: Container(
                                height: 0.1,
                                color: Colors.red,
                              ),
                              isExpanded: true,
                              items: items
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 60,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                      width: 0.5,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                    ),
                                                    top: BorderSide(
                                                      width: 0.5,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                    )),
                                              ),
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ))
                                  .toList(),
                              onChanged: (value) {
                                if (value == "np_clear_notification".tr) {
                                  clearNotification(context);
                                } else {
                                  notifController.readAllNotification();
                                }
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 40,
                                width: 40,
                                elevation: 2,
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.more_horiz,
                                ),
                                iconSize: 24,
                                iconEnabledColor: Colors.white,
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                ),
                                offset: const Offset(-20, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all(6),
                                  thumbVisibility:
                                      MaterialStateProperty.all(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                    // Text("data")

                    //body
                    SizedBox(height: 32.h),

                    Expanded(
                        child: FirestoreListView(
                            pageSize: 10,
                            query: FirebaseFirestore.instance
                                .collection("user_data")
                                .doc(appController.user.value.id.toString())
                                // .doc("1700")
                                .collection("notification")
                                .orderBy("created_at", descending: true),
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            loadingBuilder: (_) {
                              return SizedBox(
                                height: 400,
                                child: Center(child: LoadingCircle()),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'np_hooson_bn'.tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.sp,
                                        color: Colors.black),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              );
                            },
                            emptyBuilder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'np_hooson_bn'.tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.sp,
                                        color: Colors.white),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              );
                            },
                            itemBuilder: (context, doc) {
                              Map<String, dynamic>? item =
                                  doc.exists ? doc.data() : null;
                              // return Text("djfkls");
                              if (item == null) {
                                return const SizedBox();
                              }
                              item['id'] = doc.id;
                              return InkWell(
                                onTap: () async {
                                  notifController.readNotification(item);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NotificationDetailPage(
                                                data: item,
                                              )));
                                },
                                child: Slidable(
                                  key: ValueKey(1),
                                  endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          deleteNotification(context, item);
                                        },
                                        backgroundColor: Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 16.h),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(1.00, 0.00),
                                        end: Alignment(-1, 0),
                                        colors: [
                                          Color(0xFF7E7E7E).withOpacity(0.9),
                                          Color(0x70CFCFCF).withOpacity(0.4),
                                          Color(0x7A7E7E7E),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.r)),
                                      border: Border.all(
                                          width: 1,
                                          color: white.withOpacity(0.7)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 12.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    item['title'] ?? "",
                                                    style: goSecondTextStyle
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: 17),
                                                  ),
                                                ),
                                                item['read_it'] != true
                                                    ? Container(
                                                        height: 8,
                                                        width: 8,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            color: Colors.red),
                                                        child: SizedBox())
                                                    : const SizedBox(),
                                                item['created_at'] != null
                                                    ? Text(
                                                        item['created_at']
                                                            .toDate()
                                                            .toString()
                                                            .substring(0, 16),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12.sp,
                                                            color: HexColor(
                                                                "#A5A5A5")),
                                                        overflow:
                                                            TextOverflow.fade,
                                                      )
                                                    : const SizedBox()
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            height: 42.h,
                                            child: Text(
                                              item['msg'] ?? "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: white,
                                                  fontSize: 15),
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }))
                  ],
                ),
              ],
            )),
          );
        });
  }
}
