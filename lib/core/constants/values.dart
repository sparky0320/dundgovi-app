import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:move_to_earn/core/constants/util.dart';

String baseUrl = '';
String endPoint = '';
String version = '';
String pendingVersion = '';
String applink = '';
String selectedLocale1 = '';
// bool isDev = false;

//version
String appVersion = '';

Color mainBlue = Util.fromHex("#1769FF");
Color mainDeActiveBlue = Util.fromHex("#549DFF");
Color mainBlueShadow = Util.fromHex("#95C2FF");
Color mainBlack = Util.fromHex("#292D32");
Color mainWhite = Util.fromHex("#FFFFFF");
Color mainYellow = Util.fromHex("#FFC457");
Color mainGreenDark = Util.fromHex("#158778");

Color mainBackLine = Util.fromHex("#F2F2F2");
Color mainGreyColor = Util.fromHex("#8C95B0");
Color mainLightPinkColor = Util.fromHex("#FF7F7E");

Color lineColor = Util.fromHex("#F2F2F2");
Color greyIndicator = Util.fromHex("#D9D9D9");
Color secondBlue = Util.fromHex("#0044C2");
Color textGrey = Util.fromHex("#CECECE");

/// new
Color mainBgColor = Util.fromHex("#3F3356");
Color mainPurple = Util.fromHex("#5E20BF");
Color mainPurpleBack = Util.fromHex("#584A73");
Color mainGreen = Util.fromHex("#5DC9D2");
Color mainGrey = Util.fromHex("#8A8D9F");
Color mainTextBlack = Util.fromHex("#27314F");
Color mainRed = Util.fromHex("#FF7F7E");
Color mainGreyBorder = Util.fromHex("#ECEEF2");
Color mainIconDarkGrey = Util.fromHex("#6A6A6A");
Color mainFavRed = Util.fromHex("#FF5857");
Color mainBorderGrey = Util.fromHex("#EEEEEE");
Color textBlack = Util.fromHex("#3E3E3E");
Color textGreyColor = Util.fromHex("#B1B1B1");
Color shadowColor = Util.fromHex("#D2D8DF");
Color mainLightGreen = Util.fromHex("#FFF7DF");
Color introOneColor = Util.fromHex("#F3F4FB");
Color introTwoColor = Util.fromHex("#F4F1F4");

///mnew  color
Color mainGreenColor = Util.fromHex("#37E16A");
Color mainLightGreenColor = Util.fromHex("#37E1BE");
Color mainTotalGreen = Util.fromHex("#C9EEBA");
Color mainVerifiedGreen = Util.fromHex("#1DBF73");

Color addButtonGreen = Util.fromHex("#50D1CB");
Color addButtonBorder = Util.fromHex("#1CAE81");
Color mainBtnRedColor = Util.fromHex("#FF3B3B");
Color mainBtnGreyColor = Util.fromHex("#DFDFDF");

Color borderSmoothGreyColor = Util.fromHex("#A4ABC0");

var numberFormat = NumberFormat.currency(name: '₮ ', decimalDigits: 0);
var dollarFormat = NumberFormat.currency(name: '\$', decimalDigits: 0);
var numberFormatDouble = NumberFormat.currency(name: '₮ ', decimalDigits: 2);

String versionCode = "1";
bool hideForIos = false;
bool showAd = true;
bool miniappIsHidden = true;
bool badgeIsHidden = true;
int? stepgoal1;
int? stepgoal2;
int? stepgoal3;
String? feedbackLink;
String? policyLink;
String? faqLink;
String? feedbackLinkEn;
String? policyLinkEn;
String? faqLinkEn;
String? feedbackLinkRu;
String? policyLinkRu;
String? faqLinkRu;
String? specialCouponImage;

List stepsDayBefore = [
  {"value": "2000-с доош", "steps_id": 1},
  {"value": "2000 - 4000", "steps_id": 2},
  {"value": "4000 - 6000", "steps_id": 3},
  {"value": "6000 - 8000", "steps_id": 4},
  {"value": "8000 - 10`000", "steps_id": 5},
  {"value": "10`000-с дээш", "steps_id": 6}
];

Size resSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double resHeight(BuildContext context) {
  return resSize(context).height;
}

double resWidth(BuildContext context) {
  return resSize(context).width;
}
