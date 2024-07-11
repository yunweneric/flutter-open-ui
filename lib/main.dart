import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/home_screen.dart';
import 'package:flutter_openui/screens/splash_screen.dart';
import 'package:flutter_openui/utils/color.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.white),
        useMaterial3: true,
        primaryColor: AppColors.primary,
        primaryColorLight: AppColors.white,
        primaryColorDark: AppColors.black,
        scaffoldBackgroundColor: AppColors.white,
        textTheme: TextTheme(
          displayMedium: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w800),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
