import 'package:flutter/material.dart';
import 'package:flutter_openui/ui/components/helper.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: Constant.dark,
    colorScheme: ColorScheme.fromSeed(seedColor: Constant.dark),
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: Constant.textColor,
      displayColor: Constant.textColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Constant.dark,
      foregroundColor: Constant.foregroundColor,
      shape: const StadiumBorder()
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Constant.dark).apply(
        color: Constant.dark,
      ),
      subtitleTextStyle: TextStyle(fontSize: 14.0, color: Constant.textColor).apply(color: Constant.textColor)
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Constant.dark,
      unselectedItemColor: Constant.unselectedColor,
      selectedIconTheme: IconThemeData(
        color: Constant.dark,
      ),
      unselectedIconTheme: IconThemeData(
        color: Constant.unselectedColor,
      ),
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: Constant.dark
      ),
    ),
    iconTheme: IconThemeData(
      color: Constant.dark
    )
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.interTextTheme(),
  );
}