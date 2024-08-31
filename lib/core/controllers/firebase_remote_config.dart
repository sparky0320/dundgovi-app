import 'dart:io';
import 'package:move_to_earn/core/constants/util.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferebool? boolnces/shared_preferences.dart';

Future FireBaseRemoteConfig(isDev) async {
  // final prefs = await SharedPreferences.getInstance();

  try {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 0),
      minimumFetchInterval: const Duration(seconds: 0),
    ));
    await remoteConfig.fetchAndActivate();
    showAd = remoteConfig.getBool("show_ad");

    baseUrl = remoteConfig.getString("baseUrl");
    if (isDev == true) {
      baseUrl = remoteConfig.getString("baseUrl_dev");
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("baseUrl", baseUrl);
    stepgoal1 = remoteConfig.getInt("stepgoal_1");
    stepgoal2 = remoteConfig.getInt("stepgoal_2");
    stepgoal3 = remoteConfig.getInt("stepgoal_3");

    feedbackLinkEn = remoteConfig.getString("feedbackLink_en");
    policyLinkEn = remoteConfig.getString("policyLink_en");
    faqLinkEn = remoteConfig.getString("faqLink_en");
    feedbackLinkRu = remoteConfig.getString("feedbackLink_ru");
    policyLinkRu = remoteConfig.getString("policyLink_ru");
    faqLinkRu = remoteConfig.getString("faqLink_ru");
    feedbackLink = remoteConfig.getString("feedbackLink");
    policyLink = remoteConfig.getString("policyLink");
    faqLink = remoteConfig.getString("faqLink");
    specialCouponImage = remoteConfig.getString("specialcoupon_image");
    endPoint = remoteConfig.getString("endPoint");
    badgeIsHidden = remoteConfig.getBool("badge_ishidden");
    // print(baseUrl);

    Util.initVersion();

    if (Platform.isAndroid) {
      applink = remoteConfig.getString("app_link_android");
      version = remoteConfig.getString("version_android");
      pendingVersion = remoteConfig.getString("pending_version_android");
      miniappIsHidden = remoteConfig.getBool("miniapp_ishidden_android");
    } else {
      applink = remoteConfig.getString("app_link_ios");
      version = remoteConfig.getString("version_ios");
      pendingVersion = remoteConfig.getString("pending_version_ios");
      miniappIsHidden = remoteConfig.getBool("miniapp_ishidden_ios");
    }
  } catch (e) {
    print('Error fetching remote config: $e');
    // Handle error here
  }
}
