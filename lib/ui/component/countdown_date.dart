// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lambda/utils/date.dart';
import 'package:nb_utils/nb_utils.dart';

class CountDownDate extends StatefulWidget {
  final DateTime date;
  final double fontSize;
  final bool showSecond;
  CountDownDate(
      {Key? key,
      required this.date,
      this.fontSize = 16,
      this.showSecond = true})
      : super(key: key);

  @override
  _CurrentTimeWidget createState() => new _CurrentTimeWidget();
}

class _CurrentTimeWidget extends State<CountDownDate> {
  String _timeString = '';
  String _time1String = '';
  String _time2String = '';
  String _time3String = '';

  @override
  void initState() {
    _getTime();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());

    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();

    DateTime date = widget.date;
    if (now.isAfter(date)) {
      if (mounted) {
        setState(() {
          _timeString = getDateTime(date);
          _time1String = getH(date);
          _time2String = getM(date);
          _time3String = getS(date);
        });
      }
      return;
    }

    Duration diff = date.difference(now);
    String formattedDateTime =
        "${diff.inHours}цаг ${diff.inMinutes.remainder(60).toString().padLeft(2, '0')}мин";
    String formattedH = "${diff.inHours}";
    String formattedM =
        "${diff.inMinutes.remainder(60).toString().padLeft(2, '0')}";
    String formattedS = "";
    if (widget.showSecond == true) {
      formattedS +=
          " ${diff.inSeconds.remainder(60).toString().padLeft(2, '0')}";
    }

    if (mounted) {
      setState(() {
        _timeString = formattedDateTime;
        _time1String = formattedH;
        _time2String = formattedM;
        _time3String = formattedS;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.w,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  _time1String,
                  style: TextStyle(
                      color: white, fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  'цаг',
                  style: TextStyle(
                      color: Color(0xDCDCDC).withOpacity(1),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Text(
              ':',
              style: TextStyle(
                  color: Color(0xDCDCDC).withOpacity(1),
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            Column(
              children: [
                Text(
                  _time2String,
                  style: TextStyle(
                      color: white, fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  'минут',
                  style: TextStyle(
                      color: Color(0xDCDCDC).withOpacity(1),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Text(
              ':',
              style: TextStyle(
                  color: Color(0xDCDCDC).withOpacity(1),
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            Column(
              children: [
                Text(
                  _time3String,
                  style: TextStyle(
                      color: white, fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  'секунд',
                  style: TextStyle(
                      color: Color(0xDCDCDC).withOpacity(1),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
        // Text(
        //   _time1String,
        //   style: TextStyle(
        //     color: Colors.white.withOpacity(0.8),
        //     fontSize: widget.fontSize,
        //   ),
        // ),
        // Text(
        //   _time2String,
        //   style: TextStyle(
        //     color: Colors.white.withOpacity(0.8),
        //     fontSize: widget.fontSize,
        //   ),
        // ),
        // Text(
        //   _time3String,
        //   style: TextStyle(
        //     color: Colors.white.withOpacity(0.8),
        //     fontSize: widget.fontSize,
        //   ),
        // ),
      ],
    );
  }
}
