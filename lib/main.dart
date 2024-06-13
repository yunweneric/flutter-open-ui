import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/home.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bot',
      theme: ThemeData(
        primaryColorLight: AppColors.white,
        primaryColorDark: AppColors.bgColor,
        primaryColor: AppColors.primary,
        cardColor: AppColors.bgCard,
        scaffoldBackgroundColor: AppColors.bgColor,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.inter(fontSize: 35, color: AppColors.white, fontWeight: FontWeight.w600),
          displayMedium: GoogleFonts.inter(fontSize: 20, color: AppColors.white, fontWeight: FontWeight.w500),
          displaySmall: GoogleFonts.inter(fontSize: 14, color: AppColors.white, fontWeight: FontWeight.w500),
          bodyMedium: GoogleFonts.inter(fontSize: 14, color: AppColors.white, fontWeight: FontWeight.w500),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
