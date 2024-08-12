import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      color: AppColors.TEXTBLACK,
      fontWeight: FontWeight.w400,
      fontSize: 30,
    ),
    displayMedium: GoogleFonts.inter(
      color: AppColors.TEXTBLACK,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    displaySmall: GoogleFonts.inter(
      color: AppColors.TEXTBLACK,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
    bodyMedium: GoogleFonts.inter(
      color: AppColors.TEXTBLACK,
      fontSize: 14,
      height: 1.5,
      letterSpacing: 0.1,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: GoogleFonts.inter(
      color: AppColors.TEXTBLACK,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    labelMedium: GoogleFonts.inter(
      color: AppColors.TEXTGREY,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    labelSmall: GoogleFonts.inter(
      color: AppColors.TEXTGREY,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: 0,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      color: AppColors.TEXTWHITE,
      fontWeight: FontWeight.w800,
      fontSize: 30,
    ),
    displayMedium: GoogleFonts.inter(
      color: AppColors.TEXTWHITE,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    displaySmall: GoogleFonts.inter(
      color: AppColors.TEXTWHITE,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
    bodyMedium: GoogleFonts.inter(
      color: AppColors.TEXTGREY,
      fontWeight: FontWeight.normal,
      fontSize: 14,
      height: 1.5,
      letterSpacing: 0.1,
    ),
    bodySmall: GoogleFonts.inter(
      color: AppColors.TEXTGREY,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    labelMedium: GoogleFonts.inter(
      color: AppColors.TEXTGREY,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    labelSmall: GoogleFonts.inter(
      color: AppColors.TEXTGREY,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: 0,
    ),
  );

  static InputDecorationTheme lightInputDecoration = const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    labelStyle: TextStyle(color: AppColors.TEXTGREY, fontSize: 16, fontWeight: FontWeight.w400),
    hintStyle: TextStyle(color: AppColors.TEXTGREY, fontSize: 16, fontWeight: FontWeight.w400),
    floatingLabelStyle: TextStyle(color: AppColors.TEXTGREY, fontSize: 12),
    errorStyle: TextStyle(color: AppColors.RED, fontSize: 11),
  );

  static InputDecorationTheme darkInputDecoration = const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    labelStyle: TextStyle(color: AppColors.TEXTGREY, fontSize: 16, fontWeight: FontWeight.w400),
    hintStyle: TextStyle(color: AppColors.TEXTGREY, fontSize: 16, fontWeight: FontWeight.w400),
    floatingLabelStyle: TextStyle(color: AppColors.TEXTGREY, fontSize: 12),
    errorStyle: TextStyle(color: AppColors.RED, fontSize: 11),
  );

  static ThemeData light() {
    return ThemeData(
      colorScheme: const ColorScheme.light(primary: AppColors.PRIMARY, error: AppColors.RED),
      primaryColor: AppColors.PRIMARY,
      primaryColorDark: AppColors.TEXTBLACK,
      primaryColorLight: AppColors.TEXTWHITE,
      scaffoldBackgroundColor: AppColors.BG,
      cardTheme: const CardTheme(color: AppColors.CARDCOLOR),
      highlightColor: AppColors.BGGRAY,
      cardColor: AppColors.CARDCOLOR,
      textTheme: lightTextTheme,
      inputDecorationTheme: lightInputDecoration,
      dividerColor: AppColors.BGGRAY2.withOpacity(0.3),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.BG,
        titleTextStyle: GoogleFonts.inter(color: AppColors.TEXTBLACK, fontWeight: FontWeight.w500, fontSize: 20),
        elevation: 0,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          // side: const BorderSide(color: AppColors.BGGRAY3),
          backgroundColor: AppColors.CARDCOLOR,
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.TEXTGREY,
        side: const BorderSide(color: AppColors.BGGRAY2, width: 1),
        selectedColor: AppColors.PRIMARY,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        labelStyle: TextStyle(fontSize: 12, color: AppColors.TEXTBLACK),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.BGGRAY2),
      dialogTheme: const DialogTheme(backgroundColor: AppColors.CARDCOLOR),
      iconTheme: IconThemeData(color: AppColors.TEXTGREY, size: 20),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      primaryColor: AppColors.PRIMARY,
      scaffoldBackgroundColor: AppColors.BGDARK,
      primaryColorDark: AppColors.BGGRAY,
      primaryColorLight: AppColors.TEXTBLACK,
      cardColor: AppColors.BGCARDDARK,
      colorScheme: const ColorScheme.dark(primary: AppColors.PRIMARY, error: AppColors.RED),
      cardTheme: const CardTheme(color: AppColors.BGCARDDARK),
      textTheme: darkTextTheme,
      dividerColor: AppColors.BGCARDDARK,
      highlightColor: AppColors.BGGRAY,
      inputDecorationTheme: darkInputDecoration,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.BGDARK,
        titleTextStyle: GoogleFonts.inter(
          color: AppColors.TEXTWHITE,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
        elevation: 20,
      ),
      iconTheme: IconThemeData(color: AppColors.TEXTGREY, size: 20),
      primaryIconTheme: IconThemeData(color: AppColors.TEXTGREY, size: 20),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.BGCARDDARK,
        side: const BorderSide(color: AppColors.BGCARDDARK, width: 1),
        selectedColor: AppColors.PRIMARY,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        labelStyle: TextStyle(fontSize: 12, color: AppColors.TEXTWHITE),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.BGGRAY2),
      dialogTheme: const DialogTheme(backgroundColor: AppColors.BGCARDDARK),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: darkTextTheme.bodyMedium,
          iconColor: AppColors.BGGRAY,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: AppColors.BGCARDDARK,
          textStyle: darkTextTheme.bodyMedium,
          iconColor: AppColors.BGGRAY,
        ),
      ),
    );
  }
}
