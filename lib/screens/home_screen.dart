import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_openui/utils/sizing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeTextAnimation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    fadeTextAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );

    Future.delayed(Duration(milliseconds: 700), () => controller.forward());

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<int> items = List.generate(13, (item) => item);
    return Scaffold(
      body: Transform.rotate(
        angle: 0.5 * pi,
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, val) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..scale(1.0),
                child: Opacity(
                  opacity: fadeTextAnimation.value,
                  child: ListWheelScrollView(
                    controller: ScrollController(initialScrollOffset: 200),
                    perspective: 0.009,
                    itemExtent: AppSizing.height(context) * 0.15,
                    children: items.map(
                      (index) {
                        return GestureDetector(
                          onTap: () async {},
                          child: Transform.rotate(
                            angle: -0.5 * pi,
                            child: Hero(
                              tag: index,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/images/image_${index}.jpg",
                                  fit: BoxFit.cover,
                                  width: AppSizing.width(context) * 0.3,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
