import 'dart:async';

// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TimerState extends GetxController {
  // Initial Count Timer value
  bool playing = false;
  // var max = 600;
  // var current = 600;
  var max = 10;
  var current = 10;

  late VoidCallback done;

  //object for Timer Class
  late Timer _timer;

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void startCountDown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      countDown();
    });
  }

  void setTime(int num) {
    max = num;
    current = num;
    update();
  }

  void pause() {
    _timer.cancel();
    playing = false;
    update();
  }

  void reset() {
    _timer.cancel();
    current = max;
    playing = false;
    update();
  }

  void seek(int second, int type) {
    for (int i = 1; i <= second; i++) {
      if (type != 1) {
        countDown();
      } else {
        if (current < max) countUp();
      }
    }
  }

  countDown() {
    if (current > 0) {
      current--;
      playing = true;
    } else {
      _timer.cancel();
      playing = false;
      done();
    }
    update();
  }

  countUp() {
    current++;
    playing = true;
    update();
  }

  getPercent() {
    double percent = (current) / max;
    return percent;
  }
}
