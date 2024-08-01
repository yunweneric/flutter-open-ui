import 'package:flutter/material.dart';

class AppSizing {
  static double width(context) => MediaQuery.of(context).size.width;
  static double height(context) => MediaQuery.of(context).size.height;
  static bool isMobile(context) => width(context) < 480;
  static bool isTablet(context) => width(context) > 480 && width(context) < 895;
  static bool isDesktop(context) => width(context) > 895;
}
