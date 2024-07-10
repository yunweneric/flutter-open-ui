import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/components/pizza_loader.dart';
import 'package:flutter_openui/screens/home_screen.dart';
import 'package:flutter_openui/screens/routes/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      // AppRouter.navigate(context, const HomeScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: PizzaLoader(),
      ),
    );
  }
}
