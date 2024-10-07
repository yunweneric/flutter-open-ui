import 'package:flutter/material.dart';
import 'package:flutter_openui/presentation/screens/basuu_splash_screen.dart';
import 'package:flutter_openui/shared/basuu_theme.dart';
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
              theme: BasuuTheme.dark(),
              home: const BasuuSplashScreen(),
            );
          },
        );
      },
    );
  }
}
