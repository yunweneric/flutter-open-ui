import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_open_animate/pages/components/nar_bar.dart';
import 'package:flutter_open_animate/pages/components/shaded_bottle.dart';
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
  PageController bottleController = PageController(initialPage: 0);
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
      pageController.animateToPage(0, duration: duration, curve: Curves.easeInOutExpo);
      // bottleController.animateToPage(0, duration: duration, curve: Curves.easeInOutExpo);
      textPageController.animateToPage(1, duration: duration, curve: Curves.easeInOutExpo);
      leavePageController.animateToPage(0, duration: duration, curve: Curves.easeInOutExpo);
    } else {
      pageController.animateToPage(1, duration: duration, curve: Curves.easeInOutExpo);
      // bottleController.animateToPage(1, duration: duration, curve: Curves.easeInOutExpo);
      textPageController.animateToPage(0, duration: duration, curve: Curves.easeInOutExpo);
      leavePageController.animateToPage(1, duration: duration, curve: Curves.easeInOutExpo);
    }
    setState(() {
      activeIndex = pageController.page ?? 0.0;
    });
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

          // PageView.builder(
          //   itemCount: 2,
          //   controller: bottleController,
          //   itemBuilder: (c, i) {
          //     return AnimatedContainer(
          //       duration: Duration(milliseconds: 1000),
          //       height: Sizing.height(context),
          //       width: Sizing.width(context),
          //       color: Colors.teal.withOpacity(0.1),
          //       // child: Center(
          //       //   child: Image.asset(
          //       //     activeIndex == 0 ? "assets/images/light_pattern.png" : "assets/images/dark_pattern.png",
          //       //     fit: BoxFit.fitHeight,
          //       //   ),
          //       // ),
          //     );
          //   },
          // ),

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

          TweenAnimationBuilder(
            key: ValueKey(activeIndex),
            tween: Tween<Offset>(begin: Offset(50, 0), end: Offset(0, 0)),
            duration: duration,
            builder: (context, value, child) {
              return Transform.translate(
                offset: value,
                // child: Center(
                //   child: Image.asset("assets/images/dark_pattern.png"),
                // ),
              );
            },
          ),

          // const ShadedBottle(),

          NavBar(activeIndex: activeIndex, onToggle: animate),
        ],
      ),
    );
  }
}
