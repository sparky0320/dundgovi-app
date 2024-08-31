import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
  print(message.notification!.title);
}

class Notify {
  SharedPreferences? _prefs;
  NetworkUtil _netUtil = new NetworkUtil();

  Future? initNotify(String userId, BuildContext ctx) {
    Firebase.initializeApp().whenComplete(() async {
      await configFirebase(userId, ctx);
    });

    if (Platform.isAndroid) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification!.title}');
          // ToastContext().init(ctx);
          // Toast.show(
          //   message.notification!.title!,
          //   duration: Toast.lengthLong,
          //   gravity: Toast.top,
          //   backgroundColor: Colors.black,
          //   webTexColor: Color(0xccffffff),
          // );
          Get.snackbar(message.notification!.title ?? "",
              message.notification!.body ?? "",
              backgroundColor: Colors.white.withOpacity(.7));
        }
      });
    }
    return null;
  }

  Future configFirebase(userId, BuildContext ctx) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
      messaging.subscribeToTopic("gocare-all");

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      String? token = await messaging.getToken();
      print("FCM Token: $token");
      _prefs = await SharedPreferences.getInstance();
      _prefs!.setString("pushToken", token!);
      try {
        final response = await _netUtil
            .post('/api/fcm/token', {"id": userId, "token": token});
        print('response ---- device register ----- $response');
      } catch (e) {
        print(e);
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> checkPermission() async {
    _prefs = await SharedPreferences.getInstance();
    String? userId = _prefs!.getString("userId");

    var response = await _netUtil.get('/check/notify/$userId');

    _prefs!.setBool("watch", response.chartdata['watchAccess']);
    _prefs!.setBool("hentai", response.chartdata['hentaiAccess']);
    _prefs!.setString("xp", response.chartdata['xp'].toString());
    _prefs!.setString("day", response.chartdata['day'].toString());

    if (response.chartdata['hasNotification'] == true) {
      _prefs!.setBool("hasNotification", true);
    } else {
      _prefs!.setBool("hasNotification", false);
    }
  }
}
