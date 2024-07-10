import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_openui/utils/color.dart';
import 'package:flutter_openui/utils/sizing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? heighController;

  final duration = const Duration(milliseconds: 500);

  @override
  void initState() {
    heighController = AnimationController(vsync: this, duration: duration);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: AppSizing.height(context) * 0.6,
            color: AppColors.primary,
          ),
          Container(
            height: AppSizing.height(context) * 0.6,
          ),
        ],
      ),
    );
  }
}
