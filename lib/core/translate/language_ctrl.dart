import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/models/language_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  Locale currentLocale = Locale('mn', '');

  NetworkUtil _netUtil = new NetworkUtil();
  List<LanguageModel> langList = [];
  bool langLoading = true;
  int? selectedLang;
  // @override
  // void onInit() {
  //   super.onInit();
  //   readLocale();
  // }

  Future<void> changeLocale(Locale locale) async {
    _netUtil.setHeader(selectedLang);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await Get.updateLocale(locale);
    await prefs.setString('locale', locale.languageCode);
    await readLocale();
    update();
  }

  Future<void> readLocale({bool setLocale = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? locale = prefs.getString("locale");

    if (locale != null) {
      currentLocale = Locale(locale, '');
      setSelectedLang(Locale(locale, ''));
      update();
    }
    if (setLocale) {
      changeLocale(currentLocale);
    }
    update();
  }

  Future getLanguages() async {
    langList = [];
    langLoading = true;
    update();
    try {
      final response = await _netUtil.get(
        endPoint + '/api/v1/locale/get-languages',
      );
      if (response != null && response['status'] == true) {
        for (var item in response['data']) {
          langList.add(LanguageModel.fromJson(item));
        }
        selectedLang = langList.first.id;
        readLocale();
      }
      _netUtil.setHeader(selectedLang);
      langLoading = false;
      update();
    } catch (e) {
      print(e);
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  setSelectedLang(Locale locale) async {
    print('locale -------- $locale');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedLocaleLast', '$locale');
    if (locale == Locale('mn', '')) {
      selectedLang = 1;
      selectedLocale1 = 'mn';
    } else if (locale == Locale('ru', '')) {
      selectedLang = 2;
      selectedLocale1 = 'ru';
    } else if (locale == Locale('en', '')) {
      selectedLang = 3;
      selectedLocale1 = 'en';
    }
    _netUtil.setHeader(selectedLang);
    update();
  }
}
