import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future checkConnection() async {
  // var connectivityResult = await (Connectivity().checkConnectivity());
  // NetworkUtil _netUtil = new NetworkUtil();
  // if (connectivityResult == ConnectivityResult.none) {
  //   return false;
  // } else if (connectivityResult == ConnectivityResult.mobile) {
  try {
    var _prefs = await SharedPreferences.getInstance();
    String? baseUrl = _prefs.getString("baseUrl");
    final result = await http.get(Uri.parse(baseUrl!)).timeout(
          Duration(seconds: 10),
        );
    if (result.statusCode == 200) {
      print('connected');
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    print(_);
    // return false;
  } on TimeoutException catch (e) {
    print(e);
  }
  // } else if (connectivityResult == ConnectivityResult.wifi) {
  //   try {
  //     final result = await _netUtil.get('https://go.care.mn').timeout(
  //       Duration(seconds: 5),
  //       onTimeout: () {
  //         return false;
  //       },
  //     );
  //     if (result != null && result != false) {
  //       print('connected');
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } on SocketException catch (_) {
  //     print('not connected');
  //     // return false;
  //   }
  // } else {
  //   return false;
  // }
}
