import 'package:flutter/material.dart';
import 'package:flutter_open_animate/pages/components/animated_bg.dart';
import 'package:flutter_open_animate/pages/components/clipper.dart';
import 'package:flutter_open_animate/pages/components/rotated_items.dart';
import 'package:flutter_open_animate/pages/components/toggle_items.dart';
import 'package:flutter_open_animate/pages/models/doughnut.dart';
import 'package:flutter_open_animate/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animatedAngle;

  // double rotationFactor = 1.58;
  double rotationFactor = 1.58;
  int activeIndex = 0;
  final duration = const Duration(milliseconds: 500);
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 2500));
    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    );
    _animatedAngle = Tween<double>(begin: -rotationFactor, end: 0).animate(curvedAnimation);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  animate(Doughnut item) {
    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _animatedAngle = Tween<double>(begin: activeIndex * -rotationFactor, end: rotationFactor * -item.index).animate(curvedAnimation);
    _controller.reset();
    _controller.forward();
    setState(() => activeIndex = item.index);
  }

  List<Doughnut> items = [
    Doughnut(index: 0, color: AppColors.yellow),
    Doughnut(index: 1, color: AppColors.blue),
    Doughnut(index: 2, color: AppColors.red),
    Doughnut(index: 3, color: AppColors.green),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          clipper(activeIndex, duration, items[activeIndex].color),
          ...animatedBg(duration, activeIndex, items),
          titleAndTogglers(
            context: context,
            onTap: animate,
            duration: duration,
            items: items,
            activeIndex: activeIndex,
          ),
          rotatedItems(
            context: context,
            items: items,
            controller: _controller,
            animatedAngle: _animatedAngle,
            activeIndex: activeIndex,
            duration: duration,
          ),
        ],
      ),
    );
  }
}
