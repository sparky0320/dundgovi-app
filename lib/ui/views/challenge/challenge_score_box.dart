// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lambda/utils/hexColor.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/image_strings.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/challenge_controller.dart';
import 'package:move_to_earn/core/models/challenge/challenge_model.dart';
import 'package:move_to_earn/utils/number.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';
import 'package:nb_utils/nb_utils.dart';

class ChallengeScoreBox extends StatefulWidget {
  final ChallengeModel challenge;

  const ChallengeScoreBox({super.key, required this.challenge});

  @override
  State<ChallengeScoreBox> createState() => _ChallengeScoreBoxState();
}

class _ChallengeScoreBoxState extends State<ChallengeScoreBox> {
  ChallengeController controller = Get.find();
  dynamic myScore;
  bool showMyScore = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // getData();
    });
  }

  // getData() async {
  //   controller.getChallengeScore(widget.challenge).then((value) {
  //     if (value != null && mounted) {
  //       setState(() {
  //         myScore = value;
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChallengeController>(
      builder: (logic) {
        return controller.scoreBoard.isEmpty
            ? Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '',
                  style: TextStyle(color: white, fontSize: 33),
                ),
              )
            : Column(
                children: [
                  controller.scoreBoard.isNotEmpty
                      ? Center(
                          child: Stack(
                            children: [
                              controller.scoreBoard[0] != null
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 222,
                                      child: Column(
                                        children: [
                                          Text(
                                            '1',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFFFDE99E),
                                              fontSize: 10,
                                              fontFamily: 'Nunito Sans',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.58),
                                              ),
                                            ),
                                            child: Image.asset(
                                              coinGold,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: ClipOval(
                                              child: controller.scoreBoard[0]
                                                          ['avatar'] !=
                                                      null
                                                  ? CachedNetworkImage(
                                                      imageUrl: baseUrl +
                                                          controller
                                                                  .scoreBoard[0]
                                                              ['avatar'],
                                                      fit: BoxFit.cover,
                                                      errorWidget:
                                                          (context, ss, ff) {
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                Colors.black26,
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : Image.asset(
                                                      'assets/images/avatar.png'),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          controller.scoreBoard[0]
                                                      ["first_name"] !=
                                                  null
                                              ? Text(
                                                  controller.scoreBoard[0]
                                                      ["first_name"],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFFDE99E),
                                                    fontSize: 10,
                                                    fontFamily: 'Nunito Sans',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                )
                                              : Text(
                                                  'User',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFFDE99E),
                                                    fontSize: 10,
                                                    fontFamily: 'Nunito Sans',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                          controller.scoreBoard[0]["score"] !=
                                                  null
                                              ? Text(
                                                  formatNumber(controller
                                                      .scoreBoard[0]["score"]),
                                                  style: TextStyle(
                                                    color: Color(0xFFFDE99E),
                                                    fontSize: 10,
                                                    fontFamily: 'Nunito Sans',
                                                    fontWeight: FontWeight.w800,
                                                    height: 0,
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 0,
                                                ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0,
                                    ),
                              controller.scoreBoard.length == 2 ||
                                      controller.scoreBoard.length > 2
                                  ? Positioned(
                                      left: 70,
                                      top: 50,
                                      child: Column(
                                        children: [
                                          Text(
                                            '2',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFFFDE99E),
                                              fontSize: 10,
                                              fontFamily: 'Nunito Sans',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.58),
                                              ),
                                            ),
                                            child: Image.asset(
                                              coinSilver,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          // Container(
                                          //   width: 80,
                                          //   height: 80,
                                          //   clipBehavior: Clip.antiAlias,
                                          //   decoration: ShapeDecoration(
                                          //     image: DecorationImage(
                                          //       image: NetworkImage(
                                          //           "https://via.placeholder.com/100x100"),
                                          //       fit: BoxFit.fill,
                                          //     ),
                                          //     shape: RoundedRectangleBorder(
                                          //       side: BorderSide(
                                          //           width: 2,
                                          //           color: Colors.white),
                                          //       borderRadius:
                                          //           BorderRadius.circular(100),
                                          //     ),
                                          //   ),
                                          // ),
                                          SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: ClipOval(
                                              child: controller.scoreBoard[1]
                                                          ['avatar'] !=
                                                      null
                                                  ? CachedNetworkImage(
                                                      imageUrl: baseUrl +
                                                          controller
                                                                  .scoreBoard[1]
                                                              ['avatar'],
                                                      fit: BoxFit.cover,
                                                      errorWidget:
                                                          (context, ss, ff) {
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                Colors.black26,
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : Image.asset(
                                                      'assets/images/avatar.png'),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          controller.scoreBoard[1]
                                                      ["first_name"] !=
                                                  null
                                              ? Text(
                                                  controller.scoreBoard[1]
                                                      ['first_name'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFE6E6E6),
                                                    fontSize: 10,
                                                    fontFamily: 'Nunito Sans',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                )
                                              : Text(
                                                  'User',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFE6E6E6),
                                                    fontSize: 10,
                                                    fontFamily: 'Nunito Sans',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                          controller.scoreBoard[1]["score"] !=
                                                  null
                                              ? Text(
                                                  formatNumber(controller
                                                      .scoreBoard[1]["score"]),
                                                  style: TextStyle(
                                                    color: Color(0xFFE6E6E6),
                                                    fontSize: 10,
                                                    fontFamily: 'Nunito Sans',
                                                    fontWeight: FontWeight.w800,
                                                    height: 0,
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 0,
                                                ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0,
                                    ),
                              controller.scoreBoard.length == 3 ||
                                      controller.scoreBoard.length > 3
                                  ? Positioned(
                                      right: 70,
                                      top: 50,
                                      child: Column(
                                        children: [
                                          Text(
                                            '3',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFFFDE99E),
                                              fontSize: 10,
                                              fontFamily: 'Nunito Sans',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.58),
                                              ),
                                            ),
                                            child: Image.asset(
                                              coinBronze,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: ClipOval(
                                              child: controller.scoreBoard[2]
                                                          ['avatar'] !=
                                                      null
                                                  ? CachedNetworkImage(
                                                      imageUrl: baseUrl +
                                                          controller
                                                                  .scoreBoard[2]
                                                              ['avatar'],
                                                      fit: BoxFit.cover,
                                                      errorWidget:
                                                          (context, ss, ff) {
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                Colors.black26,
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : Image.asset(
                                                      'assets/images/avatar.png'),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          controller.scoreBoard[2]
                                                      ["first_name"] !=
                                                  null
                                              ? Text(
                                                  controller.scoreBoard[2]
                                                      ['first_name'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xE29862)
                                                        .withOpacity(1),
                                                    fontSize: 10,
                                                    fontFamily: 'Nunito Sans',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                )
                                              : Text(
                                                  'User',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xE29862)
                                                        .withOpacity(1),
                                                    fontSize: 10,
                                                    fontFamily: 'Nunito Sans',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                          controller.scoreBoard[2]["score"] !=
                                                  null
                                              ? Text(
                                                  formatNumber(controller
                                                      .scoreBoard[2]["score"]),
                                                  style: TextStyle(
                                                    color: Color(0xE29862)
                                                        .withOpacity(1),
                                                    fontSize: 10,
                                                    fontFamily: 'Nunito Sans',
                                                    fontWeight: FontWeight.w800,
                                                    height: 0,
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 0,
                                                ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0,
                                    ),
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xFFFFFF).withOpacity(0.2)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: controller.scoreBoard
                            .asMap()
                            .entries
                            .take(10)
                            .map((entry) {
                          int index = entry.key;
                          dynamic e = entry.value;
                          return index == 0 || index == 1 || index == 2
                              ? SizedBox(
                                  height: 0,
                                )
                              : Column(
                                  children: [
                                    Container(
                                      // margin: EdgeInsets.only(top: 12),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          gradient: e['user_id'] ==
                                                  appController.user.value.id
                                              ? LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                      HexColor("EF566A"),
                                                      HexColor("627AF7")
                                                    ])
                                              : null),
                                      // padding: const EdgeInsets.symmetric(
                                      //     vertical: 4),
                                      child: Row(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text((index + 1).toString(),
                                              style: TTextTheme
                                                  .darkTextTheme.displaySmall),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: ClipOval(
                                            child: e['avatar'] != null
                                                ? CachedNetworkImage(
                                                    imageUrl:
                                                        baseUrl + e['avatar'],
                                                    fit: BoxFit.cover,
                                                    errorWidget:
                                                        (context, ss, ff) {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.black26,
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Image.asset(
                                                    'assets/images/avatar.png'),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                e['first_name'] ?? "User",
                                                style: TextStyle(
                                                    color: mainWhite,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              const SizedBox(width: 12),
                                              e['score'] != null
                                                  ? Text(
                                                      formatNumber(e['score']),
                                                      style: TextStyle(
                                                          color: mainWhite,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        ),
                                        index == 0
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: SvgPicture.asset(
                                                  'assets/icon-svg/icon/crown.svg',
                                                  height: 20,
                                                  color: Colors.yellow,
                                                ),
                                              )
                                            : index == 1
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: SvgPicture.asset(
                                                      'assets/icon-svg/icon/crown.svg',
                                                      height: 20,
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                : index == 2
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 15),
                                                        child: SvgPicture.asset(
                                                          'assets/icon-svg/icon/crown.svg',
                                                          height: 20,
                                                          color: Colors.brown,
                                                        ),
                                                      )
                                                    : SizedBox()
                                      ]),
                                    ),
                                    Divider(
                                      color: Colors.white,
                                    )
                                  ],
                                );
                        }).toList()),
                  ),
                  controller.myScoreBoard.isEmpty
                      ? SizedBox(width: 0)
                      : controller.rankScore! > 10
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 12),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft,
                                    colors: [
                                      HexColor("627AF7"),
                                      HexColor("EF566A")
                                    ]),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(controller.rankScore.toString(),
                                        style: TTextTheme
                                            .darkTextTheme.displaySmall),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: ClipOval(
                                      child: controller.myScoreBoard[0]
                                                  ['avatar'] !=
                                              null
                                          ? CachedNetworkImage(
                                              imageUrl: baseUrl +
                                                  controller.myScoreBoard[0]
                                                      ['avatar'],
                                              fit: BoxFit.cover,
                                              errorWidget: (context, ss, ff) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black26,
                                                  ),
                                                );
                                              },
                                            )
                                          : Image.asset(
                                              'assets/images/avatar.png'),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.myScoreBoard[0]
                                                  ['first_name'] ??
                                              "User",
                                          style: TextStyle(
                                              color: mainWhite,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(width: 12),
                                        controller.myScoreBoard[0] != null
                                            ? Text(
                                                formatNumber(controller
                                                    .myScoreBoard[0]['score']),
                                                style: TextStyle(
                                                    color: mainWhite,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                            )
                          : SizedBox(width: 0)
                ],
              );
      },
    );
  }
}
