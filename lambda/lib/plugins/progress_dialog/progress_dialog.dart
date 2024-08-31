import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lambda/utils/hexColor.dart';

String _dialogMessage = "Loading...";

enum ProgressDialogType { Normal, Download, Success, Error, Loading }

ProgressDialogType _progressDialogType = ProgressDialogType.Normal;
double _progress = 0.0;

bool _isShowing = false;

class ProgressDialog {
  _MyDialog? _dialog;

  BuildContext? _buildContext;
  BuildContext? _context;

  ProgressDialog(
      BuildContext buildContext, ProgressDialogType progressDialogtype) {
    _buildContext = buildContext;
    _progressDialogType = progressDialogtype;
  }

  void setMessage(String mess) {
    _dialogMessage = mess;
  }

  void update({double? progress, String? message, String? type}) {
    if (_progressDialogType == ProgressDialogType.Download) {
      _progress = progress ?? 0;
    }

    if (type == 'success') {
      _progressDialogType = ProgressDialogType.Success;
    }
    if (type == 'error') {
      _progressDialogType = ProgressDialogType.Error;
    }

    _dialogMessage = message ?? "";
    print('working until here');
    _dialog?.update();
  }

  bool isShowing() {
    return _isShowing;
  }

  void hide() {
    _isShowing = false;
    _progressDialogType = ProgressDialogType.Normal;
    if (_context != null) {
      Navigator.of(_context!).pop();
    }
  }

  void show() {
    _dialog = new _MyDialog();
    _isShowing = true;

    showDialog<dynamic>(
      context: _buildContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        _context = context;
        return Center(
          child: Container(
            width: 220,
            // height: 243,
            color: Colors.transparent,
            child: _dialog,
          ),
        );
      },
    );
    // showDialog<dynamic>(
    //   context: _buildContext!,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     _context = context;
    //     return Center(
    //       child: Container(
    //         width: 220,
    //         // height: 243,
    //         color: Colors.transparent,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             SpinKitFoldingCube(
    //               color: Colors.white,
    //               size: 45,
    //             ),
    //             SizedBox(
    //               height: 35,
    //             ),
    //             Text(
    //               _dialogMessage,
    //               style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 17,
    //                   fontFamily: 'Nunito Sans',
    //                   decoration: TextDecoration.none),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}

// ignore: must_be_immutable
class _MyDialog extends StatefulWidget {
  var _dialog = new _MyDialogState();

  update() {
    print('dialog update');
    _dialog.changeState();
  }

  @override
  // ignore: must_be_immutable
  State<StatefulWidget> createState() {
    return _dialog;
  }
}

class _MyDialogState extends State<_MyDialog> {
  changeState() {
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _isShowing = false;
  }

  Widget drawMsgContent() {
    if (_progressDialogType == ProgressDialogType.Success) {
      return BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(width: 0.4, color: Colors.white),
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFFFF).withOpacity(0.3),
                    const Color(0xFFFFFF).withOpacity(0.7),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Icon(
                //   CupertinoIcons.checkmark_alt_circle,
                //   size: 48,
                //   color: Colors.green,
                // ),
                Container(
                  decoration: BoxDecoration(
                      color: HexColor("#a3cfbb"),
                      borderRadius: BorderRadius.circular(100)),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.check,
                    color: HexColor("#198755"),
                    size: 40,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  _dialogMessage.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      );
    }

    if (_progressDialogType == ProgressDialogType.Error) {
      return BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
            width: double.infinity,
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(width: 0.4, color: Colors.white),
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFFFF).withOpacity(0.3),
                    const Color(0xFFFFFF).withOpacity(0.7),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: HexColor("#f1aeb5"),
                      borderRadius: BorderRadius.circular(100)),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.close,
                    color: HexColor("#dc3444"),
                    size: 40,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  _dialogMessage.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
      );
    }

    if (_progressDialogType == ProgressDialogType.Loading) {
      return BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(8),
                    child:
                        CircularProgressIndicator(color: HexColor("#4e23b4"))),
                SizedBox(height: 16.0),
                Text(
                  "alert_tur_huleene_uu".tr.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      );
    }

    if (_progressDialogType == ProgressDialogType.Download) {
      return Stack(
        children: <Widget>[
          Positioned(
            child: Text(_dialogMessage,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400)),
            top: 25.0,
          ),
          Positioned(
            child: Text("$_progress/100",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400)),
            bottom: 15.0,
            right: 15.0,
          ),
        ],
      );
    }

    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          // color: Colors.white70,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              // child: SpinKitFoldingCube(
              //   color: Colors.white,
              //   size: 45,
              // ),
              child: Image.asset(
                "assets/images/loading_logo.gif",
                color: Colors.white,
                width: 80,
                height: 80,
              ),
            ),
            SizedBox(height: 25.0),
            Wrap(
              children: <Widget>[
                Text(
                  _dialogMessage.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context)
            .copyWith(dialogBackgroundColor: Colors.transparent),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: drawMsgContent(),
        ));
  }
}
