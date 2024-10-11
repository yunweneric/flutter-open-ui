import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/onboarding_screen.dart';
import 'package:flutter_openui/utils/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      useInheritedMediaQuery: true,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Doctor App',
          theme: AppTheme.light(),
          home: const OnboardingScreen(),
        );
      },
    );
  }
}
