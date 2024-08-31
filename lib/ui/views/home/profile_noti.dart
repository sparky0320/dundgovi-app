import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/controllers/notification_controller.dart';
import 'notification_page.dart';

class ProAndNotiWidget extends StatelessWidget {
  final Widget? scoreHead;

  const ProAndNotiWidget({super.key, this.scoreHead});

  @override
  Widget build(BuildContext context) {
    NotificationController notificationController = Get.find();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // InkWell(
        //   onTap: () {
        //     Get.to(() => ProfilePage());
        //   },
        //   child: ClipOval(
        //     child: appController.user.value.avatar != null
        //         ? Image.network(
        //             baseUrl + appController.user.value.avatar!,
        //             height: homeProHeight.w,
        //             width: homeProWidth.w,
        //             fit: BoxFit.cover,
        //             // assets/images/avatar.png
        //             errorBuilder: (BuildContext context, Object exception,
        //                 StackTrace? stackTrace) {
        //               return Container(
        //                 height: homeProHeight.w,
        //                 width: homeProWidth.w,
        //                 decoration: BoxDecoration(shape: BoxShape.circle),
        //                 alignment: Alignment.center,
        //                 child: Image.asset(
        //                   'assets/images/avatar.png',
        //                   height: homeProHeight.w,
        //                   width: homeProWidth.w,
        //                   fit: BoxFit.cover,
        //                 ),
        //               );
        //             },
        //           )
        //         : Image.asset(
        //             'assets/images/avatar.png',
        //             height: homeProHeight.w,
        //             width: homeProWidth.w,
        //             fit: BoxFit.cover,
        //           ),
        //   ),
        // ),
        scoreHead!,
        GetBuilder(
            init: notificationController,
            builder: (_) {
              return IconButton(
                onPressed: () {
                  Get.to(() => NotificationPage());
                },
                icon: Badge(
                  label: Text(notificationController.unread < 10
                      ? "${notificationController.unread}"
                      : "9+"),
                  isLabelVisible: notificationController.unread > 0,
                  child: Icon(
                    Iconsax.notification,
                    color: Colors.white,
                    size: 24.w,
                  ),
                ),
              );
            })
      ],
    );
  }
}
