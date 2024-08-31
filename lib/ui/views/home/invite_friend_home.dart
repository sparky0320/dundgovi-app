import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/sizes.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/invite_friend/invite_friend_controller.dart';
import 'package:move_to_earn/ui/views/home/modalbottoms.dart';
import 'package:nb_utils/nb_utils.dart';

class InviteFriendHome extends StatefulWidget {
  const InviteFriendHome({super.key});

  @override
  State<InviteFriendHome> createState() => _InviteFriendHomeState();
}

class _InviteFriendHomeState extends State<InviteFriendHome> {
  InviteFriendCtrl ctrl = Get.put(InviteFriendCtrl());
  @override
  void initState() {
    super.initState();
    ctrl.getInvite();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dialogInvite(context);
      },
      child: Container(
        height: 86.h,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: mainWhite.withOpacity(0.2),
          borderRadius: BorderRadius.circular(widgetRadius.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/gift.png",
              height: 86.h,
              fit: BoxFit.fill,
            ),

            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Text(
                'gop_naizaa_uriad_500_care_aw'.tr.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // SvgPicture.asset(arrowForwardSvg),
            SizedBox(
              width: 5.w,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widgetRadius.r),
                // gradient: LinearGradient(
                //   colors: [
                //     ColorConstants.buttonGradient2,
                //     ColorConstants.buttonGradient1,
                //   ],
                // ),
              ),
              padding: EdgeInsets.all(10.w),
              child: Icon(
                Icons.keyboard_arrow_right,
                color: white,
                size: 25,
              ),
              // Text(
              //   "gop_odoo_awah".tr,
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 14.sp,
              //     fontWeight: FontWeight.w800,
              //   ),
              // ),
            )
          ],
        ),
      ),
    );
  }
}
