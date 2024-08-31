import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:lambda/modules/agent/agent_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:mdi/mdi.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/controllers/app_controller.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import 'package:move_to_earn/ui/component/buttons/gradient_button_small.dart';
import 'package:move_to_earn/ui/component/headers/header_for_page.dart';
import 'package:move_to_earn/ui/views/steps/daily.dart';
import 'package:move_to_earn/ui/views/steps/monthly.dart';
import 'package:move_to_earn/ui/views/steps/weekly.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/values.dart';

class BirthdayPage extends StatefulWidget {
  const BirthdayPage({super.key});

  @override
  State<BirthdayPage> createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage>
    with SingleTickerProviderStateMixin {
  late TabController tabBarController;
  ScrollController scrollController = ScrollController();
  final AppController appController = Get.put(AppController());
  bool is_loading = false;
  final formattedYear = DateFormat('yyyy').format(DateTime.now());
  String userBday_gift_year = '';
  bool isTaken = false;

  @override
  void initState() {
    super.initState();
    if (appController.user.value.bdayGiftDate != null) {
      userBday_gift_year =
          appController.user.value.bdayGiftDate!.substring(0, 4);
      if (userBday_gift_year == formattedYear) {
        isTaken = true;
      }
    }
  }

  takeCarePoint() async {
    setState(() {
      is_loading = true;
    });
    await updateScore();
  }

  updateScore() async {
    var uri = Uri.parse(endPoint + '/api/v1/bday/get-gift');
    var request = http.MultipartRequest('POST', uri)
      ..fields['user_id'] = appController.user.value.id.toString();
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseData);
      if (jsonResponse != null && jsonResponse['status'] == true) {
        // pr.update(message: jsonResponse['msg'], type: 'success');
        // await new Future.delayed(const Duration(seconds: 1));
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setInt("daily_goal", setGoal.value as int);
        // pr.hide();
        // appController.dailyGoal.value = setGoal.value as int;
        // Navigator.pop(context);
        setState(() {
          is_loading = false;
          isTaken = true;
        });
        appController.getInitData(context);
        // Get.offAll(() => MainPage());
      } else {
        setState(() {
          is_loading = false;
          isTaken = false;
        });
      }
    } else {
      print('Failed to load data');
      setState(() {
        is_loading = false;
        isTaken = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackColor(),
          Container(
            padding: EdgeInsets.only(top: 48.h, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  iconSize: 32,
                  icon: Icon(
                    Icons.close,
                    color: white,
                  ),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 100.h, left: 20.h, right: 20.h, bottom: 50.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'HAPPY BIRTHDAY',
                  style: TextStyle(
                      color: white,
                      fontSize: 22.h,
                      fontWeight: FontWeight.w800),
                ),
                // SizedBox(
                //   height: 10.h,
                // ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 2, // Thickness of the divider
                          margin: EdgeInsets.only(
                              right: 10), // Space between divider and star
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.white.withOpacity(0.5),
                                Colors.white
                              ],
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.star,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        size: 25,
                      ),
                      Expanded(
                        child: Container(
                          height: 2, // Thickness of the divider
                          margin: EdgeInsets.only(
                              left: 10), // Space between divider and star
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0.5),
                                Colors.transparent
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 40.h,
                // ),
                Container(
                  height: 210.h,
                  width: 230.h,
                  child: Lottie.asset('assets/lottie/gift_box.json',
                      width: 70, fit: BoxFit.fill, repeat: true),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Бэлгээ аваарай',
                  style: TextStyle(
                      color: white,
                      fontSize: 18.h,
                      fontWeight: FontWeight.w800),
                ),
                // SizedBox(height: 5.h),
                Column(
                  children: [
                    Text(
                      'Танд төрсөн өдрийн мэнд хүргэе.',
                      style: TextStyle(
                          color: white,
                          fontSize: 16.h,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      ' Доорх товч даран 500 care оноо аваарай.',
                      style: TextStyle(
                          color: white,
                          fontSize: 16.h,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                // SizedBox(height: 45.h),
                InkWell(
                  onTap: (() {
                    takeCarePoint();
                  }),
                  child: Container(
                    height: 40.h,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                          colors: isTaken == false
                              ? [
                                  ColorConstants.buttonGradient2,
                                  ColorConstants.buttonGradient1,
                                ]
                              : [
                                  const Color.fromARGB(255, 252, 135, 135),
                                  Colors.grey,
                                ]),
                    ),
                    child: isTaken == false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              is_loading == false
                                  ? Center(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Mdi.giftOutline,
                                            color: white,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Оноогоо авах',
                                            style: TextStyle(
                                                color: white,
                                                fontSize: 14.h,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: CircularProgressIndicator(
                                        color: white,
                                      ),
                                    ),
                            ],
                          )
                        : Center(
                            child: Icon(
                            Mdi.checkDecagram,
                            color: greenColor,
                            size: 35.h,
                          )),
                  ),
                ),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                          endIndent: 10, // Space between divider and star
                        ),
                      ),
                      Text(
                        'Share',
                        style: TextStyle(color: white),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 10, // Space between star and divider
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await FlutterShare.share(
                      title: 'Gocare',
                      text: 'tttt',
                    );
                  },
                  child: Container(
                    height: 40.h,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: white.withOpacity(0.3)),
                    child: Center(
                      child: Text(
                        'Хуваалцах',
                        style: TextStyle(
                            color: white,
                            fontSize: 14.h,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
