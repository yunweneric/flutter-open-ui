import 'package:flutter/material.dart';

class AppSizing {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static bool isMobile(BuildContext context) => width(context) < 480;
  static bool isTablet(BuildContext context) => width(context) > 480 && width(context) < 895;
  static bool isDesktop(BuildContext context) => width(context) > 895;
  static SizedBox k20(BuildContext context) => SizedBox(height: height(context) * 0.02);
  static SizedBox k10(BuildContext context) => SizedBox(height: height(context) * 0.01);
  static SizedBox kwSpacer(BuildContext context, double factor) => SizedBox(width: width(context) * factor);
}
