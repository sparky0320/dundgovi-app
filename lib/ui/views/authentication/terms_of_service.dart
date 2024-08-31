import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/controllers/loading_circle.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import 'package:move_to_earn/ui/component/buttons/gradient_button_small.dart';
import 'package:move_to_earn/ui/component/headers/header_for_page.dart';
import 'package:move_to_earn/ui/views/signup/register_page.dart';
import '../../../core/constants/values.dart';
import '../../../core/controllers/authentication/terms_of_service_controller.dart';

class TermsOfService extends StatefulWidget {
  final bool view;

  const TermsOfService({
    Key? key,
    required this.view,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TermsOfService();
}

class _TermsOfService extends State<TermsOfService> {
  TermsOfServiceCtrl model = Get.put(TermsOfServiceCtrl());

  @override
  void initState() {
    super.initState();
    model.getTermsOfServiceData();
    print('view --- ${widget.view}');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TermsOfServiceCtrl>(
      init: model,
      builder: (logic) {
        return Scaffold(
          body: Stack(
            children: [
              BackColor(),
              AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: model.loading
                    ? Center(child: LoadingCircle())
                    : Column(
                        children: [
                          HeaderForPage(
                            backArrow: BackArrow(),
                            text: '',
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.h),
                              child: RawScrollbar(
                                radius: Radius.circular(12.r),
                                thickness: 4.w,
                                trackVisibility: true,
                                thumbVisibility: true,
                                thumbColor: Colors.purple[900],
                                trackColor: lineColor,
                                trackRadius: Radius.circular(12.r),
                                child: SingleChildScrollView(
                                    child: Html(
                                  data: model.termsOfService?.title != null
                                      ? model.termsOfService!.body
                                      : '',

                                  style: {
                                    // tables will have the below background color
                                    "h1": Style(
                                      color: Colors.white,
                                      textAlign: TextAlign.center,
                                    ),
                                    "p": Style(
                                      color: Colors.white,
                                      textAlign: TextAlign.justify,
                                      fontSize: FontSize.medium,
                                    ),
                                    "li": Style(
                                      color: Colors.white,
                                      textAlign: TextAlign.justify,
                                      fontSize: FontSize.medium,
                                    )
                                  },
                                  shrinkWrap: true,
                                  // onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, dom.Element? element) {
                                  //   model.launchWeb(url);
                                  // },
                                  // onImageTap: (src) {
                                  //   model.launchWeb(src);
                                  // },
                                )),
                              ),
                            ),
                          ),
                          widget.view == true
                              ? SizedBox()
                              : Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 24.h),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 18.h),
                                      InkWell(
                                        onTap: () {
                                          model.changeVal();
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              model.isChecked == false
                                                  ? Icons.circle_outlined
                                                  : Icons.check_circle,
                                              color: model.isChecked == false
                                                  ? textGrey
                                                  : Colors.white,
                                            ),
                                            SizedBox(width: 12.w),
                                            Text(
                                              'r1_vilchilgeenii_nohtsol_zowshooroh'
                                                  .tr,
                                              style: TextStyle(
                                                color: model.isChecked
                                                    ? Colors.white
                                                    : textGrey,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 24.h),
                                      GradientButtonSmall(
                                        text: "r1_zowshooroh".tr,
                                        isShadow: false,
                                        isBorder: model.isChecked == true
                                            ? false
                                            : true,
                                        color1: model.isChecked == true
                                            ? ColorConstants.buttonGradient2
                                            : Colors.transparent,
                                        color2: model.isChecked == true
                                            ? ColorConstants.buttonGradient1
                                            : Colors.transparent,
                                        textColor: mainWhite,
                                        onPressed: () {
                                          if (model.isChecked == false) {
                                            if (!Get.isSnackbarOpen) {
                                              Get.snackbar(
                                                "",
                                                "",
                                                icon: Icon(Iconsax.warning_2,
                                                    color: Colors.yellow,
                                                    size: 32.sp),
                                                snackPosition:
                                                    SnackPosition.TOP,
                                                titleText: Text(
                                                  'r1_vilchilgeenii_nohtsoliig_zowshoorno_vv'
                                                      .tr,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                messageText: Text(
                                                  'r1_zowshoorson_tohioldold_towch_idewhjene'
                                                      .tr,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12.sp),
                                                ),
                                                backgroundColor: Colors.white,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w,
                                                    vertical: 12.h),
                                              );
                                            }
                                          } else
                                            Get.to(
                                              () => const RegisterPage(),
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              transition: Transition
                                                  .rightToLeftWithFade,
                                            );
                                        },
                                      ),
                                      // LoginSignUpButton(
                                      //   model: ButtonModel(
                                      //     color1: model.isChecked == true
                                      //         ? ColorConstants.gradientColor1
                                      //         : Colors.transparent,
                                      //     color2: model.isChecked == true
                                      //         ? ColorConstants.gradientColor2
                                      //         : Colors.transparent,
                                      //     color3: model.isChecked == true
                                      //         ? ColorConstants.gradientColor3
                                      //         : Colors.transparent,
                                      //     color4: model.isChecked == true
                                      //         ? ColorConstants.gradientColor4
                                      //         : Colors.transparent,
                                      //     color5: model.isChecked == true
                                      //         ? ColorConstants.gradientColor5
                                      //         : Colors.transparent,
                                      //     borderColor: model.isChecked == true
                                      //         ? Colors.transparent
                                      //         : ColorConstants.neutralColor2,
                                      //     text: "r1_zowshooroh".tr,
                                      //     icon: "",
                                      //     textStyle: TTextTheme
                                      //         .lightTextTheme.bodySmall,
                                      //     getTo: () {
                                      //       if (model.isChecked == false) {
                                      //         if (!Get.isSnackbarOpen) {
                                      //           Get.snackbar(
                                      //             "",
                                      //             "",
                                      //             icon: Icon(Iconsax.warning_2,
                                      //                 color: Colors.yellow,
                                      //                 size: 32.sp),
                                      //             snackPosition:
                                      //                 SnackPosition.TOP,
                                      //             titleText: Text(
                                      //               'r1_vilchilgeenii_nohtsoliig_zowshoorno_vv'
                                      //                   .tr,
                                      //               style: TextStyle(
                                      //                   color: Colors.black,
                                      //                   fontSize: 16.sp,
                                      //                   fontWeight:
                                      //                       FontWeight.w500),
                                      //             ),
                                      //             messageText: Text(
                                      //               'r1_zowshoorson_tohioldold_towch_idewhjene'
                                      //                   .tr,
                                      //               style: TextStyle(
                                      //                   color: Colors.grey,
                                      //                   fontSize: 12.sp),
                                      //             ),
                                      //             backgroundColor: Colors.white,
                                      //             padding: EdgeInsets.symmetric(
                                      //                 horizontal: 16.w,
                                      //                 vertical: 12.h),
                                      //           );
                                      //         }
                                      //       } else
                                      //         Get.to(
                                      //           () => const RegisterPage(),
                                      //           duration: const Duration(
                                      //               milliseconds: 500),
                                      //           transition: Transition
                                      //               .rightToLeftWithFade,
                                      //         );
                                      //     },
                                      //   ),
                                      // ),
                                      SizedBox(height: 24.h),
                                    ],
                                  ),
                                ),
                        ],
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
