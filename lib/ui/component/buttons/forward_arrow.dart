import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/image_strings.dart';

class ForwardArrow extends StatelessWidget {
  final getTo;

  const ForwardArrow({required this.getTo});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(arrowForwardSvg),
      onPressed: getTo,
    );
  }
}
