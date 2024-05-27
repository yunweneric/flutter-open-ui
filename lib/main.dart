import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/onboarding/onboarding.dart';
import 'package:flutter_openui/screens/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', theme: AppTheme.dark, home: const OnboardingScreen());
  }
}
