import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/app_controller.dart';
import 'package:move_to_earn/core/models/challenge/challenge_model.dart';
import 'package:move_to_earn/core/models/invite_model.dart';
import 'package:move_to_earn/main.dart';
import 'package:nb_utils/nb_utils.dart';

class ChallengeController extends GetxController {
  NetworkUtil _netUtil = Get.find();
  List<ChallengeModel> challenges = [];
  List<ChallengeModel> myChallenges = [];
  // List<ChallengeListModel> challengesList = [];
  AppController appController = Get.find();
  bool loading = false;
  List<dynamic> scoreBoard = [];
  List<dynamic> myScoreBoard = [];
  bool scoreLoading = false;
  List<InviteListModel> invites = [];
  int lastPage = 1;
  int page = 1;
  int? rankScore;

  Future<bool> getChallengesListMy(page) async {
    loading = true;
    myChallenges = [];
    try {
      final response = await _netUtil.get(
          endPoint +
              '/api/v1/get-all-my-challanges/${appController.user.value.id}',
          params: {'page': page, 'is_darkhan': appController.isDarkhan});
      if (response != null && response['status'] == true) {
        for (var item in response['data']['data']) {
          myChallenges.add(ChallengeModel.fromJson(item));
        }
        lastPage = response['data']['last_page'];
      }

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
      loading = false;
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
    loading = false;
    update();
    return loading;
  }

  Future<bool> getChallengesList(page, type) async {
    try {
      if (type == 3) {
        print('Api ajillahgui');
      } else {
        loading = true;
        // challenges = [];

        if (type == 2) {
          challenges = [];
        }
        final response = await _netUtil.get(
            // 'http://192.168.1.63:3000/api/v1/get-all-challanges/${appController.user.value.id}',
            endPoint + '/api/v1/get-all-challanges/${appController.user.value.id}',
            params: {'page': page, 'is_darkhan': appController.isDarkhan});
        if (response['status'] == true) {
          for (var item in response['data']['data']) {
            challenges.add(ChallengeModel.fromJson(item));
          }
          lastPage = response['data']['last_page'];
        }
        loading = false;
        print(response);
        // if (response == null || response is String) {
        // Get.defaultDialog(
        //     title: "alert_internet_shalgana_uu".tr,
        //     content: OutlinedButton(
        //       style: OutlinedButton.styleFrom(
        //         backgroundColor: ColorConstants.primaryColor1,
        //         shape: StadiumBorder(),
        //         side: BorderSide(width: 2, color: Colors.white),
        //       ),
        //       onPressed: () {
        //         agentController.logout();
        //         appController.logout();
        //         appController.setUser(null);
        //         main();
        //       },
        //       child: Text(
        //         'Дахин ачааллах',
        //         style: TextStyle(color: white),
        //       ),
        //     ),
        //     barrierDismissible: false);
        // }

        update();
      }
      // return loading;
    } catch (e) {
      loading = false;
      // update();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
      return loading;
    }
    // loading = false;
    update();
    return loading;
  }

  Future getChallenges() async {
    loading = true;
    challenges = [];
    try {
      final response = await _netUtil.get(endPoint + '/api/v1/challenge',
          // final response = await _netUtil.get(baseUrl + '/api/challenge',
          params: {'user_id': appController.user.value.id});
      // print('challenge result ----$response');
      if (response != null && response['status'] == true) {
        for (var item in response['data']) {
          challenges.add(ChallengeModel.fromJson(item));
        }
      }
      loading = false;
      update();
      // print(challenges);
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

  // Future<ChallengeModel> getChallenge(index) async {
  //   if (challengesList.length > 0 && challengesList.length > index)
  //     return challengesList[index];
  // }

  Future joinChallenge(ChallengeModel challenge) async {
    loading = true;
    var response;
    try {
      // response = await _netUtil.post(endPoint + '/api/v1/challenge/join', {
      response = await _netUtil.post(baseUrl + '/api/challenge/join', {
        'challenge_id': challenge.id,
        'user_id': appController.user.value.id,
      });
      print('---------------------------------join ${response}');
      if (response != null && response['status'] == true) {
        challenge.joined = true;

        if (challenge.userCount != null) {
          challenge.userCount = challenge.userCount! + 1;
        } else {
          challenge.userCount = 1;
        }
      }
    } catch (e) {}
    loading = false;
    appController.getPoint();
    update();
    return response;
  }

  Future exitChallenge(ChallengeModel challenge) async {
    loading = true;
    var response;
    try {
      // response = await _netUtil.post(endPoint + '/api/v1/challenge/exit', {
      response = await _netUtil.post(baseUrl + '/api/challenge/exit', {
        'challenge_id': challenge.id,
        'user_id': appController.user.value.id,
      });
      if (response != null && response['status'] == true) {
        challenge.joined = true;
        if (challenge.userCount != null) {
          challenge.userCount = challenge.userCount! - 1;
        } else {
          challenge.userCount = 1;
        }
      }
    } catch (e) {}
    loading = false;
    appController.getPoint();
    update();
    return response;
  }

  Future getScoreBoard(ChallengeModel challenge) async {
    scoreLoading = true;

    scoreBoard = [];
    try {
      final response = await _netUtil.post(
          baseUrl + '/api/challenge/score-board',
          {'challenge_id': challenge.id});
      if (response != null && response['status'] == true) {
        scoreBoard = response['data']['data'];
      }
      scoreLoading = false;

      update();
    } catch (e) {
      scoreLoading = false;
      update();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  Future getMyScoreBoard(ChallengeModel challenge) async {
    scoreLoading = true;

    myScoreBoard = [];

    try {
      final response =
          await _netUtil.post(baseUrl + '/api/challenge/my-score-board', {
        'challenge_id': challenge.id,
        'user_id': appController.user.value.id,
      });
      if (response != null && response['status'] == true) {
        myScoreBoard = response['data'];
        rankScore = response['index'];
      }
      scoreLoading = false;

      update();
    } catch (e) {
      scoreLoading = false;
      update();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  Future<dynamic> getChallengeScore(ChallengeModel challenge) async {
    scoreLoading = true;

    var result;
    try {
      final response = await _netUtil.post(
          baseUrl + '/api/challenge/user-score', {
        'challenge_id': challenge.id,
        'user_id': appController.user.value.id
      });
      if (response != null &&
          response['status'] == true &&
          response['data'] != null) {
        result = response['data'];
      }
      scoreLoading = false;
      update();
    } catch (e) {
      scoreLoading = false;
      update();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }

    return result;
  }

  Future<List<dynamic>?> getChallengeScoreDetail(
      ChallengeModel challenge) async {
    var result;
    try {
      final response = await _netUtil.post(
          baseUrl + '/api/challenge/user-score-detail', {
        'challenge_id': challenge.id,
        'user_id': appController.user.value.id
      });
      if (response != null &&
          response['status'] == true &&
          response['data'] != null) {
        result = response['data'];
      }

      return result;
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }

    return result;
  }

  Future getInvites(ChallengeModel challenge) async {
    // loading = true;
    invites = [];
    try {
      final response = await _netUtil.post('/api/challenge/invited-user', {
        "userId": appController.user.value.id,
        "challenge_id": challenge.id
      });

      if (response != null && response['status'] == true) {
        for (var item in response['data']) {
          invites.add(InviteListModel.fromJson(item));
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
}
