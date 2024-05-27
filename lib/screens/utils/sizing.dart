import 'package:flutter/material.dart';

class Sizing {
  static double kWidth(context) => MediaQuery.of(context).size.width;
  static double kHeight(context) => MediaQuery.of(context).size.height;
  static bool isMobile(BoxConstraints constraints) => constraints.maxWidth < 470;
  static bool isTablette(BoxConstraints constraints) => constraints.maxWidth > 470 && constraints.maxWidth < 1200;
  static bool isDesktop(BoxConstraints constraints) => constraints.maxWidth > 1200;
}
