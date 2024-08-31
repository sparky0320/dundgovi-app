import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:move_to_earn/core/constants/values.dart';

void showPickImageModal(context,cameraOnPressed,galleryOnPressed) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
    ),
    backgroundColor: mainWhite,
    builder: (builder) {
      return Container(
        padding: EdgeInsets.only(top: 12.h, bottom: 34.h),
        child: Wrap(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 110.h,
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: cameraOnPressed,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Iconsax.camera,
                            size: 30.sp,
                            color: mainTextBlack,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Камер',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: mainTextBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 32.h,
                  width: 1.w,
                  color: mainBorderGrey,
                ),
                Expanded(
                  child: SizedBox(
                    height: 110.h,
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: galleryOnPressed,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Iconsax.image,
                            size: 30.sp,
                            color: mainTextBlack,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Зургийн галлерей',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: mainTextBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}