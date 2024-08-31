// ignore_for_file: body_might_complete_normally_nullable, unused_local_variable, unused_field

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lambda/utils/hexColor.dart';
import 'package:mdi/mdi.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Weekly extends StatefulWidget {
  Weekly({Key? key}) : super(key: key);
  List<Color> get availableColors =>
      const <Color>[yellow, greenColor, black, white, grey];

  final Color barBackgroundColor = Color(0xff5E757B);
  final Color barColor = Color(0xff627AF7);
  final Color touchedBarColor = greenColor;

  @override
  State<Weekly> createState() => _WeeklyState();
}

class _WeeklyState extends State<Weekly> {
  DateTime _currentDate = DateTime.now();
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;
  int length = 0;

  int totalSteps = 0;
  double totalCcal = 0;
  double travelLen = 0;
  String? fixedKm;
  @override
  void initState() {
    for (var item in appController.newWeekStepList) {
      totalSteps += item.count!;
    }

    for (var item in appController.newWeekStepList) {
      totalCcal += item.calorie!;
    }

    for (var item in appController.newWeekStepList) {
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
              children: [
                Text(
                  NumberFormat().format(totalSteps),
                  style: TextStyle(
                    color: white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "gop_alhsan_baina".tr,
                  style: TextStyle(
                    color: white,
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Container(
              alignment: Alignment.center,
              // padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.2,
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
                          i < appController.newWeekStepList.length;
                          i++) {
                        if (int.parse(appController.newWeekStepList[i].date!
                                    .substring(8, 10)) ==
                                day.day &&
                            int.parse(appController.newWeekStepList[i].date!
                                    .split("-")[1]) ==
                                day.month) {
                          String date = appController.newWeekStepList[i].date!
                              .split("-")[2];

                          return Center(
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Text(
                                  NumberFormat().format(
                                      appController.newWeekStepList[i].count),
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: 50.h,
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: RotatedBox(
                                      quarterTurns: 3,
                                      child: LinearProgressIndicator(
                                        minHeight: 15,
                                        value: appController
                                                .newWeekStepList[i].count! /
                                            appController
                                                .newWeekStepList[i].dailyGoal!,
                                        valueColor: AlwaysStoppedAnimation(
                                            const Color(0xff627AF7)),
                                        backgroundColor: Color(0xff5E757B),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                appController.newWeekStepList[i].count! >=
                                        appController
                                            .newWeekStepList[i].dailyGoal!
                                    ? Icon(
                                        Mdi.trophyVariant,
                                        color: white,
                                      )
                                    : Icon(
                                        Mdi.trophyVariant,
                                        color: Colors.transparent,
                                      )
                              ],
                            ),
                          );
                        }
                      }
                    },
                    dayPadding: 0.1,

                    pageScrollPhysics: NeverScrollableScrollPhysics(),
                    selectedDayBorderColor: Colors.transparent,
                    selectedDayButtonColor: Colors.transparent,
                    isScrollable: false,
                    showHeader: false,
                    weekFormat: true,
                    // firstDayOfWeek: 1,
                    // selectedDateTime: _currentDate,
                    todayBorderColor: Colors.transparent,
                    todayButtonColor: Colors.transparent,
                    // daysHaveCircularBorder: true,
                    childAspectRatio: 0.1,

                    /// null for not rendering any border, true for circular border, false for rectangular border
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
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
                        '$fixedKm km',
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
