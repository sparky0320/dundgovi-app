import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';

class AdsController extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-8500838700347205/2677141632";

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            log("AD LOADED");
          },
          onAdFailedToLoad: (ad, error) {
            isAdLoaded.value = false;
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.small));
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}
