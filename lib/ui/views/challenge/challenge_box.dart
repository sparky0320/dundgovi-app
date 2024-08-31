import 'package:flutter/material.dart';
import 'package:lambda/utils/hexColor.dart';
import 'package:move_to_earn/core/constants/colors.dart';

class ChallengeBox extends StatefulWidget {
  final String title;
  final String description;
  final Widget icon;
  const ChallengeBox(
      {super.key,
      required this.title,
      required this.description,
      required this.icon});

  @override
  State<ChallengeBox> createState() => _ChallengeBoxState();
}

class _ChallengeBoxState extends State<ChallengeBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(colors: [
              ColorConstants.gradientColor1,
              ColorConstants.gradientColor2,
              ColorConstants.gradientColor3,
              ColorConstants.gradientColor4,
              ColorConstants.gradientColor5,
            ])),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            FittedBox(
                child: Text(widget.description,
                    style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}

class SecondChallengeBox extends StatefulWidget {
  final String title;
  final String description;
  final Widget icon;
  const SecondChallengeBox(
      {super.key,
      required this.title,
      required this.description,
      required this.icon});

  @override
  State<SecondChallengeBox> createState() => _SecondChallengeBoxState();
}

class _SecondChallengeBoxState extends State<SecondChallengeBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(
          //     color:
          //         Colors.white.withOpacity(0.20)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.35),
                Colors.white.withOpacity(0.03),
              ]),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
            FittedBox(
                child: Text(widget.description,
                    style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}

class MainContainer extends StatefulWidget {
  final Widget child;
  const MainContainer({super.key, required this.child});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: HexColor("362656"),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: HexColor("128EF6"),
            width: 0.6,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        child: widget.child);
  }
}
