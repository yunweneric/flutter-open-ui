import 'package:flutter/material.dart';

// class Ellipse43Painter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Color(0xFFD9D9D9)
//       ..style = PaintingStyle.fill;

//     Path path = Path();
//     path.moveTo(230.459, 230.459);
//     path.cubicTo(252.544, 208.374, 266.289, 179.315, 269.35, 148.232);
//     path.cubicTo(272.411, 117.15, 264.6, 85.9673, 247.248, 59.998);
//     path.cubicTo(229.896, 34.0288, 204.077, 14.8795, 174.188, 5.81306);
//     path.cubicTo(144.3, -3.2534, 112.193, -1.67607, 83.3377, 10.2763);
//     path.cubicTo(54.4822, 22.2286, 30.6637, 43.8164, 15.9406, 71.3614);
//     path.cubicTo(1.21751, 98.9065, -3.49926, 130.704, 2.59399, 161.337);
//     path.cubicTo(8.68724, 191.97, 25.2135, 219.542, 49.3569, 239.356);
//     path.cubicTo(73.5003, 259.17, 103.767, 270, 135, 270);
//     path.lineTo(135, 135);
//     path.lineTo(230.459, 230.459);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

// class Ellipse43Painter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Color(0xFFFFFFFF)
//       ..style = PaintingStyle.fill;

//     Path path = Path();
//     path.moveTo(size.width * 0.853, size.height * 0.853);
//     path.cubicTo(size.width * 0.935, size.height * 0.772, size.width * 0.987, size.height * 0.664, size.width, size.height * 0.549);
//     path.cubicTo(size.width * 1.010, size.height * 0.434, size.width * 0.980, size.height * 0.318, size.width * 0.915, size.height * 0.222);
//     path.cubicTo(size.width * 0.850, size.height * 0.126, size.width * 0.756, size.height * 0.055, size.width * 0.645, size.height * 0.021);
//     path.cubicTo(size.width * 0.534, size.height * -0.008, size.width * 0.416, size.height * -0.006, size.width * 0.309, size.height * 0.038);
//     path.cubicTo(size.width * 0.202, size.height * 0.082, size.width * 0.113, size.height * 0.162, size.width * 0.059, size.height * 0.264);
//     path.cubicTo(size.width * 0.004, size.height * 0.366, size.width * -0.013, size.height * 0.484, size.width * 0.010, size.height * 0.598);
//     path.cubicTo(size.width * 0.032, size.height * 0.712, size.width * 0.093, size.height * 0.814, size.width * 0.183, size.height * 0.887);
//     path.cubicTo(size.width * 0.273, size.height * 0.960, size.width * 0.384, size.height * 1.000, size.width * 0.500, size.height * 1.000);
//     // path.cubicTo(size.width, size.height, size.width, size.height, size.width, size.height);
//     path.lineTo(size.width * 0.500, size.height * 0.500);
//     path.lineTo(size.width * 0.853, size.height * 0.853);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

class Ellipse43Painter extends CustomPainter {
  final int index;

  Ellipse43Painter({super.repaint, required this.index});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width * 0.853, size.height * 0.853);
    if (index > 0) path.cubicTo(size.width * 0.935, size.height * 0.772, size.width * 0.987, size.height * 0.664, size.width, size.height * 0.549);
    if (index > 1) path.cubicTo(size.width * 1.010, size.height * 0.434, size.width * 0.980, size.height * 0.318, size.width * 0.915, size.height * 0.222);
    if (index > 2) path.cubicTo(size.width * 0.850, size.height * 0.126, size.width * 0.756, size.height * 0.055, size.width * 0.645, size.height * 0.021);
    if (index > 3) path.cubicTo(size.width * 0.534, size.height * -0.008, size.width * 0.416, size.height * -0.006, size.width * 0.309, size.height * 0.038);
    if (index > 4) path.cubicTo(size.width * 0.202, size.height * 0.082, size.width * 0.113, size.height * 0.162, size.width * 0.059, size.height * 0.264);
    if (index > 5) path.cubicTo(size.width * 0.004, size.height * 0.366, size.width * -0.013, size.height * 0.484, size.width * 0.010, size.height * 0.598);
    if (index > 6) path.cubicTo(size.width * 0.032, size.height * 0.712, size.width * 0.093, size.height * 0.814, size.width * 0.183, size.height * 0.887);
    if (index > 7) path.cubicTo(size.width * 0.273, size.height * 0.960, size.width * 0.384, size.height * 1.000, size.width * 0.500, size.height * 1.000);
    if (index > 8) path.cubicTo(size.width, size.height, size.width, size.height, size.width, size.height);
    path.lineTo(size.width * 0.500, size.height * 0.500);
    path.lineTo(size.width * 0.853, size.height * 0.853);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
