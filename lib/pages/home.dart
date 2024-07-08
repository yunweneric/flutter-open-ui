import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_open_animate/pages/components/animated_counter.dart';
import 'package:flutter_open_animate/pages/components/animated_text.dart';
import 'package:flutter_open_animate/pages/components/nar_bar.dart';
import 'package:flutter_open_animate/pages/components/shaded_bottle.dart';
import 'package:flutter_open_animate/pages/components/stacked_circles.dart';
import 'package:flutter_open_animate/pages/components/watch_slider.dart';
import 'package:flutter_open_animate/pages/models/watch.dart';
import 'package:flutter_open_animate/utils/colors.dart';
import 'package:flutter_open_animate/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  PageController textController = PageController(initialPage: 0);
  PageController pageController = PageController(initialPage: 0);
  int activeIndex = 0;
  final duration = const Duration(milliseconds: 1500);

  animate(int index) {
    pageController.animateToPage(index, duration: duration, curve: Curves.easeInOutExpo);
    textController.animateToPage(index, duration: duration, curve: Curves.easeInOutExpo);
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<AppWatch> watches = [
      AppWatch(index: 0, color: Colors.redAccent, borderColor: Color(0xFFFFF2F2)),
      AppWatch(index: 1, color: Colors.blueAccent, borderColor: Color(0xFFD0E0F8)),
      AppWatch(index: 2, color: Colors.yellow, borderColor: Color.fromARGB(255, 255, 254, 245)),
      AppWatch(index: 3, color: Colors.orange, borderColor: Color(0xFFFFF8EE)),
      AppWatch(index: 4, color: Colors.redAccent, borderColor: Color(0xFFFFF2F2)),
      AppWatch(index: 5, color: Colors.purpleAccent, borderColor: Color(0xFFFCEAFF)),
    ];
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            child: SvgPicture.asset(
              "assets/icons/eclipse_left.svg",
              height: Sizing.height(context),
              width: Sizing.width(context) * 0.3,
            ),
          ),
          Positioned(
            // right: Sizing.width(context) * -0.1,
            right: 0,
            child: SvgPicture.asset(
              "assets/icons/eclipse_right.svg",
              height: Sizing.height(context),
              width: Sizing.width(context) * 0.7,
            ),
          ),
          Positioned(
            right: -20,
            child: SizedBox(
              height: Sizing.height(context),
              child: const Center(
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    "WATCHES",
                    style: TextStyle(fontSize: 120, color: AppColors.textGray, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
          ),
          AnimatedText(
            textController: textController,
            activeIndex: activeIndex,
            watches: watches,
          ),
          AnimatedCounter(
            watches: watches,
            activeIndex: activeIndex,
            onTap: animate,
            duration: duration,
          ),
          StackedCircles(
            pageController: pageController,
            watches: watches,
            activeIndex: activeIndex,
          ),
          NavBar(activeIndex: activeIndex)
        ],
      ),
    );
  }
}
