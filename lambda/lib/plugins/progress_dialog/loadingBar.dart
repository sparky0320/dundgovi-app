import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLoading() {
  Get.defaultDialog(
      title: "alert_tur_huleene_uu".tr,
      content: CircularProgressIndicator(),
      barrierDismissible: false);
}

showDialog(String text) {
  Get.defaultDialog(
      title: text,
      content: CircularProgressIndicator(),
      barrierDismissible: false);
}

dismissLoadingWidget() {
  Get.back();
}
