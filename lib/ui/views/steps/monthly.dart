// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lambda/utils/hexColor.dart';
import 'package:mdi/mdi.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

class Monthly extends StatefulWidget {
  Monthly({Key? key}) : super(key: key);

  @override
  State<Monthly> createState() => _MonthlyState();
}

class _MonthlyState extends State<Monthly> {
  DateTime _currentDate = DateTime.now();

  int totalSteps = 0;
  double totalCcal = 0;
  double travelLen = 0;
  String? fixedKm;
  @override
  void initState() {
    for (var item in appController.newStepList) {
      totalSteps += item.count!;
    }

    for (var item in appController.newStepList) {
      totalCcal += item.calorie!;
    }

    for (var item in appController.newStepList) {
      travelLen += item.travelLength!;
    }
    double LenKm = travelLen;
    fixedKm = LenKm.toStringAsFixed(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 50.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      NumberFormat().format(totalSteps),
                      style: TextStyle(
                        color: white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "gop_alhsan_baina".tr,
                      style: TextStyle(
                        color: white,
                        fontSize: 14,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${DateTime.now().toString().substring(0, 7)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.center,
              // padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: Container(
                child: Container(
                  // height: 400,
                  // width: 375,
                  // margin: EdgeInsets.symmetric(horizontal: 16.0),
                  // width: MediaQuery.of(context).size.width,
                  child: CalendarCarousel(
                    // onDayPressed: (DateTime date, List<Event> events) {
                    //   this.setState(() => _currentDate = date);
                    // },
                    daysTextStyle: TextStyle(color: Colors.white),
                    weekendTextStyle: TextStyle(
                      color: Colors.red,
                    ),
                    thisMonthDayBorderColor: Colors.transparent,
                    weekDayBackgroundColor: Color(0xff556B73),
                    weekDayPadding: EdgeInsets.all(5),
                    weekdayTextStyle: TextStyle(color: white),
                    showIconBehindDayText: true,
                    // customWeekDayBuilder: (weekday, weekdayName) {
                    //   return Text('data');
                    // },
                    //      weekDays: null, /// for pass null when you do not want to render weekDays
                    //      headerText: Container( /// Example for rendering custom header
                    //        child: Text('Custom Header'),
                    //      ),
                    customDayBuilder: (
                      /// you can provide your own build function to make custom day containers
                      bool isSelectable,
                      int index,
                      bool isSelectedDay,
                      bool isToday,
                      bool isPrevMonthDay,
                      TextStyle textStyle,
                      bool isNextMonthDay,
                      bool isThisMonthDay,
                      DateTime day,
                    ) {
                      /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
                      /// This way you can build custom containers for specific days only, leaving rest as default.

                      // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
                      // if (day.day == 15) {

                      for (var i = 0;
                          i < appController.newStepList.length;
                          i++) {
                        if (int.parse(appController.newStepList[i].date!
                                    .substring(8, 10)) ==
                                day.day &&
                            int.parse(appController.newStepList[i].date!
                                    .substring(5, 7)) ==
                                day.month) {
                          String date = appController.newStepList[i].date!
                              .substring(8, 10);

                          return Container(
                            child: PopupMenuButton(
                              surfaceTintColor: Colors.transparent,
                              tooltip: "",
                              position: PopupMenuPosition.under,
                              child: Center(
                                child: CircularPercentIndicator(
                                  radius: 23.w,
                                  lineWidth: 4.0.w,
                                  backgroundWidth: 2.w,
                                  backgroundColor:
                                      Color(0xC8C8C8).withOpacity(0.2),
                                  progressColor: Color(0x627AF7).withOpacity(1),
                                  animation: true,
                                  animationDuration: 1200,
                                  animateFromLastPercent: true,
                                  percent: appController
                                              .newStepList[i].count! >=
                                          appController
                                              .newStepList[i].dailyGoal!
                                      ? 1
                                      : appController.newStepList[i].count! /
                                          appController
                                              .newStepList[i].dailyGoal!,
                                  // percent: 0.5,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: // Count the steps
                                      Container(
                                          alignment: Alignment.center,
                                          child: appController
                                                      .newStepList[i].count! >=
                                                  appController
                                                      .newStepList[i].dailyGoal!
                                              ? Icon(
                                                  Mdi.trophyVariant,
                                                  color: white,
                                                )
                                              : Text(
                                                  date,
                                                  style: TextStyle(
                                                    color: white,
                                                  ),
                                                )),
                                ),
                              ),
                              itemBuilder: (context) {
                                return <PopupMenuItem>[
                                  PopupMenuItem(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "cp_alhalt_too".tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                          ": ${appController.newStepList[i].count!}")
                                    ],
                                  ))
                                ];
                              },
                            ),
                          );
                        }
                      }
                    },
                    pageScrollPhysics: NeverScrollableScrollPhysics(),

                    isScrollable: false,
                    showHeader: false,
                    weekFormat: false,
                    selectedDateTime: _currentDate,
                    todayBorderColor: Colors.transparent,
                    todayButtonColor: Colors.transparent,
                    daysHaveCircularBorder: true,
                    childAspectRatio: 0.8,

                    /// null for not rendering any border, true for circular border, false for rectangular border
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 30,
                        lineWidth: 5.0.w,
                        backgroundColor: Color(0xC8C8C8).withOpacity(0.5),
                        linearGradient: LinearGradient(
                          colors: [
                            HexColor("627AF7"),
                            HexColor("EF566A"),
                            HexColor("627AF7"),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        animation: true,
                        animationDuration: 1200,
                        animateFromLastPercent: true,
                        percent: 1,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: // Count the steps
                            Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Mdi.fire,
                            color: white,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        NumberFormat().format(totalCcal) + ' cal',
                        style: TextStyle(
                            color: Color(0xffdcdcdc),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CircularPercentIndicator(
                        radius: 30,
                        lineWidth: 5.0.w,
                        // arcType: ArcType.FULL_REVERSED,
                        // arcBackgroundColor:
                        //     HexColor("C8C8C8").withOpacity(0.3),
                        backgroundColor: Color(0xC8C8C8).withOpacity(0.5),
                        linearGradient: LinearGradient(
                          colors: [
                            HexColor("627AF7"),
                            HexColor("EF566A"),
                            HexColor("627AF7"),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        animation: true,
                        animationDuration: 1200,
                        animateFromLastPercent: true,
                        percent: 1,
                        circularStrokeCap: CircularStrokeCap.round,

                        center: // Count the steps
                            Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Mdi.walk,
                            color: white,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        '$fixedKm' + ' km',
                        style: TextStyle(
                            color: Color(0xffdcdcdc),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
