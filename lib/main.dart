import 'package:flutter/material.dart';
import 'package:flutter_3d_nike_shop/pages/home.dart';

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
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 55, fontWeight: FontWeight.w700),
          displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          displaySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
