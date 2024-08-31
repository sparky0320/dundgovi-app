import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/authentication/get_info_controller.dart';
import 'package:move_to_earn/core/translate/language_ctrl.dart';
import 'package:move_to_earn/ui/component/buttons/gradient_button_small.dart';
import 'package:move_to_earn/ui/views/signup/info_screen.dart';
import '../../../core/constants/colors.dart';
import '../../../core/models/model_name_input.dart';
import '../../component/inputs/name_pass_input.dart';

class PrivateInfoPage extends StatefulWidget {
  // final PageController? pageController;
  final InfoScreenState? infoScreenState;
  final GetInfoController ctrl;
  final String email;

  const PrivateInfoPage({
    Key? key,
    this.infoScreenState,
    // this.pageController,
    required this.ctrl,
    required this.email,
  }) : super(key: key);

  @override
  State<PrivateInfoPage> createState() => _PrivateInfoPageState();
}

class _PrivateInfoPageState extends State<PrivateInfoPage> {
  bool btnActiveFirstName = false;
  bool btnActiveLastName = false;
  LanguageController languageController = Get.find();
  bool btnActiveNumber = false;
  bool isPhone = false;

  @override
  void initState() {
    super.initState();
    widget.ctrl.firstName.clear();
    widget.ctrl.lastName.clear();
    widget.ctrl.phone.clear();
  }

  @override
  Widget build(BuildContext context) {
    var fullHeight = MediaQuery.of(context).size.height;
    return GetBuilder<GetInfoController>(
      init: widget.ctrl,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            // Hide the keyboard when tapped outside the text input area
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            margin: EdgeInsets.only(top: fullHeight * 0.04),
            // margin: EdgeInsets.only(top: inputPaddingTop.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    // User last name
                    NamePassInput(
                      model: InputModel(
                        inputType: TextInputType.name,
                        maxLength: 20,
                        onChanged: (value) {
                          setState(() {
                            btnActiveLastName =
                                value.length >= 2 ? true : false;
                          });
                        },
                        controller: widget.ctrl.lastName,
                        hintText: 'pep_owog'.tr,
                        prefixIcon: Icons.account_circle,
                      ),
                    ),

                    SizedBox(height: 20.w),

                    // User first name
                    NamePassInput(
                      model: InputModel(
                        inputType: TextInputType.name,
                        maxLength: 20,
                        onChanged: (value) {
                          setState(() {
                            btnActiveFirstName =
                                value.length >= 2 ? true : false;
                          });
                        },
                        controller: widget.ctrl.firstName,
                        hintText: 'rp_name'.tr,
                        prefixIcon: Icons.account_circle,
                      ),
                    ),

                    SizedBox(height: 20.w),

                    // Phone number
                    NamePassInput(
                      model: InputModel(
                        inputType: TextInputType.number,
                        maxLength: 8,
                        onChanged: (value) {
                          value.length == 8
                              ? FocusScope.of(context).unfocus()
                              : SizedBox();
                          setState(
                            () {
                              btnActiveNumber =
                                  value.length >= 7 ? true : false;
                              isPhone = RegExp(r'^[6,7,8,9]([0-9]{7})$')
                                      .hasMatch(value)
                                  ? true
                                  : false;
                            },
                          );
                        },
                        controller: widget.ctrl.phone,
                        hintText: 'r2_utasnii_dugaar'.tr,
                        prefixIcon: Icons.phone_iphone_outlined,
                      ),
                    ),

                    // SizedBox(height: 10.w),

                    // // Enter birthday field
                    // Container(
                    //   height: 60.w,
                    //   width: 350.w,
                    //   child: GestureDetector(
                    //     onTap: () async {
                    //       DateTime? pickedDate = await showDatePicker(
                    //         context: context,
                    //         locale: languageController.currentLocale,
                    //         initialDate: DateTime.parse(
                    //           ctrl.selectedDate != null
                    //               ? ctrl.selectedDate!
                    //               : DateTime.now().toString(),
                    //         ),
                    //         //get today's date
                    //         firstDate: DateTime(1910),
                    //         //DateTime.now() - not to allow to choose before today.
                    //         lastDate: DateTime.now(),
                    //       );
                    //       if (pickedDate != null) {
                    //         String formattedDate =
                    //             DateFormat("yyyy-MM-dd").format(pickedDate);
                    //         ctrl.selectedDate = formattedDate.toString();
                    //         ctrl.update();
                    //       } else {
                    //         print("selected date");
                    //       }
                    //     },
                    //     child: Container(
                    //       width: double.infinity,
                    //       padding: EdgeInsets.only(
                    //           top: 6.h, right: 12.w, left: 15.w, bottom: 10.h),
                    //       decoration: BoxDecoration(
                    //         color:
                    //             ColorConstants.neutralColor5.withOpacity(0.7),
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(inputRadius.w),
                    //         ),
                    //       ),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             'rp_torson_ognoo'.tr,
                    //             style: TextStyle(
                    //               fontSize: 10.sp,
                    //               color: Util.fromHex("#A5A5A5"),
                    //             ),
                    //           ),
                    //           SizedBox(height: 4.h),
                    //           Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text(
                    //                 ctrl.selectedDate ?? 'rp_torson_odor'.tr,
                    //                 style: TextStyle(
                    //                   fontSize: 16.sp,
                    //                   fontWeight: FontWeight.w400,
                    //                   color: ctrl.selectedDate != null
                    //                       ? Colors.white
                    //                       : mainGrey,
                    //                 ),
                    //               ),
                    //               Icon(
                    //                 Icons.keyboard_arrow_down_rounded,
                    //                 color: mainGrey,
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // SizedBox(height: 10.w),

                    // //Select gender
                    // Container(
                    //   height: 60.w,
                    //   width: 350.w,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       selectGender(context);
                    //     },
                    //     child: Container(
                    //       padding: EdgeInsets.only(
                    //           top: 6.h, right: 12.w, left: 15.w, bottom: 10.h),
                    //       decoration: BoxDecoration(
                    //         color:
                    //             ColorConstants.neutralColor5.withOpacity(0.7),
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(inputRadius.w),
                    //         ),
                    //       ),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             'rp_hvis'.tr,
                    //             style: TextStyle(
                    //                 fontSize: 10.sp,
                    //                 color: Util.fromHex("#A5A5A5")),
                    //           ),
                    //           SizedBox(height: 4.h),
                    //           Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text(
                    //                 ctrl.selectedGender == ''
                    //                     ? 'rp_hvis'.tr
                    //                     : ctrl.selectedGender == 'm'
                    //                         ? 'rp_eregtei'.tr
                    //                         : 'rp_emegtei'.tr,
                    //                 style: TextStyle(
                    //                     fontSize: 16.sp,
                    //                     fontWeight: FontWeight.w400,
                    //                     color: ctrl.selectedGender == ''
                    //                         ? mainGrey
                    //                         : Colors.white),
                    //               ),
                    //               Icon(
                    //                 Icons.keyboard_arrow_down_rounded,
                    //                 color: mainGrey,
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // SizedBox(height: 10.w),

                    // // enter height field
                    // Container(
                    //   child: NamePassInput(
                    //     model: InputModel(
                    //       inputType: TextInputType.number,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           isHeight = value.length >= 2 ? true : false;
                    //         });
                    //       },
                    //       maxLength: 3,
                    //       controller: ctrl.height,
                    //       hintText: "rp_ondor".tr,
                    //       prefixIcon: Icons.height,
                    //     ),
                    //   ),
                    // ),

                    // SizedBox(height: 10.w),
                    // // enter weight field
                    // Container(
                    //   child: NamePassInput(
                    //     model: InputModel(
                    //       inputType: TextInputType.number,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           isWeight = value.length >= 2 ? true : false;
                    //         });
                    //       },
                    //       maxLength: 3,
                    //       controller: ctrl.weight,
                    //       hintText: "rp_jin".tr,
                    //       prefixIcon: Icons.line_weight_rounded,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: fullHeight * 0.08,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: GradientButtonSmall(
                    isShadow: false,
                    textColor: mainWhite,
                    isBorder: btnActiveLastName &&
                            btnActiveFirstName &&
                            btnActiveNumber &&
                            isPhone
                        ? false
                        : true,
                    text: 'rp_vrgeljlvvleh'.tr,
                    color1: btnActiveLastName &&
                            btnActiveFirstName &&
                            btnActiveNumber &&
                            isPhone
                        ? ColorConstants.buttonGradient2
                        : Colors.transparent,
                    color2: btnActiveLastName &&
                            btnActiveFirstName &&
                            btnActiveNumber &&
                            isPhone
                        ? ColorConstants.buttonGradient1
                        : Colors.transparent,
                    onPressed: () async {
                      if (btnActiveFirstName == false) {
                        if (!Get.isSnackbarOpen) {
                          Get.snackbar(
                            "",
                            "",
                            icon: Icon(
                              Iconsax.warning_2,
                              color: Colors.yellow,
                              size: 32.sp,
                            ),
                            snackPosition: SnackPosition.TOP,
                            titleText: Text(
                              'r2_talbariig_gvitsed_boglono_vv'.tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            messageText: Text(
                              'r2_neree_oruulna_uu'.tr,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 12.sp),
                            ),
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                          );
                        }
                      } else if (btnActiveLastName == false) {
                        if (!Get.isSnackbarOpen) {
                          Get.snackbar(
                            "",
                            "",
                            icon: Icon(
                              Iconsax.warning_2,
                              color: Colors.yellow,
                              size: 32.sp,
                            ),
                            snackPosition: SnackPosition.TOP,
                            titleText: Text(
                              'r2_talbariig_gvitsed_boglono_vv'.tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            messageText: Text(
                              'r2_ovog_oruulna_uu'.tr,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 12.sp),
                            ),
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                          );
                        }
                      } else if (btnActiveNumber == false) {
                        if (!Get.isSnackbarOpen) {
                          Get.snackbar(
                            "",
                            "",
                            icon: Icon(
                              Iconsax.warning_2,
                              color: Colors.yellow,
                              size: 32.sp,
                            ),
                            snackPosition: SnackPosition.TOP,
                            titleText: Text(
                              'r2_talbariig_gvitsed_boglono_vv'.tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            messageText: Text(
                              'r2_utasnii_dugaar_olruulnuu'.tr,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 12.sp),
                            ),
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                          );
                        }
                      } else if (isPhone == false) {
                        if (!Get.isSnackbarOpen) {
                          Get.snackbar(
                            "",
                            "",
                            icon: Icon(
                              Iconsax.warning_2,
                              color: Colors.yellow,
                              size: 32.sp,
                            ),
                            snackPosition: SnackPosition.TOP,
                            titleText: Text(
                              "r2_utasnii_dugaar_buruu_baina".tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            messageText: Text(
                              'r2_utasnii_dugaar_zow_olruulnuu'.tr,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 12.sp),
                            ),
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                          );
                        }
                      } else {
                        widget.ctrl.getInfo(context, widget.email);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
