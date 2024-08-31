import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:lambda/plugins/progress_dialog/progress_dialog.dart';
import 'package:move_to_earn/ui/views/signup/verify.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TabController tabController;
  // TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController referCode = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController passwordConfirm = new TextEditingController();

  NetworkUtil _netUtil = NetworkUtil();

  bool toggleEye = true;
  bool toggleEye2 = true;

  @override
  void onInit() {
    super.onInit();
  }

//Register
  doRegister(BuildContext context) async {
    ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(const Duration(milliseconds: 300));

    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();

    try {
      var response = await _netUtil.post('/api/auth/register-mail', {
        'email': email.text,
        'refer_code': referCode.text,
        // 'password': password.text,
      });

      print('response $response');
      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await Future.delayed(const Duration(seconds: 1));
        pr.hide();
        Get.to(
          () => VerifyPage(
            email: email.text,
          ),
          duration: const Duration(milliseconds: 500),
          transition: Transition.rightToLeftWithFade,
        );
      } else {
        pr.update(message: response['msg'], type: 'error');
        await Future.delayed(const Duration(milliseconds: 1500));
        pr.hide();
      }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await Future.delayed(const Duration(milliseconds: 1500));
      pr.hide();
    }
  }

  // create password
  setPassword(BuildContext context, phone) async {
    ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(const Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();

    try {
      var response = await _netUtil.post(
        '/api/auth/set-password',
        {
          'phone': phone,
          'password': password.text,
          'isEdit': false,
        },
      );
      print('response $response');
      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await Future.delayed(const Duration(seconds: 1));
        pr.hide();
        Get.offAllNamed("/login");
        password.clear();
        passwordConfirm.clear();
      } else {
        pr.update(message: response['msg'], type: 'error');
        await Future.delayed(
          const Duration(milliseconds: 1500),
        );
        pr.hide();
      }
    } catch (e) {
      var response = await _netUtil.post(
        '/api/auth/set-password',
        {
          'phone': phone,
          'password': password.text,
          'isEdit': false,
        },
      );
      print('Error in the first request: $e');
      await Future.delayed(Duration(seconds: 1));
      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await Future.delayed(const Duration(seconds: 1));
        pr.hide();
        Get.offAllNamed("/login");
        password.clear();
        passwordConfirm.clear();
      } else {
        pr.update(message: response['msg'], type: 'error');
        await Future.delayed(
          const Duration(milliseconds: 1500),
        );
        pr.hide();
      }
    }
  }

// Use ----------------------------- http ---------------------------

// //Register
//   doRegister(BuildContext context) async {
//     ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
//     FocusScope.of(context).requestFocus(FocusNode());
//     await Future.delayed(const Duration(milliseconds: 300));

//     pr.setMessage('alert_tur_huleene_uu'.tr);
//     pr.show();

//     String url = 'http://10.0.2.2:8000/api/auth/register-mail';

//     try {
//       final responseFirst = await http.post(Uri.parse(url), body: {
//         'email': email.text,
//         'refer_code': referCode.text,
//         // 'password': password.text,
//       });

//       if (responseFirst.statusCode == 200) {
//         var response = jsonDecode(responseFirst.body);

//         print('response $response');
//         if (response != null && response['status'] == true) {
//           pr.update(message: response['msg'], type: 'success');
//           await Future.delayed(const Duration(seconds: 1));
//           pr.hide();
//           Get.to(
//             () => VerifyPage(
//               email: email.text,
//             ),
//             duration: const Duration(milliseconds: 500),
//             transition: Transition.rightToLeftWithFade,
//           );
//         } else {
//           pr.update(message: response['msg'], type: 'error');
//           await Future.delayed(const Duration(milliseconds: 1500));
//           pr.hide();
//         }
//       } else {
//         return Future.error("Serve error");
//       }
//     } catch (e) {
//       return Future.error(e);
//     }
//   }

//   // create password
//   setPassword(BuildContext context, phone) async {
//     ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
//     FocusScope.of(context).requestFocus(FocusNode());
//     await Future.delayed(const Duration(milliseconds: 300));
//     pr.setMessage('alert_tur_huleene_uu'.tr);
//     pr.show();

//     String url = 'http://10.0.2.2:8000/api/auth/set-password';

//     try {
//       final responseFirst = await http.post(Uri.parse(url), body: {
//         'phone': phone,
//         'password': password.text,
//         // 'isEdit': false,
//       });

//       if (responseFirst.statusCode == 200) {
//         final response = jsonDecode(responseFirst.body);

//         print('response $response');
//         if (response != null && response['status'] == true) {
//           pr.update(message: response['msg'], type: 'success');
//           await Future.delayed(const Duration(seconds: 1));
//           pr.hide();
//           Get.offAllNamed("/login");
//           password.clear();
//           passwordConfirm.clear();
//         } else {
//           pr.update(message: response['msg'], type: 'error');
//           await Future.delayed(const Duration(milliseconds: 1500));
//           pr.hide();
//         }
//       } else {
//         return Future.error("Serve error");
//       }
//     } catch (e) {
//       return Future.error(e);
//     }
//   }
}
