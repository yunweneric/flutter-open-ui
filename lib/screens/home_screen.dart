import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 2;
  final duration = const Duration(milliseconds: 700);
  final controller = PageController(viewportFraction: 0.8, initialPage: 2);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: 6,
            onPageChanged: (page) {
              controller.animateToPage(
                page,
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOutExpo,
              );
              setState(() {
                activeIndex = page;
              });
            },
            itemBuilder: (c, i) {
              return AppCard(index: i, activeIndex: activeIndex);
            },
          ),
          Positioned(
            top: AppSizing.height(context) * 0.7,
            left: 0,
            right: 0,
            child: Transform.rotate(
              angle: pi * -0.03,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [0, 1, 2, 3, 4, 5].map((item) {
                  return AnimatedContainer(
                    height: 12,
                    width: 12,
                    duration: duration,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: activeIndex == item ? Colors.grey : Colors.grey.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final int index;
  final int activeIndex;
  const AppCard({super.key, required this.index, required this.activeIndex});
  final duration = const Duration(milliseconds: 700);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        duration: duration,
        opacity: activeIndex == index ? 1 : 0,
        child: AnimatedContainer(
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateZ(activeIndex == index
                ? -0.1
                : activeIndex > index
                    ? -0.2
                    : 0.2)
            ..scale(activeIndex == index ? 1.0 : 0.5),
          duration: const Duration(milliseconds: 400),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 8),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              children: [
                Image.asset(
                  height: AppSizing.height(context) * 0.3,
                  width: AppSizing.height(context) * 0.3,
                  'assets/images/city_${index}.jpg',
                  fit: BoxFit.cover,
                ),
                Positioned(
                  right: 20,
                  top: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset("assets/icons/favorite.svg"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
