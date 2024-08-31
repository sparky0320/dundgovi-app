import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:lambda/modules/agent/agent_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:mdi/mdi.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/image_strings.dart';
import 'package:move_to_earn/core/constants/sizes.dart';
import 'package:move_to_earn/core/controllers/app_controller.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import 'package:move_to_earn/ui/component/buttons/gradient_button_small.dart';
import 'package:move_to_earn/ui/component/headers/header_for_page.dart';
import 'package:move_to_earn/ui/views/home/banner.dart';
import 'package:move_to_earn/ui/views/profile/achievement/achievement_certificate.dart';
import 'package:move_to_earn/ui/views/profile/achievement/achievement_details.dart';
import 'package:move_to_earn/ui/views/steps/daily.dart';
import 'package:move_to_earn/ui/views/steps/monthly.dart';
import 'package:move_to_earn/ui/views/steps/weekly.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import '../../../../core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/values.dart';

class AchievementPage extends StatefulWidget {
  const AchievementPage({super.key});

  @override
  State<AchievementPage> createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage>
    with SingleTickerProviderStateMixin {
  // ScrollController scrollController = ScrollController();
  final AppController appController = Get.put(AppController());
  // bool is_loading = false;
  // final formattedYear = DateFormat('yyyy').format(DateTime.now());
  // String userBday_gift_year = '';
  // bool isTaken = false;
  var goto;

  @override
  void initState() {
    super.initState();

    // for (var badge in appController.badgesList) {
    //   for (var badgeUser in appController.badgeUserList) {
    //     if (badge.id == badgeUser.badgeid) {
    //       goto = AchievementCertificate(
    //           image: badge.image, name: badge.name, kilo: badge.kilo);
    //     } else {
    //       goto = AchievementDetails(
    //           image: badge.image, name: badge.name, kilo: badge.kilo);
    //     }
    //   }
    // }
  }

  void Goto({int? id, String? name, String? image, int? kilo}) {
    print(id);
    bool hasBadge = false;
    hasBadge =
        appController.badgeUserList.any((element) => element.badgeid == id);
    if (hasBadge == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => goto =
                AchievementCertificate(image: image, name: name, kilo: kilo)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => goto =
                AchievementDetails(image: image, name: name, kilo: kilo)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackColor(),
          Container(
            padding: EdgeInsets.only(top: 48.h, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackArrow(),
                Row(
                  children: [
                    Image.asset(
                      achievement,
                      height: careIconSize.w,
                      width: careIconSize.w,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Achievement',
                      style: TextStyle(
                          color: white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                IconButton(
                  iconSize: 32,
                  icon: Icon(
                    Mdi.helpCircleOutline,
                    color: white,
                  ),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 110.h, left: 20.h, right: 20.h, bottom: 50.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BannerHome(),
                  Text(
                    'Badges',
                    style: TextStyle(
                        color: white,
                        fontSize: 18.h,
                        fontWeight: FontWeight.w600),
                  ),
                  GridView.builder(
                    itemCount: appController.badgesList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? 3
                            : 3),
                    itemBuilder: (_, index) {
                      return Badges(index);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Badges(index) {
    String logo = "$baseUrl${appController.badgesList[index].image}";
    print(appController.badgeUserList.length);

    return InkWell(
      onTap: (() {
        Goto(
            id: appController.badgesList[index].id,
            name: appController.badgesList[index].name,
            image: appController.badgesList[index].image,
            kilo: appController.badgesList[index].kilo);
      }),
      child: Column(
        children: [
          Container(
            width: 65.h,
            height: 65.h,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  logo,
                  maxWidth: (MediaQuery.of(context).size.width *
                          MediaQuery.of(context).devicePixelRatio)
                      .round(),
                ),
                fit: BoxFit.fitHeight,
                filterQuality: FilterQuality.low,
              ),
            ),
          ),
          Text(
            appController.badgesList[index].name.toString(),
            style: TextStyle(color: white),
          ),
          Text(
            appController.badgesList[index].kilo.toString() + ' км',
            style: TextStyle(color: white),
          ),
        ],
      ),
    );
  }
}
