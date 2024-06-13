import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/home.dart';
import 'package:flutter_openui/utils/colors.dart';

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
        primaryColor: AppColors.yellow,
        scaffoldBackgroundColor: AppColors.bgColor,
      ),
      home: const HomeScreen(),
    );
  }
}
