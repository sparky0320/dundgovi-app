import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget LoadingCircle() => Center(
        child: Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SpinKitFoldingCube(
          //   color: Colors.white,
          //   size: 45,
          // ),
          Image.asset(
            "assets/images/loading_logo.gif",
            color: Colors.white,
            width: 60,
            height: 60,
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'r3_tvr_hvleene_vv'.tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Nunito Sans',
            ),
          ),
        ],
      ),
    ));
