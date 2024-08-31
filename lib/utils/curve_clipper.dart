import 'package:flutter/material.dart';

/// home-menu page curve clipper
class CurveClipperHome extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    double curveHeight = size.height * 2 / 5;
    var p = Path();
    p.lineTo(0, height * 3 / 4);
    p.quadraticBezierTo(width * 1 / 2, height, width, height - curveHeight);
    p.lineTo(width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CurveClipperHome2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    double curveHeight = size.height * 2 / 5;
    var p = Path();
    p.lineTo(0, height * 4 / 5);
    p.quadraticBezierTo(width * 1 / 2, height, width, height - curveHeight);
    p.lineTo(width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/// login page curve clipper
class CurveClipperLogin extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    double curveHeight = size.height * 1 / 4;
    var p = Path();
    p.lineTo(0, height * 4 / 5);
    p.quadraticBezierTo(width * 1 / 2, height, width, height - curveHeight);
    p.lineTo(width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CurveClipperLogin2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    double curveHeight = size.height * 1 / 4;
    var p = Path();
    p.lineTo(0, height * 5 / 6);
    p.quadraticBezierTo(width * 1 / 2, height, width, height - curveHeight);
    p.lineTo(width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/// all curve clipper
class CurveClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    double curveHeight = size.height * 2 / 4;
    var p = Path();
    p.lineTo(0, height * 3 / 5);
    p.quadraticBezierTo(width * 1 / 2, height, width, height - curveHeight);
    p.lineTo(width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CurveClipper2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    double curveHeight = size.height * 2 / 4;
    var p = Path();
    p.lineTo(0, height * 2 / 3);
    p.quadraticBezierTo(width * 1 / 2, height, width, height - curveHeight);
    p.lineTo(width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
