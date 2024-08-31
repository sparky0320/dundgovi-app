// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lambda/utils/date.dart';
import 'package:move_to_earn/core/controllers/challenge_controller.dart';
import 'package:move_to_earn/core/models/challenge/challenge_model.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import 'package:move_to_earn/ui/component/countdown_date.dart';
import 'package:move_to_earn/ui/component/headers/score_for_header.dart';
import 'package:move_to_earn/ui/views/home/modalbottoms.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ChallengeTaskPage extends StatefulWidget {
  final ChallengeModel data;

  const ChallengeTaskPage({super.key, required this.data});

  @override
  State<ChallengeTaskPage> createState() => _ChallengeTaskPageState(this.data);
}

class _ChallengeTaskPageState extends State<ChallengeTaskPage>
    with SingleTickerProviderStateMixin {
  dynamic myScore;
  ChallengeModel data;
  ChallengeController controller = Get.find();

  _ChallengeTaskPageState(this.data);

  @override
  void initState() {
    super.initState();
  }

  _launchURL(link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch ');
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
              body: Stack(
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            margin: EdgeInsets.only(bottom: 120),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 12),
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
                                                _launchURL('  ${data.webLink}');
                                              },
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                // '${data.webLink}+Navigator.pop(context);Navigator.pop(context);Navigator.pop(context);Navigator.pop(context);Navigator.pop(context);Navigator.pop(context);Navigator.pop(context);',
                                                'Website',
                                                style: TextStyle(
                                                    color: Color(0x128EF6)
                                                        .withOpacity(1),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                            color:
                                                Color(0x128EF6).withOpacity(1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 11, bottom: 11, right: 15, left: 15),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFFFF).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Чэлленжийн зорилго',
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        '${widget.data.goalText}',
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
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
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      decoration: BoxDecoration(
                                          color:
                                              Color(0xFFFFFF).withOpacity(0.2),
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
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                data.startDate != null
                                                    ? getDatewithoutYear(
                                                            data.startDate!) +
                                                        '  -  '
                                                    : "",
                                                style: TextStyle(
                                                    color: white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                data.endDate != null
                                                    ? getDatewithoutYear(
                                                        data.endDate!)
                                                    : "",
                                                style: TextStyle(
                                                    color: white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      decoration: BoxDecoration(
                                          color:
                                              Color(0xFFFFFF).withOpacity(0.2),
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
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            '${data.userCount} хүн',
                                            style: TextStyle(
                                                color: white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 11, bottom: 11, right: 15, left: 15),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFFFF).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Зорилгоо биелүүлэхэд үлдсэн хугацаа',
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
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
                                      isDone
                                          ? Container(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 5),
                                              child: Text(
                                                'Хугацаа дууссан байна',
                                                style: TextStyle(
                                                    color:
                                                        white.withOpacity(0.7)),
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
                                      top: 11, bottom: 11, right: 15, left: 15),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFFFF).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20)),
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
                                      top: 11, bottom: 11, right: 15, left: 15),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFFFF).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20)),
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
                                      top: 11, bottom: 11, right: 15, left: 15),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFFFF).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20)),
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
                                // Navigator.pop(context);
                                dialogInvite(context);
                              },
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 15, bottom: 15),
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                      child: Text(
                                    'Найзаа урих',
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ))),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ));
        });
  }
}
