import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class BackColor extends StatelessWidget {
  const BackColor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorConstants.backGradientColor1.withOpacity(1),
            ColorConstants.backGradientColor2,
            ColorConstants.backGradientColor3,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
    // Container(
    //   decoration: BoxDecoration(
    //     gradient:
    //       RadialGradient(
    //         center: Alignment(-0.5, 0.5),
    //         radius: 1.2,
    //         colors: [
    //           Color(0xFF611882),
    //           Color(0xFF2D1856),
    //         ],
    //       ),

    //   ),
    // );
  }
}
