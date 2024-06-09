import 'package:flutter/material.dart';
import 'package:flutter_fruits_animation/utils/colors.dart';
import 'package:flutter_fruits_animation/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 3D Carousel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.strawberry),
        useMaterial3: true,
        primaryColor: AppColors.strawberry,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}
