const String imageAssetsRoot = "assets/images/";

final String bg3 = _getImagePath("bg3.png");
final String android = _getImagePath("and.png");
final String android2 = _getImagePath("and2.png");
final String iphone = _getImagePath("iphone.png");
final String apple = _getImagePath("apple.png");
final String playIcon = _getImagePath("play.png");
final String routeIcon = _getImagePath("route.png");
final String locationIcon = _getImagePath("location.png");

final String couponBg = _getImagePath('coupon_bg.png');
final String stepIcon = _getImagePath('step_icon.png');
final String scoreIcon = _getImagePath('score_icon.png');
String _getImagePath(String fileName) {
  return imageAssetsRoot + fileName;
}
