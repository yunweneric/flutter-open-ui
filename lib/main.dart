import 'package:flutter/material.dart';
import 'package:flutter_open_animate/pages/home.dart';
import 'package:flutter_open_animate/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Doughnuts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 55, fontWeight: FontWeight.w700),
          displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          displaySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.yellow),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
