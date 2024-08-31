import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lambda/utils/hexColor.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import 'package:move_to_earn/ui/component/headers/header_for_page.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';

import '../../../utils/number.dart';

class ScoreLogPage extends StatefulWidget {
  const ScoreLogPage({super.key});

  @override
  State<ScoreLogPage> createState() => _ScoreLogPageState();
}

class _ScoreLogPageState extends State<ScoreLogPage> {
  ScrollController scrollController = ScrollController();
  int historyPage = 0;
  bool historyEnd = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollHandler);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData(true);
    });
  }

  scrollHandler() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!historyEnd) {
        historyPage += 1;

        print("GET HISTORY");
        getData(false);
      }
    }
  }

  getData(bool reset) async {
    setState(() {
      loading = true;
    });
    historyEnd =
        await appController.getScoreLog(page: historyPage, reset: reset);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackColor(),
          HeaderForPage(
            backArrow: BackArrow(),
            text: "dss_point_history".tr,
          ),
          // Container(
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.all(radiusCircular(15))),
          //   child: Positioned.fill(
          //     child: Image(
          //       image: NetworkImage(
          //           "https://img.freepik.com/free-photo/pathway-middle-green-leafed-trees-with-sun-shining-through-branches_181624-4539.jpg?w=1800"),
          //       width: 187.w,
          //     ),
          //   ),
          // ),
          loading
              ? Center(
                  child: SpinKitRipple(
                    color: mainWhite,
                    size: 50.0.r,
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(top: 100.w),
                  child: GetBuilder(
                      init: appController,
                      builder: (_) {
                        return ListView(
                          controller: scrollController,
                          padding: EdgeInsets.zero,
                          children: [
                            appController.scoreLogs.isNotEmpty
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: appController.scoreLogs.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 7.w),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 30.w,
                                          vertical: 15.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: mainWhite.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(15.w),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      appController.scoreLogs[
                                                                          index]
                                                                      ['score']
                                                                  [0] !=
                                                              "-"
                                                          ? "+" +
                                                              negativeFormatNumber(
                                                                  appController
                                                                              .scoreLogs[
                                                                          index]
                                                                      ['score'])
                                                          : negativeFormatNumber(
                                                              appController
                                                                      .scoreLogs[
                                                                  index]['score']),
                                                      style: TextStyle(
                                                        color: appController.scoreLogs[
                                                                            index]
                                                                        [
                                                                        'score']
                                                                    [0] ==
                                                                "-"
                                                            ? Colors.red
                                                            : HexColor(
                                                                "4CAA06"),
                                                        fontSize: 20.w,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10.w),
                                                    Text(
                                                      "care",
                                                      style: TTextTheme
                                                          .darkTextTheme
                                                          .headlineSmall,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  DateFormat('yyyy.MM.dd kk:mm')
                                                      .format(DateTime.parse(
                                                          appController
                                                              .scoreLogs[index]
                                                                  ['updated_at']
                                                              .toString())),
                                                  style: TTextTheme
                                                      .darkTextTheme
                                                      .headlineSmall,
                                                ),
                                              ],
                                            ),
                                            appController.scoreLogs[index]
                                                        ['description'] !=
                                                    null
                                                ? Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 8),
                                                    child: Text(
                                                      appController
                                                              .scoreLogs[index]
                                                          ['description'],
                                                      style: TTextTheme
                                                          .darkTextTheme
                                                          .headlineSmall,
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : const SizedBox(),
                            appController.scoreLogs.isEmpty
                                ? Center(
                                    child: Text(
                                      "shp_odoogoor_medeelel_bhgv_bn".tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: mainWhite, fontSize: 18),
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        );
                      }),
                ),
        ],
      ),
    );
  }
}
