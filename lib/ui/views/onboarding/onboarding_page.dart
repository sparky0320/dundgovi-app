import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/models/model_onbaording.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.model,
  });

  final OnboardingModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: ColorConstants.backGradientColor1),
        ),
        Container(
          height: MediaQuery.of(context).size.width / 0.8,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(model.backImage), fit: BoxFit.cover)),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: defaultSize * 3,
            bottom: defaultSize * 6,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Image.asset(
                  model.image,
                  height: MediaQuery.of(context).size.height / 2.2,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  model.text,
                  style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold, color: white),
                  // style: TTextTheme.darkTextTheme.displayMedium,
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 15, right: 20),
                child: Text(
                  model.description,
                  style: TextStyle(fontSize: 15, color: whiteColor),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
