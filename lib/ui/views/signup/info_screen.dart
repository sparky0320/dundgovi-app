import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/ui/views/signup/enter_step_count.dart';
import 'package:move_to_earn/ui/views/signup/private_info_screen.dart';
import 'package:move_to_earn/ui/views/signup/select_address_screen.dart';
import 'package:move_to_earn/ui/views/signup/select_birthday_screen.dart';

import '../../../core/controllers/authentication/get_info_controller.dart';
import 'gender_screen.dart';
import 'height_screen.dart';
import 'weight_screen.dart';

class InfoScreen extends StatefulWidget {
  final String email;
  const InfoScreen({Key? key, required this.email}) : super(key: key);

  @override
  InfoScreenState createState() => InfoScreenState();
}

class InfoScreenState extends State<InfoScreen> {
  double? _updateValue;
  PageController pageController = new PageController();
  GetInfoController ctrl = Get.put(GetInfoController());
  bool isBack = false;
  late int pageNum;

  @override
  void initState() {
    super.initState();
    ctrl.getAimagList();
    ctrl.getSumDuuregList();

    pageNum = 1;
    _updateValue = 0.17;

    // Future.delayed(Duration(seconds: 1), () {
    //   showModalBottomSheet(
    //       context: context,
    //       isScrollControlled: true,
    //       backgroundColor: Colors.transparent,
    //       isDismissible: true,
    //       enableDrag: false,
    //       builder: (context) {
    //         return Wrap(
    //           children: [
    //             // WelcomeDialogScreen(),
    //           ],
    //         );
    //       });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hide the keyboard when tapped outside the text input area
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorConstants.backGradientColor1.withOpacity(0.9),
                ColorConstants.backGradientColor2,
                ColorConstants.backGradientColor3,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: _progressTopBar(),
                ),
                Flexible(
                  flex: 9,
                  child: new PageView(
                    onPageChanged: (pos) {
                      setState(() {
                        isBack = (pos != 0);
                      });
                    },
                    controller: pageController,
                    physics: new NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      GenderScreen(
                        pageController: pageController,
                        updatevalue: updateValue,
                        pageNum: updagePageNumber,
                        ctrl: ctrl,
                        infoScreenState: this,
                      ),
                      WeightScreen(
                        pageController: pageController,
                        updatevalue: updateValue,
                        isBack: isBack,
                        pageNum: updagePageNumber,
                        ctrl: ctrl,
                        infoScreenState: this,
                      ),
                      HeightScreen(
                        pageController: pageController,
                        updatevalue: updateValue,
                        pageNum: updagePageNumber,
                        ctrl: ctrl,
                        isBack: isBack,
                        infoScreenState: this,
                      ),
                      SelectBirthdayScreen(
                        pageController: pageController,
                        updatevalue: updateValue,
                        pageNum: updagePageNumber,
                        infoScreenState: this,
                        isBack: isBack,
                        ctrl: ctrl,
                      ),
                      SelectAddress(
                        pageController: pageController,
                        infoScreenState: this,
                        isBack: isBack,
                        pageNum: updagePageNumber,
                        updatevalue: updateValue,
                        ctrl: ctrl,
                        isEdit: false,
                      ),
                      EnterStepCount(
                        pageController: pageController,
                        infoScreenState: this,
                        pageNum: updagePageNumber,
                        updatevalue: updateValue,
                        isBack: isBack,
                        ctrl: ctrl,
                      ),
                      PrivateInfoPage(
                        ctrl: ctrl,
                        email: widget.email,
                        // pageController: pageController,
                        infoScreenState: this,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  updateValue(double progress) {
    setState(() {
      _updateValue = progress;
      if (_updateValue!.toStringAsFixed(1) == '1.2') {
        _updateValue = 0.0;
        return;
      }
    });
  }

  updagePageNumber(int newnum) {
    setState(() {
      pageNum = newnum;
    });
  }

  _progressTopBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: isBack,
            child: InkWell(
              onTap: () {
                if (pageController.hasClients) {
                  if (pageController.page!.round() == 0) {
                    setState(() {
                      isBack = false;
                    });
                  }
                  if (pageController.page!.round() != 0) {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                    updateValue(_updateValue! - 0.14);
                    updagePageNumber(pageNum - 1);
                  }
                }
              },
              child: Container(
                width: 50.w,
                height: 50.h,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          if (!isBack)
            Container(
              height: 50,
              width: 60,
            ),
          Expanded(
            child: UnconstrainedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: Container(
                  width: 100,
                  child: LinearProgressIndicator(
                    backgroundColor: ColorConstants.progressBackgroundColor,
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        mainWhite.withOpacity(0.8)),
                    minHeight: 8,
                    value: _updateValue,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(
              (pageNum).toString() + "/7",
              style: TextStyle(
                color: mainWhite,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
