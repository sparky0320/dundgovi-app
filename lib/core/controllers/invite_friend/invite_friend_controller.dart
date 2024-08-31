import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/models/invite_model.dart';

class InviteFriendCtrl extends GetxController {
  bool loading = true;
  String title = '';
  String shareText = 'N/A';
  int? code;
  bool isClicked = false;

  NetworkUtil _netUtil = NetworkUtil();
  List<InviteListModel> inviteApprovedList = [];
  Future getInvite() async {
    loading = true;
    inviteApprovedList = [];
    try {
      final response = await _netUtil.get(
          endPoint + '/api/v1/invite/get-data/${appController.user.value.id}');
      if (response != null && response['status'] == true) {
        title = response['data']['title'];
        shareText = response['data']['shareText'];
        code = response['data']['invite_code'];
        for (var item in response['data']['invites']) {
          inviteApprovedList.add(InviteListModel.fromJson(item));
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
}
