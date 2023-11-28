import 'package:flutter/material.dart';
import 'package:flutter_openui/routes.dart';
import 'package:flutter_openui/theme/app_themes.dart';
import 'package:flutter_openui/ui/pages/home.dart';
import 'package:get/get.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To Do App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      getPages: pages,
      home: const HomePage(),
    );
  }
}
