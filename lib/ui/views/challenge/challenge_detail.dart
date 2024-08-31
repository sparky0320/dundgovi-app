import 'dart:ui';

import 'package:action_slider/action_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lambda/plugins/progress_dialog/progress_dialog.dart';
import 'package:lambda/utils/date.dart';
import 'package:lambda/utils/hexColor.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/challenge_controller.dart';
import 'package:move_to_earn/core/controllers/profile/pincode_controller.dart';
import 'package:move_to_earn/core/models/challenge/challenge_model.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import 'package:move_to_earn/ui/component/countdown_date.dart';
import 'package:move_to_earn/ui/component/headers/score_for_header.dart';
import 'package:move_to_earn/ui/views/challenge/challenge_score_box.dart';
import 'package:move_to_earn/ui/views/challenge/challenge_task_page.dart';
import 'package:move_to_earn/ui/views/main_page.dart';
import 'package:move_to_earn/utils/number.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/theme/widget_theme/text_theme.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ChallengeDetail extends StatefulWidget {
  final ChallengeModel data;

  const ChallengeDetail({super.key, required this.data});

  @override
  State<ChallengeDetail> createState() => _ChallengeDetailState(this.data);
}

class _ChallengeDetailState extends State<ChallengeDetail>
    with SingleTickerProviderStateMixin {
  ChallengeController controller = Get.find();
  PinCodeCtrl pinCodeCtrl = Get.put(PinCodeCtrl());
  ChallengeModel data;
  late TabController tabBarController;
  ActionSliderController? _controller;
  dynamic myScore;

  _ChallengeDetailState(this.data);

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 2, vsync: this);
    data.joined != null && data.joined == false
        ? {}
        : {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              controller.getScoreBoard(data);
              controller.getMyScoreBoard(data);
              controller.getInvites(data);
            })
          };
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getChallenges();
      getData();
    });
  }

  @override
  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }

  getData() async {
    controller.getChallengeScore(widget.data).then((value) {
      if (value != null) {
        setState(() {
          myScore = value;
        });
      }
    });
  }

  joinChallenge() async {
    ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(const Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    dynamic result = await controller.joinChallenge(data);
    // print('result join challenge -----$result');
    if (result != null && result['status'] == true) {
      pr.update(message: result['msg'].toString(), type: 'success');
      await Future.delayed(const Duration(seconds: 1));
      pr.hide();
      controller.getScoreBoard(data);
      controller.getMyScoreBoard(data);
      controller.getInvites(data);
    } else {
      pr.update(message: result['msg'].toString(), type: 'error');
      await Future.delayed(const Duration(milliseconds: 3500));
      pr.hide();
    }
  }

  exitChallenge() async {
    ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(const Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    dynamic result = await controller.exitChallenge(data);
    print('result join challenge -----$result');
    if (result != null && result['status'] == true) {
      pr.update(message: result['msg'].toString(), type: 'success');
      await Future.delayed(const Duration(seconds: 1));
      pr.hide();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
      // controller.getScoreBoard(data);
      // controller.getMyScoreBoard(data);
      // controller.getInvites(data);
    } else {
      pr.update(message: result['msg'].toString(), type: 'error');
      await Future.delayed(const Duration(milliseconds: 3500));
      pr.hide();
    }
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
    DateTime parsedEndDate =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(data.endDate.toString());
    DateTime now = DateTime.now();
    bool isDone = now.isAfter(parsedEndDate);
    return GetBuilder(
        init: controller,
        builder: (_) {
          return Scaffold(
            body: data.joined != null && data.joined == false
                ? Stack(
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
                                          'Чэлленж',
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
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Container(
                                      height: 160,
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    "$baseUrl${data.logoImg}",
                                                memCacheWidth: (MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width *
                                                        MediaQuery.of(context)
                                                            .devicePixelRatio)
                                                    .round(),
                                                filterQuality:
                                                    FilterQuality.low,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                fit: BoxFit.fill,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: new BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                    sigmaX: 30.0,
                                                    sigmaY: 30.0,
                                                  ),
                                                  child:
                                                      // CachedNetworkImage(
                                                      //   imageUrl:
                                                      //       "$baseUrl${data.logoImg}",
                                                      //   memCacheWidth: (MediaQuery
                                                      //                   .of(context)
                                                      //               .size
                                                      //               .width *
                                                      //           MediaQuery.of(
                                                      //                   context)
                                                      //               .devicePixelRatio)
                                                      //       .round(),
                                                      //   filterQuality:
                                                      //       FilterQuality.low,
                                                      //   width:
                                                      //       MediaQuery.of(context)
                                                      //           .size
                                                      //           .width,
                                                      //   height:
                                                      //       MediaQuery.of(context)
                                                      //           .size
                                                      //           .height,
                                                      // ),
                                                      CachedNetworkImage(
                                                    imageUrl:
                                                        "$baseUrl${data.logoImg}",
                                                    memCacheWidth: (MediaQuery
                                                                    .of(context)
                                                                .size
                                                                .width *
                                                            MediaQuery.of(
                                                                    context)
                                                                .devicePixelRatio)
                                                        .round(),
                                                    filterQuality:
                                                        FilterQuality.low,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    margin: EdgeInsets.only(bottom: 120),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 12),
                                          child: Text(data.title.toString(),
                                              style: TTextTheme
                                                  .darkTextTheme.displayMedium),
                                        ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.start,
                                        //   children: [
                                        //     Icon(
                                        //       Icons.location_on_outlined,
                                        //       color: white,
                                        //       size: 30,
                                        //     ),
                                        //     SizedBox(width: 10),
                                        //     Expanded(
                                        //       child: Text(
                                        //         'Байршил: ${widget.data.address}',
                                        //         style: TextStyle(
                                        //             color: white,
                                        //             fontSize: 14,
                                        //             fontWeight:
                                        //                 FontWeight.w700),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        // SizedBox(height: 10),
                                        data.webLink == null ||
                                                data.webLink == "null" ||
                                                data.webLink == ''
                                            ? SizedBox(width: 0)
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.manage_search,
                                                    color: white,
                                                    size: 30,
                                                  ),
                                                  SizedBox(width: 10),
                                                  // Text(
                                                  //   'Web хуудас: ',
                                                  //   style: TextStyle(
                                                  //       color: white,
                                                  //       fontSize: 14,
                                                  //       fontWeight: FontWeight.w700),
                                                  // ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        // _launchURL(
                                                        //     '  ${data.webLink}');
                                                        launchURL(
                                                            "${data.webLink}");
                                                      },
                                                      child: Text(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        // '${data.webLink}+Navigator.pop(context);Navigator.pop(context);Navigator.pop(context);Navigator.pop(context);Navigator.pop(context);Navigator.pop(context);Navigator.pop(context);',
                                                        'Website',
                                                        style: TextStyle(
                                                            color: Color(
                                                                    0x128EF6)
                                                                .withOpacity(1),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              color: white,
                                              size: 30,
                                            ),
                                            SizedBox(width: 10),
                                            InkWell(
                                              onTap: () {
                                                UrlLauncher.launch(
                                                    'tel:${data.contactNumber}');
                                              },
                                              child: Text(
                                                '${widget.data.contactNumber}',
                                                style: TextStyle(
                                                    color: Color(0x128EF6)
                                                        .withOpacity(1),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 11,
                                              bottom: 11,
                                              right: 15,
                                              left: 15),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFFFFF)
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Чэлленжийн зорилго',
                                                style: TextStyle(
                                                    color: white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                '${widget.data.goalText}',
                                                style: TextStyle(
                                                    color: white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 11,
                                                  bottom: 11,
                                                  right: 15,
                                                  left: 15),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.3,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFFFFF)
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Чэлленжийн хугацаа',
                                                    style: TextStyle(
                                                        color: white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        // '${DateFormat('MM/dd').format(DateTime.parse(data.startDate.toString()))} - ',
                                                        data.startDate != null
                                                            ? '${DateFormat('MM/dd').format(DateTime.parse(data.startDate.toString()))} - '
                                                            : "",
                                                        style: TextStyle(
                                                            color: white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                        data.endDate != null
                                                            ? '${DateFormat('MM/dd').format(DateTime.parse(data.endDate.toString()))}'
                                                            : "",
                                                        style: TextStyle(
                                                            color: white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 11,
                                                  bottom: 11,
                                                  right: 15,
                                                  left: 15),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.3,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFFFFF)
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Нийт бүртгүүлсэн',
                                                    style: TextStyle(
                                                        color: white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    '${data.userCount} хүн',
                                                    style: TextStyle(
                                                        color: white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 11,
                                              bottom: 11,
                                              right: 15,
                                              left: 15),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFFFFF)
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Зорилгоо биелүүлэхэд үлдсэн хугацаа',
                                                style: TextStyle(
                                                    color: white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment
                                              //           .spaceEvenly,
                                              //   children: [
                                              //     Column(
                                              //       children: [
                                              //         Text(
                                              //           '72',
                                              //           style: TextStyle(
                                              //               color: white,
                                              //               fontSize: 20,
                                              //               fontWeight:
                                              //                   FontWeight
                                              //                       .w700),
                                              //         ),
                                              //         Text(
                                              //           'цаг',
                                              //           style: TextStyle(
                                              //               color: Color(
                                              //                       0xDCDCDC)
                                              //                   .withOpacity(1),
                                              //               fontSize: 12,
                                              //               fontWeight:
                                              //                   FontWeight
                                              //                       .w400),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //     Text(
                                              //       ':',
                                              //       style: TextStyle(
                                              //           color: Color(0xDCDCDC)
                                              //               .withOpacity(1),
                                              //           fontSize: 20,
                                              //           fontWeight:
                                              //               FontWeight.w400),
                                              //     ),
                                              //     Column(
                                              //       children: [
                                              //         Text(
                                              //           '24',
                                              //           style: TextStyle(
                                              //               color: white,
                                              //               fontSize: 20,
                                              //               fontWeight:
                                              //                   FontWeight
                                              //                       .w700),
                                              //         ),
                                              //         Text(
                                              //           'минут',
                                              //           style: TextStyle(
                                              //               color: Color(
                                              //                       0xDCDCDC)
                                              //                   .withOpacity(1),
                                              //               fontSize: 12,
                                              //               fontWeight:
                                              //                   FontWeight
                                              //                       .w400),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //     Text(
                                              //       ':',
                                              //       style: TextStyle(
                                              //           color: Color(0xDCDCDC)
                                              //               .withOpacity(1),
                                              //           fontSize: 20,
                                              //           fontWeight:
                                              //               FontWeight.w400),
                                              //     ),
                                              //     Column(
                                              //       children: [
                                              //         Text(
                                              //           '47',
                                              //           style: TextStyle(
                                              //               color: white,
                                              //               fontSize: 20,
                                              //               fontWeight:
                                              //                   FontWeight
                                              //                       .w700),
                                              //         ),
                                              //         Text(
                                              //           'секунд',
                                              //           style: TextStyle(
                                              //               color: Color(
                                              //                       0xDCDCDC)
                                              //                   .withOpacity(1),
                                              //               fontSize: 12,
                                              //               fontWeight:
                                              //                   FontWeight
                                              //                       .w400),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ],
                                              // ),
                                              CountDownDate(
                                                date: data.endDate!,
                                                fontSize: 8,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 30),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.question_mark_sharp,
                                              color: white,
                                              size: 30,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Дэлгэрэнгүй',
                                              style: TextStyle(
                                                  color: white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 11,
                                              bottom: 11,
                                              right: 15,
                                              left: 15),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFFFFF)
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Html(
                                            data: data.description,
                                            style: {
                                              "body": Style(
                                                  color: Colors.white,
                                                  fontSize: FontSize.medium),
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 30),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.rule,
                                              color: white,
                                              size: 30,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Дүрэм',
                                              style: TextStyle(
                                                  color: white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 11,
                                              bottom: 11,
                                              right: 15,
                                              left: 15),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFFFFF)
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Html(
                                            data: data.taskText,
                                            style: {
                                              "body": Style(
                                                  color: Colors.white,
                                                  fontSize: FontSize.medium),
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 30),
                                        Row(
                                          children: [
                                            Icon(
                                              LineIcons.trophy,
                                              color: white,
                                              size: 30,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Шагналын сан',
                                              style: TextStyle(
                                                  color: white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 11,
                                              bottom: 11,
                                              right: 15,
                                              left: 15),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFFFFF)
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Html(
                                            data: data.prizeText,
                                            style: {
                                              "body": Style(
                                                  color: Colors.white,
                                                  fontSize: FontSize.medium),
                                            },
                                          ),
                                          // Column(
                                          //   children: [
                                          //     Row(
                                          //       mainAxisAlignment:
                                          //           MainAxisAlignment.start,
                                          //       children: [
                                          //         Image.asset(
                                          //           coinGold,
                                          //           height: careIconSize.w,
                                          //           width: careIconSize.w,
                                          //         ),
                                          //         SizedBox(width: 5),
                                          //         Flexible(
                                          //           child: Text(
                                          //             maxLines: 4,
                                          //             'I байр: Эмчтэй эмийн сангаар үйлчлүүлэх 50,000₮ төгрөгийн хөнгөлөлтийн эрх. 20,000 Care оноо',
                                          //             style: TextStyle(
                                          //                 color: white,
                                          //                 fontSize: 14,
                                          //                 fontWeight:
                                          //                     FontWeight.w700),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //     SizedBox(height: 20),
                                          //     Row(
                                          //       mainAxisAlignment:
                                          //           MainAxisAlignment.start,
                                          //       children: [
                                          //         Image.asset(
                                          //           coinSilver,
                                          //           height: careIconSize.w,
                                          //           width: careIconSize.w,
                                          //         ),
                                          //         SizedBox(width: 5),
                                          //         Flexible(
                                          //           child: Text(
                                          //             maxLines: 4,
                                          //             'II байр: Эмчтэй эмийн сангаар үйлчлүүлэх 30,000₮ төгрөгийн хөнгөлөлтийн эрх. 15,000 Care оноо',
                                          //             style: TextStyle(
                                          //                 color: white,
                                          //                 fontSize: 14,
                                          //                 fontWeight:
                                          //                     FontWeight.w700),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //     SizedBox(height: 20),
                                          //     Row(
                                          //       mainAxisAlignment:
                                          //           MainAxisAlignment.start,
                                          //       children: [
                                          //         Image.asset(
                                          //           coinBronze,
                                          //           height: careIconSize.w,
                                          //           width: careIconSize.w,
                                          //         ),
                                          //         SizedBox(width: 5),
                                          //         Flexible(
                                          //           child: Text(
                                          //             maxLines: 4,
                                          //             'III байр: Эмчтэй эмийн сангаар үйлчлүүлэх 20,000₮ төгрөгийн хөнгөлөлтийн эрх. 10,000 Care оноо ',
                                          //             style: TextStyle(
                                          //                 color: white,
                                          //                 fontSize: 14,
                                          //                 fontWeight:
                                          //                     FontWeight.w700),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ],
                                          // ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0.0,
                          right: 0.0,
                          child: data.userCount! >= data.limit!
                              ? Container(
                                  padding: EdgeInsets.only(
                                      left: 30, right: 30, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Color(0x0E1C26).withOpacity(1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      )),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
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
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          'Оролцогчийн тоо дүүрсэн байна',
                                          style: TextStyle(
                                              color: white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ))),
                                  ),
                                )
                              : Container(
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
                                          '${widget.data.score} care оноогоор нэгдэх',
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
                                      actionController.loading();
                                      await joinChallenge();
                                      actionController.reset();
                                    },
                                  ),
                                ))
                    ],
                  )
                //---------------------------------------------------------- oroltsson bol ?? -------------------------------------------------------------------
                : Stack(
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
                                          'Чэлленж',
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
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Container(
                                      height: 160,
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    "$baseUrl${data.logoImg}",
                                                memCacheWidth: (MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width *
                                                        MediaQuery.of(context)
                                                            .devicePixelRatio)
                                                    .round(),
                                                filterQuality:
                                                    FilterQuality.low,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: new BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                    sigmaX: 30.0,
                                                    sigmaY: 30.0,
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "$baseUrl${data.logoImg}",
                                                    memCacheWidth: (MediaQuery
                                                                    .of(context)
                                                                .size
                                                                .width *
                                                            MediaQuery.of(
                                                                    context)
                                                                .devicePixelRatio)
                                                        .round(),
                                                    filterQuality:
                                                        FilterQuality.low,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                  // CachedNetworkImage(
                                                  //   imageUrl:
                                                  //       "$baseUrl${data.logoImg}",
                                                  //   memCacheWidth: (MediaQuery
                                                  //                   .of(context)
                                                  //               .size
                                                  //               .width *
                                                  //           MediaQuery.of(
                                                  //                   context)
                                                  //               .devicePixelRatio)
                                                  //       .round(),
                                                  //   filterQuality:
                                                  //       FilterQuality.low,
                                                  // ),
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    margin: EdgeInsets.only(bottom: 150),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 12),
                                          child: Text(data.title.toString(),
                                              style: TTextTheme
                                                  .darkTextTheme.displayMedium),
                                        ),
                                        SizedBox(height: 15),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 11,
                                              bottom: 11,
                                              right: 15,
                                              left: 15),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFFFFF)
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Зорилгоо биелүүлэхэд үлдсэн хугацаа:',
                                                style: TextStyle(
                                                    color: white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              isDone
                                                  ? Container(
                                                      padding: EdgeInsets.only(
                                                          top: 10, bottom: 5),
                                                      child: Text(
                                                        'Хугацаа дууссан байна',
                                                        style: TextStyle(
                                                            color: white
                                                                .withOpacity(
                                                                    0.7)),
                                                      ),
                                                    )
                                                  : CountDownDate(
                                                      date: data.endDate!,
                                                      fontSize: 8,
                                                    ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 30),
                                        controller.scoreBoard.length == 0
                                            ? SizedBox()
                                            : Stack(
                                                children: [
                                                  Positioned(
                                                    top: 0,
                                                    child: Container(
                                                      child: Text("Таны алхалт",
                                                          style: TTextTheme
                                                              .darkTextTheme
                                                              .displayMedium),
                                                    ),
                                                  ),
                                                  controller.scoreBoard.length <
                                                          1
                                                      ? SizedBox()
                                                      : Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 200),
                                                          child:
                                                              ChallengeScoreBox(
                                                                  challenge:
                                                                      data),
                                                        ),
                                                  Positioned(
                                                    top: 50,
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        5,
                                                    child: Center(
                                                      child:
                                                          CircularPercentIndicator(
                                                        radius: 102.0.w,
                                                        lineWidth: 11.0.w,
                                                        arcType: ArcType.HALF,
                                                        arcBackgroundColor:
                                                            white,
                                                        linearGradient:
                                                            LinearGradient(
                                                          colors: [
                                                            HexColor("6BE726"),
                                                            HexColor("128EF6"),
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          transform:
                                                              GradientRotation(
                                                                  3),
                                                          end: Alignment
                                                              .bottomCenter,
                                                        ),
                                                        animateFromLastPercent:
                                                            true,
                                                        percent: 1,
                                                        circularStrokeCap:
                                                            CircularStrokeCap
                                                                .round,
                                                        center: // Count the steps
                                                            Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            50),
                                                                child: appController
                                                                        .stepLoading
                                                                        .value
                                                                    ? Center(
                                                                        child:
                                                                            CircularProgressIndicator())
                                                                    : myScore !=
                                                                                null &&
                                                                            myScore['score'] !=
                                                                                null
                                                                        ? Text(
                                                                            formatNumber(myScore['score']),
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 35.w,
                                                                            ),
                                                                          )
                                                                        : Text(
                                                                            "0",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 47.w,
                                                                            ),
                                                                          ),
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  'gop_alhsan_baina'
                                                                      .tr,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12.w,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0.0,
                          right: 0.0,
                          child: Column(
                            children: [
                              SizedBox(height: 8.h),
                              Container(
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
                                        Get.to(() => ChallengeTaskPage(
                                              data: data,
                                            ));
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 15,
                                              bottom: 15),
                                          decoration: BoxDecoration(
                                              color: white,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(
                                              child: Text(
                                            'Даалгавар',
                                            style: TextStyle(
                                                color: black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ))),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // exitChallenge();
                                        Get.dialog(
                                          Container(
                                            child: AlertDialog(
                                              backgroundColor:
                                                  HexColor('516469')
                                                      .withOpacity(0.8),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Гарахдаа итгэлтэй байна уу?',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(
                                                    height: 25.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.0)),
                                                            color: Color(
                                                                    0xffffff)
                                                                .withOpacity(
                                                                    0.3)),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3.5,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Center(
                                                            child: Text(
                                                              "pp_no".tr,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
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
                                                                  end:
                                                                      const FractionalOffset(
                                                                          1.0,
                                                                          0.0),
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
                                                                .width /
                                                            3.5,
                                                        child: TextButton(
                                                          onPressed: () async {
                                                            exitChallenge();
                                                          },
                                                          child: Center(
                                                            child: Text(
                                                              "pp_yes".tr,
                                                              style: TextStyle(
                                                                color:
                                                                    mainWhite,
                                                                fontSize: 13.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
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
                                            'Чэлленжээс гарах',
                                            style: TextStyle(
                                                color: white.withOpacity(0.7),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ))),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     dialogInvite(context);
                                    //   },
                                    //   child: Container(
                                    //       padding: EdgeInsets.only(
                                    //           left: 20,
                                    //           right: 20,
                                    //           top: 15,
                                    //           bottom: 15),
                                    //       decoration: BoxDecoration(
                                    //           color: Colors.transparent,
                                    //           borderRadius:
                                    //               BorderRadius.circular(15)),
                                    //       child: Center(
                                    //           child: Text(
                                    //         'Найзаа урих',
                                    //         style: TextStyle(
                                    //             color: white,
                                    //             fontSize: 16,
                                    //             fontWeight: FontWeight.w700),
                                    //       ))),
                                    // ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
          );
        });
  }
}

class SocialIcon extends StatelessWidget {
  const SocialIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          'F',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
