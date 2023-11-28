import 'package:flutter/material.dart';

class ContextVariables {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
}

class ImagePath {
  // Avatars
  static const String avatar = 'assets/images/avatars/Avatar.png';
  static const String avatar1 = 'assets/images/avatars/Avatar_1.png';
  static const String avatar2 = 'assets/images/avatars/Avatar_2.png';
  static const String avatar3 = 'assets/images/avatars/Avatar_3.png';
  static const String logo_jf = 'assets/images/avatars/logo_jf.png';
}

class Constant {
  // bg & fg colors
  static Color backgroundColor = const Color(0xFFF9F9FB);
  static Color foregroundColor = const Color(0xFFFFFFFF);

  // accent colors
  static Color purple = const Color(0xFF7F56D9);
  static Color deepPurple = const Color(0xFF53389E);
  static Color surfacePurple = const Color(0xFFF4EBFF).withOpacity(0.3);
  static Color surfaceRed = const Color(0xFFF02D3A).withOpacity(0.1);
  static Color deepRed = const Color(0xFFF02D3A);
  static Color deepGreen = const Color(0xFF039855);
  static Color surfaceGreen = const Color(0xFF039855).withOpacity(0.1);

  // generic colors
  static Color dark = const Color(0xFF111322);
  static Color textColor = const Color(0xFF4A5578);
  static Color borderColor = const Color(0xFFDCDFEA);
  static Color unselectedColor = const Color(0xFFB9C0D4);

  // padding
  static EdgeInsets listviewPadding = const EdgeInsets.symmetric(horizontal: 16.0);
}

Widget listHeading(BuildContext context, {required String heading}) => Text(
  heading,
  style: Theme.of(context)
      .textTheme
      .titleLarge
      ?.copyWith(fontWeight: FontWeight.bold),
);