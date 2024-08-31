import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:lambda/plugins/progress_dialog/progress_dialog.dart';
import 'package:move_to_earn/core/models/signup/model_aimag.dart';
import 'package:move_to_earn/ui/views/signup/create_pass.dart';
import '../../models/signup/model_sum.dart';

class GetInfoController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TabController tabController;
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  String? selectedDate;
  String selectedGender = "";
  String? weight;
  String? height;
  String? aimagHot;
  String? sumDuureg;
  int? stepsId;
  NetworkUtil _netUtil = NetworkUtil();
  bool loading = true;

  List<AimagModel> aimagList = [];
  List<SumDuuregModel> sumDuuregList = [];
  // List<StepsDayModel> stepsDayList = [];

  List data = [
    {'id': 1, 'title': 'pep_eregtei'.tr, 'type': 'm'},
    {'id': 2, 'title': 'pep_emegtei'.tr, 'type': 'f'},
  ];

  List<SumDuuregModel> selectedSumDuureg = [];

  @override
  void onInit() {
    super.onInit();
  }

  // Get information when signup
  getInfo(BuildContext context, email) async {
    ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(const Duration(milliseconds: 300));

    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.post('/api/auth/get-info', {
        'email': email,
        "gender": selectedGender,
        'weight': weight,
        'height': height,
        "birthday": selectedDate,
        'aimag_hot': aimagHot,
        'sum_duureg': sumDuureg,
        'steps_day_id': stepsId,
        'first_name': firstName.text,
        'last_name': lastName.text,
        'phone': phone.text,
      });

      print('response --- $response');
      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await Future.delayed(
          const Duration(seconds: 1),
        );
        pr.hide();

        Get.to(
          () => CreatePassScreen(
            phone: phone.text,
          ),
          duration: const Duration(milliseconds: 500),
          transition: Transition.rightToLeftWithFade,
        );
      } else {
        pr.update(message: response['msg'], type: 'error');
        await Future.delayed(
          const Duration(milliseconds: 1500),
        );
        pr.hide();
      }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await Future.delayed(
        const Duration(milliseconds: 1500),
      );
      pr.hide();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  // Get aimag list
  Future getAimagList() async {
    try {
      final response = await _netUtil.get('/api/get-aimag');

      if (response['status'] == true) {
        loading = false;
      }

      for (var item in response['data']) {
        aimagList.add(AimagModel.fromJson(item));
      }
      update();
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  // Get sum duureg list
  Future getSumDuuregList() async {
    try {
      final response = await _netUtil.get('/api/get-duureg');

      if (response['status'] == true) {
        loading = false;
      }

      for (var item in response['data']) {
        sumDuuregList.add(SumDuuregModel.fromJson(item));
      }

      update();
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }
}
