import 'package:flutter/material.dart';

class AppSizing {
  static height(context) => MediaQuery.of(context).size.height;
  static width(context) => MediaQuery.of(context).size.width;
  static k10(context) => SizedBox(height: MediaQuery.of(context).size.height * 0.01);
  static k20(context) => SizedBox(height: MediaQuery.of(context).size.height * 0.03);
}
