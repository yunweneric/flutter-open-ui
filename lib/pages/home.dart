import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_open_animate/pages/components/nar_bar.dart';
import 'package:flutter_open_animate/pages/models/doughnut.dart';
import 'package:flutter_open_animate/utils/colors.dart';
import 'package:flutter_open_animate/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animatedAngle;
  PageController pageController = PageController(initialPage: 0);
  PageController textPageController = PageController(initialPage: 1);
  PageController leavePageController = PageController(initialPage: 0);
  double activeIndex = 0;
  final duration = const Duration(milliseconds: 1500);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  animate() {
    if (pageController.page == 1) {
      pageController.animateToPage(0, duration: duration, curve: Curves.easeInOutExpo).whenComplete(() {
        setState(() {
          activeIndex = pageController.page ?? 0.0;
        });
      });
      textPageController.animateToPage(1, duration: duration, curve: Curves.easeInOutExpo);
      leavePageController.animateToPage(0, duration: duration, curve: Curves.easeInOutExpo);
    } else {
      textPageController.animateToPage(0, duration: duration, curve: Curves.easeInOutExpo);
      pageController.animateToPage(1, duration: duration, curve: Curves.easeInOutExpo).whenComplete(() {
        setState(() {
          activeIndex = pageController.page ?? 0.0;
        });
      });
      leavePageController.animateToPage(1, duration: duration, curve: Curves.easeInOutExpo);
    }
  }

  double translate = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      body: Stack(
        children: [
          // Image.asset("assets/images/dark_bottle.png"),

          Positioned(
            child: Center(
              child: Image.asset(
                "assets/images/bottle.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          // Positioned(
          //   child: Transform.translate(
          //     offset: Offset(-translate, 0),
          //     // child: Image.asset("assets/images/dark_pattern.png"),
          //     child: SvgPicture.asset("assets/images/clipper.svg"),
          //   ),
          // ),
          PageView.builder(
            itemCount: 2,
            controller: pageController,
            itemBuilder: (c, i) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                height: Sizing.height(context),
                width: Sizing.width(context),
                color: i == 0 ? AppColors.textBlack : AppColors.bgWhite,
              );
            },
          ),
          PageView.builder(
            itemCount: 2,
            controller: textPageController,
            itemBuilder: (c, i) {
              return Center(
                child: Text(
                  i == 0 ? "DARK" : "LIGHT",
                  style: TextStyle(
                    fontSize: 300,
                    color: i == 0 ? AppColors.textBlack : AppColors.textWhite,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              );
            },
          ),
          Center(
            child: Image.asset(
              "assets/images/bottle.png",
              fit: BoxFit.fitHeight,
            ),
          ),
          PageView.builder(
            itemCount: 2,
            scrollDirection: Axis.vertical,
            controller: leavePageController,
            itemBuilder: (c, i) {
              return Transform.translate(
                offset: Offset(0, Sizing.height(context) * 0.1),
                child: Container(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 2.5),
                    child: SvgPicture.asset(i == 1 ? "assets/images/dark_leaves.svg" : "assets/images/light_leaves.svg"),
                  ),
                ),
              );
            },
          ),

          //  PageView.builder(
          //   itemCount: 2,
          //   controller: pageController,
          //   itemBuilder: (c, i) {
          //     return AnimatedContainer(
          //       duration: Duration(milliseconds: 1000),
          //       height: Sizing.height(context),
          //       width: Sizing.width(context),
          //       child: Center(
          //         child: Image.asset(
          //           "assets/images/bottle.png",
          //           fit: BoxFit.fitHeight,
          //         ),
          //       ),
          //       color: i == 0 ? AppColors.textBlack : AppColors.bgWhite,
          //     );
          //   },
          // ),

          // Slider(
          //     min: -1000,
          //     max: 1000,
          //     value: translate,
          //     onChanged: (val) {
          //       setState(() {
          //         translate = val;
          //       });
          //     }),

          Center(
            child: ElevatedButton(
              onPressed: () => animate(),
              child: Text("toggle"),
            ),
          ),

          NavBar(activeIndex: activeIndex),
        ],
      ),
    );
  }
}
