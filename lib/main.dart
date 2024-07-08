import 'package:flutter/material.dart';
import 'package:flutter_car_rental/pages/home.dart';
import 'package:flutter_car_rental/utils/colors.dart';

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
      title: 'Flutter Car Rental',
      theme: ThemeData(
        primaryColor: AppColors.gray,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.gray,
          primary: AppColors.gray,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
