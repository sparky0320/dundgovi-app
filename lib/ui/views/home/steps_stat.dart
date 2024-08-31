import 'dart:math';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/image_strings.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/headers/score_header.dart';

class StepStat extends StatefulWidget {
  const StepStat({super.key});

  @override
  State<StepStat> createState() => _StepStatState();
}

class _StepStatState extends State<StepStat> {
  ScrollController scrollController = ScrollController();
  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  double max = 1000;
  List<FlSpot> chartData = [];
  NetworkUtil networkUtil = NetworkUtil();
  String type = "week";

  List<dynamic> tabs = [
    {"name": "7 хоног", 'type': "week"},
    {"name": "Энэ сар", 'type': "month"},
    {"name": "Энэ жил", 'type': "year"}
  ];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData(type: "week");
    });
  }

  getData({String? type}) async {
    setState(() {
      chartData = [];
      loading = true;
    });
    try {
      var response = await networkUtil.get(baseUrl + "/api/step/chart",
          params: {"user_id": appController.user.value.id, "type": type});
      if (response != null && response['data'] != null) {
        for (dynamic item in response['data'] as List<dynamic>) {
          if (type == "year") {
            if (item['value'] == 0.0) {
              chartData.add(FlSpot.nullSpot);
            } else {
              chartData.add(
                  FlSpot(item['index'].toDouble(), item['value'].toDouble()));
            }
          } else {
            chartData.add(
                FlSpot(item['index'].toDouble(), item['value'].toDouble()));
          }
        }
        if (response['max'] != null) {
          max = response['max'].toDouble();
        }
      }
    } catch (e) {}
    setState(() {
      loading = false;
    });
    FirebaseCrashlytics.instance.recordError(
      Exception(e),
      StackTrace.current, // you should pass stackTrace in here
      reason: e,
      fatal: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackColor(),
          Positioned(
            top: -260.h,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              child: Image.asset(
                historyBackImage,
              ),
            ),
          ),
          ScoreHeader(),
          Container(
            padding: EdgeInsets.only(top: 120.h, right: 24, left: 24),
            child: GetBuilder(
                init: appController,
                builder: (_) {
                  return Column(
                    // controller: scrollController,
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: greyIndicator,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: tabs.map((e) {
                          return Expanded(
                            child: InkWell(
                              onTap: () async {
                                // controller.changeType(e.value, e.key);
                                setState(() {
                                  type = e['type'];
                                });
                                getData(type: type);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: type == e['type']
                                        ? mainPurple
                                        : Colors.transparent),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(
                                  e['name'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: type == e['type']
                                          ? FontWeight.w500
                                          : FontWeight.w400,
                                      color: type == e['type']
                                          ? Colors.white
                                          : textBlack),
                                ),
                              ),
                            ),
                          );
                        }).toList()),
                      ),
                      const SizedBox(height: 60),
                      loading
                          ? Container(
                              height: 280,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : Container(
                              height: 280,
                              width: double.infinity,
                              child: LineChart(
                                LineChartData(
                                  borderData: FlBorderData(
                                      show: true,
                                      border: Border(
                                          top: BorderSide.none,
                                          right: BorderSide.none,
                                          left: BorderSide(
                                              color:
                                                  Colors.white.withOpacity(.4)),
                                          bottom: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(.4)))),
                                  gridData: FlGridData(
                                    drawVerticalLine: false,
                                    drawHorizontalLine: false,
                                  ),
                                  maxY: max,
                                  titlesData: FlTitlesData(
                                      bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                        showTitles: true,
                                        // reservedSize: 10,
                                        interval: type == "week"
                                            ? 1
                                            : (type == "month" ? 7 : 90),
                                        getTitlesWidget: (value, meta) {
                                          if (type == "year") {
                                            int year = DateTime.now().year;
                                            int dayOfYear = value.toInt();

                                            DateTime dateTime = DateTime(year)
                                                .add(Duration(
                                                    days: dayOfYear - 1));
                                            int month = dateTime.month;
                                            return Text(
                                              (month.toInt()).toString() +
                                                  "/" +
                                                  dateTime.day.toString(),
                                              style:
                                                  TextStyle(color: mainWhite),
                                            );
                                          }
                                          if (type == "week") {
                                            String tmp = "";
                                            switch (value.toInt()) {
                                              case 1:
                                                tmp = "Даваа";
                                                break;
                                              case 2:
                                                tmp = "Мягмар";
                                                break;
                                              case 3:
                                                tmp = "Лхагва";
                                                break;
                                              case 4:
                                                tmp = "Пүрэв";
                                                break;
                                              case 5:
                                                tmp = "Баасан";
                                                break;
                                              case 6:
                                                tmp = "Бямба";
                                                break;
                                              case 7:
                                                tmp = "Ням";
                                                break;
                                              default:
                                            }
                                            return Container(
                                              margin:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                tmp,
                                                style: TextStyle(
                                                    color: mainWhite,
                                                    fontSize: 12),
                                              ),
                                            );
                                          }
                                          return Text(
                                            (value.toInt()).toString(),
                                            style: TextStyle(color: mainWhite),
                                          );
                                        },
                                      )),
                                      leftTitles: AxisTitles(
                                          // axisNameSize: 100,

                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            reservedSize: 55,
                                            interval: max >= 1000
                                                ? 1000
                                                : (max >= 100 ? 100 : 10),
                                            getTitlesWidget: (value, meta) {
                                              return Container(
                                                // width: 100,
                                                child: Text(
                                                  value.toInt().toString(),
                                                  style: TextStyle(
                                                      color: mainWhite),
                                                ),
                                              );
                                            },
                                          ),
                                          drawBelowEverything: false),
                                      topTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                          drawBelowEverything: false),
                                      rightTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                          drawBelowEverything: false)),
                                  lineBarsData: [
                                    // The red line
                                    LineChartBarData(
                                        spots: chartData,
                                        isCurved: true,
                                        preventCurveOverShooting: true,
                                        barWidth: 1.6,
                                        color: Colors.indigo,
                                        dotData: FlDotData(show: true),
                                        belowBarData: BarAreaData(
                                            color:
                                                Colors.indigo.withOpacity(.5),
                                            show: true)),
                                  ],
                                  backgroundColor: Colors.white.withOpacity(.1),
                                ),
                              ),
                            ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
