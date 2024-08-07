import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/home_screen.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.poppins(fontSize: 50, fontWeight: FontWeight.w900),
          displayMedium: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
          displaySmall: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          bodyMedium: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
