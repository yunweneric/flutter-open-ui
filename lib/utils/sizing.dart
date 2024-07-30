import 'package:flutter/material.dart';

class AppSizing {
  static width(BuildContext context) => MediaQuery.of(context).size.width;
  static height(BuildContext context) => MediaQuery.of(context).size.height;
  static k10Spacer(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.01,
      );
}
