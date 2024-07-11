import 'package:flutter/material.dart';

class AppClipper extends CustomClipper<Path> {
  final double factor;
  AppClipper({super.reclip, required this.factor});
  @override
  getClip(Size size) {
    var controlPoint = Offset(size.width / 2, size.height);
    var endPoint = Offset(size.width, size.height * factor);
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height * factor)
      ..quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
