import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/colors.dart';

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.bgBlack
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12.0;

    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height / 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
