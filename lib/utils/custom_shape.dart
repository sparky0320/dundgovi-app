import 'package:flutter/material.dart';

import 'dart:math' as Math;

class CustomShapeClipper extends CustomClipper<Path> {
  double? height;
  @required
  double? border;
  CustomShapeClipper({this.height, this.border});

  num degToRad(num deg) => deg * (Math.pi / 180.0);
  @override
  Path getClip(Size size) {
    double curveHeight = height!;
    Offset controlPoint = Offset((size.width / 2) - border! * 4, size.height);
    Offset endPoint = Offset(size.width - border!, size.height - curveHeight);
    print(size.height);
    Path path = Path();

    path
      ..moveTo(0, 0)
      ..lineTo(0, size.height - border! - curveHeight)
      ..quadraticBezierTo(
          0, size.height - curveHeight, border!, size.height - curveHeight)
      ..quadraticBezierTo(size.width / 2, size.height + 2, size.width - border!,
          size.height - curveHeight)
      ..quadraticBezierTo(
          size.width / 2, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..quadraticBezierTo(size.width, size.height - curveHeight, size.width,
          size.height - curveHeight - border!)
      ..lineTo(size.width, border! + curveHeight)
      ..quadraticBezierTo(size.width, curveHeight.toDouble(),
          size.width - border!, curveHeight.toDouble())
      ..quadraticBezierTo(size.width / 2, -2, border!, curveHeight.toDouble())
      // ..lineTo(border!, 0)
      ..quadraticBezierTo(0, curveHeight.toDouble(), 0, border! + curveHeight)
      // ...addArc(Rect.fromLTWH(0, 0, size.width, size.height), degToRad(180), degToRad(90))
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
