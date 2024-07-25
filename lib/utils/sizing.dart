import 'package:flutter/material.dart';

class Sizing {
  static double width(context) => MediaQuery.of(context).size.width;
  static double height(context) => MediaQuery.of(context).size.height;
  static bool isMobile(context) => width(context) <= 889;
  static bool isDesktop(context) => width(context) > 889;
}
