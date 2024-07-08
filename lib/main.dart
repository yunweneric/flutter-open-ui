import 'package:flutter/material.dart';
import 'package:flutter_nike_slider/pages/home.dart';
import 'package:flutter_nike_slider/utils/colors.dart';
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
      title: 'NatGeo Wild',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.yellow),
        useMaterial3: true,
        primaryColorDark: AppColors.black,
        primaryColorLight: AppColors.white,
        primaryColor: AppColors.yellow,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.inter(color: AppColors.white, fontSize: 48),
          displayMedium: GoogleFonts.inter(color: AppColors.white, fontSize: 16),
          displaySmall: GoogleFonts.inter(color: AppColors.white, fontSize: 12),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
