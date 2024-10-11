import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      color: AppColors.TEXTBLACK,
      fontWeight: FontWeight.w600,
      fontSize: 28.sp,
    ),
    displayMedium: GoogleFonts.inter(
      color: AppColors.TEXTBLACK,
      fontWeight: FontWeight.w600,
      fontSize: 23.sp,
    ),
    displaySmall: GoogleFonts.inter(
      color: AppColors.TEXTBLACK,
      fontWeight: FontWeight.w600,
      fontSize: 16.sp,
    ),
    bodyMedium: GoogleFonts.inter(
      color: AppColors.TEXTBLACK,
      fontSize: 14.sp,
      height: 1.5,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: GoogleFonts.inter(
      color: AppColors.TEXTGREY,
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
    ),
    labelMedium: GoogleFonts.inter(
      color: AppColors.TEXTGREY,
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
    ),
    labelSmall: GoogleFonts.inter(
      color: AppColors.TEXTGREY,
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      letterSpacing: 0,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      color: AppColors.TEXTWHITE,
      fontWeight: FontWeight.w600,
      fontSize: 28.sp,
    ),
    displayMedium: GoogleFonts.inter(
      color: AppColors.TEXTWHITE,
      fontWeight: FontWeight.w600,
      fontSize: 18.sp,
    ),
    displaySmall: GoogleFonts.inter(
      color: AppColors.TEXTWHITE,
      fontWeight: FontWeight.w600,
      fontSize: 14.sp,
    ),
    bodyMedium: GoogleFonts.inter(
      color: AppColors.TEXTGREY,
      fontWeight: FontWeight.normal,
      fontSize: 14.sp,
      height: 1.5.h,
      letterSpacing: 0.1,
    ),
    bodySmall: GoogleFonts.inter(
      color: AppColors.TEXTGREY,
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
    ),
    labelMedium: GoogleFonts.inter(
      color: AppColors.TEXTGREY,
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
    ),
    labelSmall: GoogleFonts.inter(
      color: AppColors.TEXTGREY,
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      letterSpacing: 0,
    ),
  );

  static InputDecorationTheme lightInputDecoration = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
    labelStyle: TextStyle(color: AppColors.TEXTGREY, fontSize: 14.sp, fontWeight: FontWeight.w400),
    hintStyle: TextStyle(color: AppColors.TEXTGREY, fontSize: 14.sp, fontWeight: FontWeight.w400),
    floatingLabelStyle: TextStyle(color: AppColors.TEXTGREY, fontSize: 12.sp),
    errorStyle: TextStyle(color: AppColors.RED, fontSize: 11.sp),
    border: AppSizing.mainBorder(AppColors.BGGRAY),
    enabledBorder: AppSizing.mainBorder(AppColors.BGGRAY),
    focusedBorder: AppSizing.mainFocusBorder(),
    focusedErrorBorder: AppSizing.focusedErrorBorder(),
    errorBorder: AppSizing.errorBorder(),
  );

  static InputDecorationTheme darkInputDecoration = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
    labelStyle: TextStyle(color: AppColors.TEXTGREY, fontSize: 14.sp, fontWeight: FontWeight.w400),
    hintStyle: TextStyle(color: AppColors.TEXTGREY, fontSize: 14.sp, fontWeight: FontWeight.w400),
    floatingLabelStyle: TextStyle(color: AppColors.TEXTGREY, fontSize: 12.sp),
    errorStyle: TextStyle(color: AppColors.RED, fontSize: 11.sp),
    border: AppSizing.mainBorder(AppColors.BGGRAY3),
    enabledBorder: AppSizing.mainBorder(AppColors.BGGRAY3),
    focusedBorder: AppSizing.mainFocusBorder(),
    errorBorder: AppSizing.errorBorder(),
    focusedErrorBorder: AppSizing.focusedErrorBorder(),
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
      dividerColor: AppColors.BGGRAY2,
      bottomAppBarTheme: BottomAppBarTheme(color: AppColors.BG),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.BG,
        titleTextStyle: GoogleFonts.inter(color: AppColors.TEXTBLACK, fontWeight: FontWeight.w500, fontSize: 20.sp),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColors.TEXTBLACK,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 10.w),
          textStyle: lightTextTheme.bodySmall,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.CARDCOLOR,
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 10.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          textStyle: lightTextTheme.bodySmall,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.TEXTGREY,
        side: const BorderSide(color: AppColors.BGGRAY2, width: 1),
        selectedColor: AppColors.PRIMARY,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        labelStyle: TextStyle(fontSize: 12.sp, color: AppColors.TEXTBLACK),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.BGGRAY2),
      dialogTheme: const DialogTheme(backgroundColor: AppColors.CARDCOLOR),
      iconTheme: IconThemeData(color: AppColors.TEXTGREY, size: 20.w),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      primaryColor: AppColors.PRIMARY,
      scaffoldBackgroundColor: AppColors.BGDARK,
      bottomAppBarTheme: BottomAppBarTheme(color: AppColors.BGDARK),
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
          fontSize: 20.sp,
        ),
        elevation: 20,
      ),
      iconTheme: IconThemeData(color: AppColors.TEXTGREY, size: 20.w),
      primaryIconTheme: IconThemeData(color: AppColors.TEXTGREY, size: 20.w),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.BGCARDDARK,
        side: const BorderSide(color: AppColors.BGCARDDARK, width: 1),
        selectedColor: AppColors.PRIMARY,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        labelStyle: TextStyle(fontSize: 12.sp, color: AppColors.TEXTWHITE),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.BGGRAY2),
      dialogTheme: const DialogTheme(backgroundColor: AppColors.BGCARDDARK),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 10.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          textStyle: darkTextTheme.bodySmall,
          iconColor: AppColors.BGGRAY,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 10.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          backgroundColor: AppColors.BGCARDDARK,
          textStyle: darkTextTheme.bodySmall,
          iconColor: AppColors.BGGRAY,
        ),
      ),
    );
  }
}
