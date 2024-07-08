import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    return MaterialApp(
      title: 'Fruity Lips',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.yellow,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
