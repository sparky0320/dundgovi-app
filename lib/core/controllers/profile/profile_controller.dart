import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:lambda/plugins/progress_dialog/progress_dialog.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/input_number_ctrl.dart';
import 'package:move_to_earn/core/models/user.dart';
import 'package:move_to_earn/ui/views/profile/email_verify.dart';
import 'package:move_to_earn/ui/views/profile/phone_verify.dart';
import 'package:move_to_earn/utils/shake_animation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class ProfileCtrl extends GetxController {
  String phoneNumber = '';
  String errorMsg = '';
  ScrollController controller = ScrollController();
  bool btnIsActive = false;
  int phoneLength = 0;
  int emailLength = 0;
  bool loading = true;
  bool isChecked = false;
  XFile? image;
  NetworkUtil _netUtil = NetworkUtil();
  final ImagePicker _picker = ImagePicker();
  final shakeKey = GlobalKey<ShakeWidgetState>();
  bool isFail = false;
  final GlobalKey<FormState> verifyFormKey = GlobalKey<FormState>();
  final pinputFocusNode = FocusNode();
  TextEditingController phone = new TextEditingController();
  TextEditingController verCode = new TextEditingController();
  String? selectedDate;
  String selectedGender = "m";
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  String? height;
  String? weight;
  String? phoneNumberView;
  String? emailCtrl;
  String aimagHot = "";
  String sumDuureg = "";
  InputNumberController inputNumberController =
      Get.put(InputNumberController());
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  List data = [
    {'id': 1, 'title': 'pep_eregtei'.tr, 'type': 'm'},
    {'id': 2, 'title': 'pep_emegtei'.tr, 'type': 'f'},
  ];

  editUserInformation<String>(BuildContext context) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.post('/api/auth/edit-user', {
        "id": appController.user.value.id,
        "first_name": firstName.text,
        "last_name": lastName.text,
        "email": email.text,
        "birthday": selectedDate,
        "gender": selectedGender,
        "aimag_hot": appController.user.value.aimagHot,
        "sum_duureg": appController.user.value.sumDuureg,
      });
      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
        agentController.updateUserState(response['data']);
        appController.setUser(User.fromJson(response['data']));
        Navigator.pop(context);
        update();
      } else {
        pr.update(message: response['msg'], type: 'error');
        await new Future.delayed(const Duration(milliseconds: 1500));
        pr.hide();
      }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await new Future.delayed(const Duration(milliseconds: 1500));
      pr.hide();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  changeUserData<String>(BuildContext context) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    var body = {
      "id": appController.user.value.id,
      "first_name": firstName.text,
      "last_name": lastName.text,
      "birthday": selectedDate,
      "gender": selectedGender,
      "weight": weight,
      "height": height,
      "aimag_hot": appController.user.value.aimagHot,
      "sum_duureg": appController.user.value.sumDuureg,
    };
    try {
      var response = await _netUtil.post('/api/auth/change-user-data', body);
      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
        agentController.updateUserState(response['data']);
        appController.setUser(User.fromJson(response['data']));
        Navigator.pop(context);
        update();
      } else {
        pr.update(message: response['msg'], type: 'error');
        await new Future.delayed(const Duration(milliseconds: 1500));
        pr.hide();
      }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await new Future.delayed(const Duration(milliseconds: 1500));
      pr.hide();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  editHeight(BuildContext context, {int? data}) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.post('/api/auth/edit-height', {
        "id": appController.user.value.id,
        "height": height.toString(),
      });
      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
        agentController.updateUserState(response['data']);
        appController.setUser(User.fromJson(response['data']));
        Navigator.pop(context);
        update();
      } else {
        pr.update(message: response['msg'], type: 'error');
        await new Future.delayed(const Duration(milliseconds: 1500));
        pr.hide();
      }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await new Future.delayed(const Duration(milliseconds: 1500));
      pr.hide();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  editWeight(BuildContext context, {int? data}) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.post('/api/auth/edit-weight', {
        "id": appController.user.value.id,
        "weight": weight.toString(),
      });
      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
        agentController.updateUserState(response['data']);
        appController.setUser(User.fromJson(response['data']));
        Navigator.pop(context);
        update();
      } else {
        pr.update(message: response['msg'], type: 'error');
        await new Future.delayed(const Duration(milliseconds: 1500));
        pr.hide();
      }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await new Future.delayed(const Duration(milliseconds: 1500));
      pr.hide();
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

  Future getImage(String type, context) async {
    await Permission.photos.request();
    await Permission.mediaLibrary.request();
    await Permission.photosAddOnly.request();

    await _picker
        .pickImage(
            source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
            maxHeight: 400,
            maxWidth: 400)
        .then((value) {
      print('val -----$value');
      image = value;
    });
    print(image);
    if (image != null) {
      print(image!.path);
      File rotatedImage = File(image!.path);
      rotatedImage = await FlutterExifRotation.rotateImage(path: image!.path);
      uploadAvatar(rotatedImage, context);
      update();
    }
  }

  Future uploadAvatar(File file, context) async {
    dio.Dio dioHttp = dio.Dio();
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      dio.FormData formData = dio.FormData.fromMap(
          {"file": await dio.MultipartFile.fromFile(file.path)});
      var uploadData =
          await dioHttp.post(baseUrl + "/lambda/krud/upload", data: formData);
      var response = await _netUtil.post('/api/auth/change-avatar/', {
        "id": appController.user.value.id.toString(),
        "avatar": uploadData.toString(),
      });
      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
        agentController.updateUserState(response['data']);
        appController.setUser(User.fromJson(response['data']));
      } else {
        pr.update(message: response['msg'], type: 'error');
        await new Future.delayed(const Duration(milliseconds: 1500));
        pr.hide();
      }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await new Future.delayed(const Duration(milliseconds: 1500));
      pr.hide();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  checkPhone(BuildContext context) async {
    ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(const Duration(milliseconds: 300));

    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.post('/api/auth/edit-phone-check', {
        "phone": phone.text,
        "user_id": appController.user.value.id,
      });
      if (response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await Future.delayed(const Duration(seconds: 1));
        pr.hide();
        print('navigate to verify page');
        Get.to(
          () => PhoneVerifyPage(phone: phone.text),
          duration: const Duration(milliseconds: 500),
          transition: Transition.rightToLeftWithFade,
        );
      } else {
        pr.update(message: response['msg'], type: 'error');
        await Future.delayed(const Duration(milliseconds: 1500));
        pr.hide();
        Navigator.pop(context);
        phone.clear();
      }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await Future.delayed(const Duration(milliseconds: 1500));
      pr.hide();
      Navigator.pop(context);
      phone.clear();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  checkEmail(BuildContext context) async {
    ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(const Duration(milliseconds: 300));

    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.post('/api/auth/edit-mail-check', {
        "email": email.text,
        "user_id": appController.user.value.id,
      });
      if (response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await Future.delayed(const Duration(seconds: 1));
        pr.hide();
        Get.to(
          () => EmailVerifyPage(email: email.text),
          duration: const Duration(milliseconds: 500),
          transition: Transition.rightToLeftWithFade,
        );
      } else {
        pr.update(message: response['msg'], type: 'error');
        await Future.delayed(const Duration(milliseconds: 1500));
        pr.hide();
        // Navigator.pop(context);
        email.clear();
      }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await Future.delayed(const Duration(milliseconds: 1500));
      pr.hide();
      Navigator.pop(context);
      phone.clear();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  doVerify<String>(BuildContext context, phone) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.post('/api/auth/edit-phone-verify', {
        "id": appController.user.value.id,
        'phone': phone,
        "verify_code": verCode.text
      });
      print('verify ---- response -----$response');
      if (response != null && response['status'] == true) {
        isFail = false;
        update();
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
        Navigator.pop(context);
        Navigator.pop(context);
        verCode.clear();
        User userData = User.fromJson(response['data']);
        agentController.updateUserState(response['data']);
        appController.setUser(userData);

        print('phoneeeee-------${userData.phone}');
        phoneNumberView = userData.phone;
        emailCtrl = userData.email;
        update();
        inputNumberController.eraseAll();
      } else {
        errorMsg = response['msg'];
        isFail = true;
        verCode.clear();
        inputNumberController.eraseAll();
        update();
        pr.hide();
        shakeKey.currentState?.shake();
      }
    } catch (e) {
      errorMsg = e.toString();
      isFail = true;
      verCode.clear();
      inputNumberController.eraseAll();
      update();
      pr.hide();
      shakeKey.currentState?.shake();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  doVerifyEmail<String>(BuildContext context, email) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.post('/api/auth/edit-mail-verify', {
        "id": appController.user.value.id,
        'email': email,
        "verify_code": verCode.text
      });
      print('verify ---- response -----$response');
      if (response != null && response['status'] == true) {
        isFail = false;
        update();
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
        Navigator.pop(context);
        Navigator.pop(context);
        verCode.clear();
        User userData = User.fromJson(response['data']);
        agentController.updateUserState(response['data']);
        appController.setUser(userData);

        print('phoneeeee-------${userData.phone}');
        emailCtrl = userData.email;
        phoneNumberView = userData.phone;
        update();
        inputNumberController.eraseAll();
      } else {
        errorMsg = response['msg'];
        isFail = true;
        verCode.clear();
        inputNumberController.eraseAll();
        update();
        pr.hide();
        shakeKey.currentState?.shake();
      }
    } catch (e) {
      errorMsg = e.toString();
      isFail = true;
      verCode.clear();
      inputNumberController.eraseAll();
      update();
      pr.hide();
      shakeKey.currentState?.shake();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  reSendSms<String>(BuildContext context, phone) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response =
          await _netUtil.post('/api/auth/resendSms', {"phone": phone});
      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
      } else {
        pr.update(message: response['msg'], type: 'error');
        await new Future.delayed(const Duration(milliseconds: 1500));
        pr.hide();
      }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await new Future.delayed(const Duration(milliseconds: 1500));
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
