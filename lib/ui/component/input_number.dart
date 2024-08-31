import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:move_to_earn/core/controllers/input_number_ctrl.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';

// ignore: must_be_immutable
class InputNumberScreen extends StatefulWidget {
  // TextEditingController controller;
  String? code;
  Function? onChanged;
  Function? onCompleted;
  int? maxLength;

  InputNumberScreen(
      {Key? key,
      // this.controller,
      this.code,
      this.onChanged,
      this.maxLength,
      this.onCompleted})
      : super(key: key);

  @override
  InputNumberScreenState createState() => InputNumberScreenState();
}

class InputNumberScreenState extends State<InputNumberScreen> {
  InputNumberController ctrl = Get.put(InputNumberController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputNumberController>(
      init: ctrl,
      builder: (logic) {
        return Stack(
          children: [
            BackColor(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ctrl.addNumber(1, widget.onChanged,
                                widget.onCompleted, widget.maxLength);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "1",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ctrl.addNumber(2, widget.onChanged,
                                widget.onCompleted, widget.maxLength);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "2",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ctrl.addNumber(3, widget.onChanged,
                                widget.onCompleted, widget.maxLength);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "3",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ctrl.addNumber(4, widget.onChanged,
                                widget.onCompleted, widget.maxLength);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "4",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ctrl.addNumber(5, widget.onChanged,
                                widget.onCompleted, widget.maxLength);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "5",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ctrl.addNumber(6, widget.onChanged,
                                widget.onCompleted, widget.maxLength);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "6",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ctrl.addNumber(7, widget.onChanged,
                                widget.onCompleted, widget.maxLength);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "7",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ctrl.addNumber(8, widget.onChanged,
                                widget.onCompleted, widget.maxLength);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "8",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ctrl.addNumber(9, widget.onChanged,
                                widget.onCompleted, widget.maxLength);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "9",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ctrl.addNumber(0, widget.onChanged,
                                widget.onCompleted, widget.maxLength);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "0",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ctrl.erase(widget.onChanged);
                          },
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 19.5),
                              child: Icon(
                                Iconsax.tag_cross,
                                size: 26.sp,
                                color: Colors.white54,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ],
        );
      },
    );
  }
}
