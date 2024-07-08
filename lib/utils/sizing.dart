import 'package:flutter/material.dart';

class Sizing {
  static double width(context) => MediaQuery.of(context).size.width;
  static double height(context) => MediaQuery.of(context).size.height;
  static bool isMobile(BoxConstraints constraints) => constraints.maxWidth <= 480;
  static bool isTablet(BoxConstraints constraints) => constraints.maxWidth > 480 && constraints.maxWidth <= 768;
  static bool isDesktop(BoxConstraints constraints) => constraints.maxWidth > 768;
}
