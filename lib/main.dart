import 'package:flutter/material.dart';
import 'package:flutter_open_animate/pages/home.dart';
import 'package:flutter_open_animate/utils/colors.dart';
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
      title: 'Animated Dark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          displayLarge: GoogleFonts.cabin(fontSize: 55, fontWeight: FontWeight.w700),
          displayMedium: GoogleFonts.cabin(fontSize: 20, fontWeight: FontWeight.w700),
          displaySmall: GoogleFonts.cabin(fontSize: 18, fontWeight: FontWeight.w700),
          bodyMedium: GoogleFonts.cabin(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
