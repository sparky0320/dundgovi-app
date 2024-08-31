import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:lambda/modules/network_util.dart';
import 'package:lambda/plugins/progress_dialog/progress_dialog.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/models/coupon/coupon_category.dart';
import 'package:move_to_earn/main.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../models/coupon/coupon_model.dart';

class CouponPageCtrl extends GetxController {
  bool loading = false;
  List<CouponModel> allCouponList = [];
  List<CouponModel> myCouponList = [];
  int page = 1;
  List<CouponModel> inactive = [];
  NetworkUtil _netUtil = NetworkUtil();
  DateTime currentTime = DateTime.now();
  String steps = '0';
  List<CouponCategory> categories = [];
  int lastPage = 1;

  get stepList => null;

  Future getCouponByCategory() async {
    loading = true;
    categories = [];
    try {
      final response = await _netUtil.get(baseUrl + '/api/coupons',
          params: {"user_id": appController.user.value.id});
      print('res ----${response}');
      if (response != null && response['status'] == true) {
        for (var item in response['data']) {
          categories.add(CouponCategory.fromJson(item));
        }
      }
      loading = false;
      update();
    } catch (e) {
      loading = false;
      update();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  Future<bool> getAllCouponList(page, type) async {
    try {
      if (type == 3) {
        print('Api ajillahgui');
      } else {
        loading = true;
        if (type == 2) {
          allCouponList = [];
        }

        final response = await _netUtil.get(
            baseUrl + '/api/get-all-coupons/${appController.user.value.id}',
            // 'http://192.168.1.63:3000/api/v1/get-all-coupons/${appController.user.value.id}',
            params: {'page': page, 'is_darkhan': appController.isDarkhan});
        print('get product response == $response');
        if (response != null && response['status'] == true) {
          loading = false;
          for (var item in response['data']['data']) {
            allCouponList.add(CouponModel.fromJson(item));
          }
          // print(response);
        } else {
          print('object');
        }
        loading = false;

        if (response == null || response is String) {
          Get.defaultDialog(
              title: "alert_internet_shalgana_uu".tr,
              content: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryColor1,
                  shape: StadiumBorder(),
                  side: BorderSide(width: 2, color: Colors.white),
                ),
                onPressed: () {
                  agentController.logout();
                  appController.logout();
                  appController.setUser(null);
                  main();
                },
                child: Text(
                  'Дахин ачааллах',
                  style: TextStyle(color: white),
                ),
              ),
              barrierDismissible: false);
        }

        update();
      }
    } catch (e) {
      loading = false;
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }

    update();
    return loading;
  }

  Future<bool> getMyCouponList(page) async {
    loading = true;
    myCouponList = [];
    try {
      final response = await _netUtil.get(
          baseUrl + '/api/get-all-my-coupons/${appController.user.value.id}',
          params: {'page': page, 'is_darkhan': appController.isDarkhan});
      // print('get product response == $response');
      if (response != null && response['status'] == true) {
        loading = false;
        for (var item in response['data']['data']) {
          // print(myCouponList.length);
          // if (myCouponList.length == item.length) {
          // } else {
          myCouponList.add(CouponModel.fromJson(item));
          // }
        }
      } else {
        print('object');
      }

      if (response == null || response is String) {
        appController.showTopToast("alert_internet_shalgana_uu".tr);
        // agentController.logout();
        // appController.logout();
        // appController.setUser(null);
        main();
      }

      loading = false;

      update();
      return loading;
    } catch (e) {
      loading = false;
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
    return loading;
  }

  Future getAllCoupon() async {
    print(appController.user.value.id);
    loading = true;
    allCouponList = [];
    try {
      final response = await _netUtil.get(baseUrl + '/api/getCoupon');
      print('get product response == $response');
      if (response != null && response['status'] == true) {
        loading = false;
        for (var item in response['data']) {
          allCouponList.add(CouponModel.fromJson(item));
        }
        // print(response);
      } else {
        print('object');
      }
      loading = false;

      update();
      // print(allCouponList);
    } catch (e) {
      loading = false;

      update();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  Future getCoupon() async {
    print(appController.user.value.id);
    loading = true;
    myCouponList = [];
    try {
      final response = await _netUtil.get(baseUrl +
          '/api/getCouponList?user_id=${appController.user.value.id}');
      // print('get product response == ${response.toString()}');
      if (response != null && response['status'] == true) {
        loading = false;
        for (var item in response['data']) {
          myCouponList.add(CouponModel.fromJson(item));
        }
        // print(response);
      } else {
        print('object');
      }

      loading = false;

      update();
    } catch (e) {
      loading = false;

      update();

      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  Future getInactiveCoupon() async {
    inactive = [];
    try {
      final response = await _netUtil.get(baseUrl +
          '/api/coupon/inactive?user_id=${appController.user.value.id}');
      if (response != null && response['status'] == true) {
        for (var item in response['data']) {
          inactive.add(CouponModel.fromJson(item));
        }
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

  addCoupon(BuildContext context, CouponModel coupon) async {
    ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(const Duration(milliseconds: 300));

    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.post(baseUrl + '/api/add-coupon', {
        'user_id': appController.user.value.id,
        'coupon_id': coupon.id,
      });
      if (response == null) {
        pr.hide();
        await getCoupon();
        await getCouponByCategory();
        appController.getPoint();
        getUserCoupon(coupon);
        Navigator.pop(context);
      }
      if (response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await getCoupon();
        await getCouponByCategory();
        appController.getPoint();
        await Future.delayed(const Duration(seconds: 1));
        getUserCoupon(coupon);
        pr.hide();
        Navigator.pop(context);
      } else {
        pr.update(message: response['msg'], type: 'error');
        await Future.delayed(const Duration(milliseconds: 3500));
        pr.hide();
      }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await Future.delayed(const Duration(milliseconds: 3500));
      pr.hide();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  Future getUserCoupon(CouponModel coupon) async {
    print(appController.user.value.id);
    loading = true;
    try {
      final response = await _netUtil.post(baseUrl + '/api/coupon/user',
          {"user_id": appController.user.value.id, "coupon_id": coupon.id});
      if (response != null && response['status'] == true) {
        coupon.item = response['data'];
        // print(response);
      }

      loading = false;
      update();
    } catch (e) {
      loading = false;
      update();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  useCoupon(BuildContext context, couponCode) async {
    ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(const Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.get(baseUrl +
          '/api/create-use-coupons-request/${couponCode}/${appController.user.value.id}');

      if (response == null) {
        pr.hide();
        await getCoupon();
        await getCouponByCategory();
        appController.getPoint();
        Navigator.pop(context);
      }

      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await Future.delayed(const Duration(seconds: 1));
        await getCoupon();
        await getCouponByCategory();
        appController.getPoint();
        pr.hide();
        Navigator.pop(context);
      } else {
        pr.update(message: response['msg'], type: 'error');
        await Future.delayed(const Duration(milliseconds: 3500));
        pr.hide();
      }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await Future.delayed(const Duration(milliseconds: 3500));
      pr.hide();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  cancelCoupon(BuildContext context, couponCode) async {
    ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(const Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.get(baseUrl +
          '/api/coupons/cancel/${couponCode}/${appController.user.value.id}');

      if (response == null) {
        pr.hide();
        await getCoupon();
        await getCouponByCategory();
        appController.getPoint();
        Navigator.pop(context);
      }

      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await Future.delayed(const Duration(seconds: 1));
        await getCoupon();
        await getCouponByCategory();
        appController.getPoint();
        pr.hide();
        Navigator.pop(context);
      } else {
        pr.update(message: response['msg'], type: 'error');
        await Future.delayed(const Duration(milliseconds: 3500));
        pr.hide();
      }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await Future.delayed(const Duration(milliseconds: 3500));
      pr.hide();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }
}
