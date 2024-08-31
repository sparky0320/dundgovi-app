import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:move_to_earn/core/models/terms_of_service.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsOfServiceCtrl extends GetxController {
  ScrollController controller = ScrollController();
  bool btnIsActive = false;
  bool loading = true;
  bool isChecked = false;
  NetworkUtil _netUtil = NetworkUtil();
  TermsOfServiceModel? termsOfService;
  @override
  void onInit() {
    super.onInit();
    controller = ScrollController()..addListener(scrollListener);
  }

  void scrollListener() {
    if (controller.position.pixels > 4000 ||
        controller.position.pixels == controller.position.maxScrollExtent) {
      btnIsActive = true;
      update();
    }
  }

  Future<void> launchWeb(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future getTermsOfServiceData() async {
    loading = true;
    try {
      final response = await _netUtil.get('/api/terms-of-service');
      if (response != null && response['status'] == true) {
        termsOfService = TermsOfServiceModel.fromJson(response['data']);
        loading = false;
      } else {
        loading = false;
      }
      update();
    } catch (e) {
      loading = false;
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  void changeVal() {
    isChecked = !isChecked;
    update();
  }
}
