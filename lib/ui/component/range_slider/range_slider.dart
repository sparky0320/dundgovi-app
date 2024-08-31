import 'package:flutter/material.dart';

class CustomRangeThumbShape extends RangeSliderThumbShape {
  final double thumbRadius;
  final double borderSize;
  final Color borderColor;
  final Color strokeColor;

  CustomRangeThumbShape({
    required this.thumbRadius,
    required this.borderSize,
    required this.borderColor,
    required this.strokeColor,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius + borderSize);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        bool? isDiscrete,
        bool? isEnabled,
        bool? isOnTop,
        TextDirection? textDirection,
        required SliderThemeData sliderTheme,
        Thumb? thumb,
        bool? isPressed
  }) {
    final Canvas canvas = context.canvas;
    final Paint paint = Paint()
      ..color = enableAnimation.value == 1.0 ? strokeColor : sliderTheme.inactiveTrackColor!
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = enableAnimation.value == 1.0 ? borderColor : sliderTheme.disabledThumbColor!
      ..strokeWidth = borderSize
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, thumbRadius, paint);
    canvas.drawCircle(center, thumbRadius, borderPaint);
  }

}
