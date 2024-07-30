import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/home_screen.dart';
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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
        primaryColor: AppColor.primaryColor,
        scaffoldBackgroundColor: AppColor.bgColor,
        primaryColorLight: AppColor.white,
        primaryColorDark: AppColor.black,
        highlightColor: AppColor.gray,
      ),
      home: const HomeScreen(),
    );
  }
}
