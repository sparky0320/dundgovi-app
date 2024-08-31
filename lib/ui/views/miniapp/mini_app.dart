import 'dart:convert';
import 'dart:ui';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/loading_circle.dart';
import 'package:move_to_earn/core/controllers/profile/profile_controller.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/utils/web_view_container.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MiniApp extends StatefulWidget {
  const MiniApp({super.key});

  @override
  State<MiniApp> createState() => _MiniAppState();
}

class _MiniAppState extends State<MiniApp> {
  ProfileCtrl ctrl = Get.put(ProfileCtrl());
  final orientation = 200;
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  late bool isLoading = true;
  int page = 1;
  int lastPage = 1;
  bool loading = false;
  List? appsList;
  NetworkUtil _netUtil = NetworkUtil();
  String? first;
  String? last;
  String? phone;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    getMiniApp();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    // });
  }

  Future getMiniApp() async {
    loading = true;

    try {
      final response = await _netUtil.get(baseUrl + '/api/get-mini-apps');
      if (response != null && response['status'] == true) {
        setState(() {
          appsList = response['data'];
          first = jsonDecode(agentController.userData.value)['first_name'];
          last = jsonDecode(agentController.userData.value)['last_name'];
          if (jsonDecode(agentController.userData.value)['phone'] == null) {
            phone = jsonDecode(agentController.userData.value)['email'];
          } else {
            phone = jsonDecode(agentController.userData.value)['phone'];
          }
          // print(phone);
        });
        // prefs.setString('appLists', appsList);
      }

      loading = false;
      // update();
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      if (page < lastPage) {
        page = page + 1;
        await getMiniApp();
        setState(() {
          isLoadingMore = false;
        });
      } else {
        setState(() {
          isLoadingMore = false;
        });
      }
    }
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    setState(() {
      appsList = null;
    });

    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      page = 1;
    });
    getMiniApp();
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackColor(),
          Column(
            children: [
              Column(
                children: [
                  ClipRRect(
                    child: BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).viewPadding.top),
                        margin:
                            EdgeInsets.only(left: 20.w, right: 20.w, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'nav_miniapp'.tr,
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Nunito Sans'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: getAppWidget())),
            ],
          ),
        ],
      ),
    );
  }

  Widget getAppWidget() {
    return (isLoading && appsList == null)
        ? Center(child: LoadingCircle())
        : hasData();
  }

  Widget hasData() {
    if (appsList!.isEmpty) {
      return Center(
          child: Text(
        "cp_odoogoor_medeelel_bhgv_bn".tr,
        textAlign: TextAlign.center,
        style: TextStyle(color: mainWhite, fontSize: 18.sp),
      ));
    } else {
      return SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          header: const MaterialClassicHeader(
            color: greenColor,
          ),
          onRefresh: _onRefresh,
          child: GridView.builder(
              itemCount:
                  isLoadingMore ? appsList!.length + 1 : appsList?.length,
              controller: scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 7,
                  // mainAxisSpacing: 1,
                  childAspectRatio: 77 / 100,
                  crossAxisCount:
                      (orientation == Orientation.portrait) ? 2 : 2),
              itemBuilder: (_, index) {
                if (index < appsList!.length) {
                  return getCard(index);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }));
    }
  }

  Widget getCard(index) {
    var name = "";
    var logo = "";
    var link = "";
    if (appsList?[index] != null) {
      name = appsList?[index]['name'];
      logo = '$baseUrl${appsList?[index]['thumb']}';
      link = appsList?[index]['link'];
    }
    return Column(
      children: [
        Card(
            child: Container(
          decoration: BoxDecoration(
              color: grey.withOpacity(0.1),
              borderRadius: BorderRadius.all(
                Radius.circular(11),
              )),
          height: 164,
          width: 164,
          child: InkWell(
              onTap: () {
                Get.to(() => WebViewContainer(
                    // link: 'http://www.google.mn',
                    link: link +
                        '?phone=${phone}&firstname=${first}&lastname=${last}',
                    name: name));
                // print(first);
                // print(last);
                // print(phone);
                // print(ctrl.phoneNumberView);
                // Get.to(WebViewContainer(
                //     link: link +
                //         '?phone=${ctrl.phoneNumberView}&firstname=${ctrl.firstName.text}&lastname=${ctrl.lastName.text}',
                //     name: name));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: ShapeDecoration(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(11),
                        topLeft: Radius.circular(11),
                        bottomLeft: Radius.circular(11),
                        bottomRight: Radius.circular(11),
                      ),
                    )),
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(11),
                              topRight: Radius.circular(11),
                              bottomLeft: Radius.circular(11),
                              bottomRight: Radius.circular(11),
                            ),
                            child: Stack(
                              children: [
                                SvgPicture.network(
                                  logo,
                                  fit: BoxFit.fitWidth,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                )
                              ],
                            ))),
                  ],
                ),
              )),
        )),
        Container(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Nunito Sans',
              height: 0,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ],
    );
  }
}
