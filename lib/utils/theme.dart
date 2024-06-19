import 'package:flutter/material.dart';
import 'package:flutter_open_animate/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme extends ChangeNotifier {
  ThemeData currentTheme = light();

  void updateTheme(ThemeData themeData) {
    currentTheme = themeData;
    notifyListeners();
  }

  static ThemeData light() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.bgBlack,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(fontSize: 55, fontWeight: FontWeight.w800),
        displayMedium: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700),
        displaySmall: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.bgBlack),
      primaryColorDark: AppColors.textBlack,
      primaryColorLight: AppColors.textWhite,
      useMaterial3: true,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.bgWhite,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(fontSize: 55, fontWeight: FontWeight.w800),
        displayMedium: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700),
        displaySmall: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.bgBlack),
      primaryColorDark: AppColors.textWhite,
      primaryColorLight: AppColors.textBlack,
      useMaterial3: true,
    );
  }
}
