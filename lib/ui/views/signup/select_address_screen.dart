import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/controllers/authentication/get_info_controller.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/views/signup/info_screen.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/values.dart';
import '../../component/buttons/gradient_button_small.dart';

class SelectAddress extends StatefulWidget {
  final bool? isBack;
  final PageController? pageController;
  final GetInfoController? ctrl;
  final Function? updatevalue;
  final Function? pageNum;
  final bool? isEdit;

  const SelectAddress({
    super.key,
    required InfoScreenState infoScreenState,
    this.isBack = false,
    this.ctrl,
    this.updatevalue,
    this.pageNum,
    this.pageController,
    this.isEdit,
  });

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  List<dynamic> _sumDuureg = [];
  String? selectedAimag;
  String? selectedSum;
  bool isAimagSelected = false;

  @override
  void initState() {
    super.initState();

    selectedAimag = widget.ctrl!.aimagList[0].name;
    for (var i = 0; i < widget.ctrl!.sumDuuregList.length; i++) {
      if (widget.ctrl!.sumDuuregList[i].aimagId == 1) {
        _sumDuureg.add(widget.ctrl!.sumDuuregList[i]);
        selectedSum = _sumDuureg[0].name;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var fullHeight = MediaQuery.of(context).size.height;
    var fullWidth = MediaQuery.of(context).size.width;

    return GetBuilder<GetInfoController>(
        init: widget.ctrl,
        builder: (logic) {
          return Stack(
            children: [
              if (widget.isEdit == true) BackColor(),
              Container(
                height: fullHeight,
                width: fullWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: fullHeight * 0.04),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        "Та хаана амьдардаг вэ?",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: mainWhite,
                          fontSize: 30.sp,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.h),
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Text(
                        "Тухайн байршилд зохиогдож буй тэмцээнийг харуулна",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: mainWhite.withOpacity(0.7),
                          fontSize: 18.sp,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(
                        left: 50.w,
                        right: 50.w,
                        top: 20.h,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: mainGrey, width: 1.5),
                        color: ColorConstants.progressBackgroundColor
                            .withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Аймаг, Хот",
                            style: TextStyle(
                              color: mainWhite,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Container(
                            height: 23.h,
                            child: VerticalDivider(
                              color: mainGrey,
                              width: 1,
                              thickness: 1,
                            ),
                          ),
                          Text(
                            "Сум, Дүүрэг",
                            style: TextStyle(
                              color: mainWhite,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),

                    _aimagSelector(fullHeight),

                    // button
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: fullHeight * 0.08,
                        ),
                        alignment: Alignment.bottomCenter,
                        child: GradientButtonSmall(
                            isShadow: false,
                            text: 'rp_vrgeljlvvleh'.tr,
                            textColor: mainWhite,
                            color1: ColorConstants.buttonGradient2,
                            color2: ColorConstants.buttonGradient1,
                            onPressed:
                                // widget.onTap,
                                () async {
                              print("object");
                              if (widget.isEdit == true) {
                                var aimagSum = {
                                  "aimag": selectedAimag!,
                                  "sum": selectedSum!,
                                };

                                Navigator.pop(context, aimagSum);
                              } else {
                                setState(() {
                                  widget.updatevalue!(0.84);
                                  widget.pageNum!(6);
                                });

                                widget.ctrl!.aimagHot = selectedAimag;
                                widget.ctrl!.sumDuureg = selectedSum;

                                widget.pageController!.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  _aimagSelector(double fullHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(bottom: fullHeight * 0.06),
                  child: Image.asset(
                    "assets/icon-png/ic_select_pointer.png",
                    color: mainWhite.withOpacity(0.8),
                  ),
                ),
              ),
              Container(
                width: 160.w,
                height: 300.h,
                child: CupertinoPicker(
                  useMagnifier: true,
                  magnification: 1.05,
                  looping: true,
                  selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                    background: const Color.fromARGB(0, 58, 13, 13),
                  ),
                  onSelectedItemChanged: (val) {
                    setState(
                      () {
                        for (var i = 0;
                            i < widget.ctrl!.aimagList.length;
                            i++) {
                          if (widget.ctrl!.aimagList[i].id == val + 1) {
                            selectedAimag = widget.ctrl!.aimagList[i].name;
                          }
                        }
                        // selectedAimagId = val - 1;
                        _sumDuureg = [];
                        for (var i = 0;
                            i < widget.ctrl!.sumDuuregList.length;
                            i++) {
                          if (widget.ctrl!.sumDuuregList[i].aimagId ==
                              val + 1) {
                            _sumDuureg.add(widget.ctrl!.sumDuuregList[i]);
                            selectedSum = _sumDuureg[0].name;
                          }
                        }
                      },
                    );
                  },
                  itemExtent: 75.0,
                  children: widget.ctrl!.aimagList.map((e) {
                    return Text(
                      e.name.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          color: Colors.white),
                    );
                  }).toList(),
                ),
              ),
              Container(
                width: 160.w,
                height: 300.h,
                child: CupertinoPicker(
                  useMagnifier: true,
                  magnification: 1.05,
                  looping: true,
                  selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                    background: Colors.transparent,
                  ),
                  onSelectedItemChanged: (val) {
                    setState(() {
                      for (var i = 0; i < _sumDuureg.length; i++) {
                        selectedSum = _sumDuureg[val].name;
                      }
                    });
                  },
                  itemExtent: 75.0,
                  children: _sumDuureg.map((e) {
                    return Text(
                      e.name.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          color: Colors.white),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
