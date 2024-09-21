import 'package:flutter/material.dart';
import 'package:flutter_openui/presentation/screens/home_screen.dart';
import 'package:flutter_openui/presentation/screens/splash_screen.dart';
import 'package:flutter_openui/shared/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ScreenUtilInit(
          designSize: Size(constraints.maxWidth, constraints.maxHeight),
          useInheritedMediaQuery: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: AppTheme.dark(),
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}
