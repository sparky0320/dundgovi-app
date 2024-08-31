import 'package:flutter/material.dart';
import 'dart:math';

class HalfCirclePainter extends CustomPainter {
  final Paint _paint = Paint()..color = Colors.blue;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    final double startAngle = pi; // Start at the left side
    final double endAngle = 0; // End at the right side

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        endAngle, true, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
