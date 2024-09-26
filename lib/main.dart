import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/home_screen.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: Colors.grey,
        //   primary: Colors.black,
        //   // brightness: Brightness.dark,
        // )

        textTheme: const TextTheme(
          displayMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          labelMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
          labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        useMaterial3: true,
        primaryColor: Colors.black,
      ),
      home: HomeScreen(),
    );
  }
}
