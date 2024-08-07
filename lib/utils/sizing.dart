import 'package:flutter/material.dart';

class AppSizing {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static bool isMobile(BuildContext context) => width(context) < 480;
  static bool isTablet(BuildContext context) => width(context) > 480 && width(context) < 895;
  static bool isDesktop(BuildContext context) => width(context) > 895;
  static SizedBox kh10(BuildContext context) => SizedBox(height: 10);
  static SizedBox khSpacer(double height) => SizedBox(height: height);
  static SizedBox kh20(BuildContext context) => SizedBox(height: 20);
  static SizedBox kw20(BuildContext context) => SizedBox(width: 20);
}
