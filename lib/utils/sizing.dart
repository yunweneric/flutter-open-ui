import 'package:flutter/material.dart';

class Sizing {
  static double width(context) => MediaQuery.of(context).size.width;
  static double height(context) => MediaQuery.of(context).size.height;

  static bool isXMobile(context) => width(context) < 380;
  static bool isMobile(context) => width(context) < 789;
  static bool isTablet(context) => width(context) > 789 && width(context) < 992;
  static bool isDesktop(context) => width(context) > 992;
}
