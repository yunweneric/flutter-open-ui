import 'package:flutter/material.dart';
import 'package:flutter_openui/shared/utils/basuu_colors.dart';
import 'package:flutter_openui/shared/utils/sizing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BasuuTheme {
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      color: BasuuColors.TEXTWHITE,
      fontWeight: FontWeight.w800,
      fontSize: 28.sp,
    ),
    displayMedium: GoogleFonts.inter(
      color: BasuuColors.TEXTWHITE,
      fontWeight: FontWeight.w600,
      fontSize: 16.sp,
    ),
    displaySmall: GoogleFonts.inter(
      color: BasuuColors.TEXTWHITE,
      fontWeight: FontWeight.w600,
      fontSize: 12.sp,
    ),
    bodyMedium: GoogleFonts.inter(
      color: BasuuColors.TEXTWHITE,
      fontWeight: FontWeight.normal,
      fontSize: 14.sp,
      height: 1.5.h,
      letterSpacing: 0.1,
    ),
    bodySmall: GoogleFonts.inter(
      color: BasuuColors.TEXTWHITE,
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
    ),
    labelMedium: GoogleFonts.inter(
      color: BasuuColors.TEXTGREY,
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
    ),
    labelSmall: GoogleFonts.inter(
      color: BasuuColors.TEXTGREY,
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      letterSpacing: 0,
    ),
  );

  static InputDecorationTheme lightInputDecoration = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
    labelStyle: TextStyle(color: BasuuColors.TEXTGREY, fontSize: 16.sp, fontWeight: FontWeight.w400),
    hintStyle: TextStyle(color: BasuuColors.TEXTGREY, fontSize: 16.sp, fontWeight: FontWeight.w400),
    floatingLabelStyle: TextStyle(color: BasuuColors.TEXTGREY, fontSize: 12.sp),
    errorStyle: TextStyle(color: BasuuColors.RED, fontSize: 11.sp),
    border: AppSizing.mainBorder(BasuuColors.BGGRAY),
    enabledBorder: AppSizing.mainBorder(BasuuColors.BGGRAY),
    focusedBorder: AppSizing.mainFocusBorder(),
    focusedErrorBorder: AppSizing.focusedErrorBorder(),
    errorBorder: AppSizing.errorBorder(),
  );

  static InputDecorationTheme darkInputDecoration = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
    labelStyle: TextStyle(color: BasuuColors.TEXTGREY, fontSize: 16.sp, fontWeight: FontWeight.w400),
    hintStyle: TextStyle(color: BasuuColors.TEXTGREY, fontSize: 16.sp, fontWeight: FontWeight.w400),
    floatingLabelStyle: TextStyle(color: BasuuColors.TEXTGREY, fontSize: 12.sp),
    errorStyle: TextStyle(color: BasuuColors.RED, fontSize: 11.sp),
    border: AppSizing.mainBorder(BasuuColors.BGGRAY3),
    enabledBorder: AppSizing.mainBorder(BasuuColors.BGGRAY3),
    focusedBorder: AppSizing.mainFocusBorder(),
    errorBorder: AppSizing.errorBorder(),
    focusedErrorBorder: AppSizing.focusedErrorBorder(),
  );

  static ThemeData dark() {
    return ThemeData(
      primaryColor: BasuuColors.PRIMARY,
      scaffoldBackgroundColor: BasuuColors.BGDARK,
      primaryColorDark: BasuuColors.TEXTWHITE,
      primaryColorLight: BasuuColors.TEXTBLACK,
      cardColor: BasuuColors.BGCARDDARK,
      colorScheme: const ColorScheme.dark(primary: BasuuColors.PRIMARY, error: BasuuColors.RED),
      cardTheme: const CardTheme(color: BasuuColors.BGCARDDARK),
      textTheme: darkTextTheme,
      dividerColor: BasuuColors.BGCARDDARK,
      highlightColor: BasuuColors.BGGRAY,
      inputDecorationTheme: darkInputDecoration,
      appBarTheme: AppBarTheme(
        backgroundColor: BasuuColors.BGDARK,
        surfaceTintColor: BasuuColors.BGDARK,
        titleTextStyle: GoogleFonts.inter(
          color: BasuuColors.TEXTWHITE,
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
        elevation: 20,
      ),
      iconTheme: IconThemeData(color: BasuuColors.TEXTGREY, size: 20.w),
      primaryIconTheme: IconThemeData(color: BasuuColors.TEXTGREY, size: 20.w),
      chipTheme: ChipThemeData(
        backgroundColor: BasuuColors.BGCARDDARK,
        side: const BorderSide(color: BasuuColors.BGCARDDARK, width: 1),
        selectedColor: BasuuColors.PRIMARY,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        labelStyle: TextStyle(fontSize: 12.sp, color: BasuuColors.TEXTWHITE),
      ),
      dividerTheme: const DividerThemeData(color: BasuuColors.BGGRAY2),
      dialogTheme: const DialogTheme(backgroundColor: BasuuColors.BGCARDDARK),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 10.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          textStyle: darkTextTheme.bodySmall,
          iconColor: BasuuColors.BGGRAY,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 10.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          backgroundColor: BasuuColors.BGCARDDARK,
          textStyle: darkTextTheme.bodySmall,
          iconColor: BasuuColors.BGGRAY,
        ),
      ),
    );
  }
}
