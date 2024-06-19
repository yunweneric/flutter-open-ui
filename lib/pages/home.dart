import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_open_animate/pages/components/nar_bar.dart';
import 'package:flutter_open_animate/pages/components/shaded_bottle.dart';
import 'package:flutter_open_animate/pages/follow.dart';
import 'package:flutter_open_animate/utils/colors.dart';
import 'package:flutter_open_animate/utils/sizing.dart';
import 'package:flutter_open_animate/utils/theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  PageController pageController = PageController(initialPage: 0);
  PageController textPageController = PageController(initialPage: 1);
  PageController leavePageController = PageController(initialPage: 0);

  double activeIndex = 0;
  final duration = const Duration(milliseconds: 1200);
  @override
  void initState() {
    Future.delayed(duration, () => animate(AppTheme.light()));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  animate(theme) {
    if (pageController.page == 1) {
      pageController.animateToPage(0, duration: duration, curve: Curves.easeInOutExpo);
      textPageController.animateToPage(1, duration: duration, curve: Curves.easeInOutExpo);
      leavePageController.animateToPage(0, duration: duration, curve: Curves.easeInOutExpo);
    } else {
      pageController.animateToPage(1, duration: duration, curve: Curves.easeInOutExpo);
      textPageController.animateToPage(0, duration: duration, curve: Curves.easeInOutExpo);
      leavePageController.animateToPage(1, duration: duration, curve: Curves.easeInOutExpo);
    }
    setState(() {
      activeIndex = pageController.page ?? 0.0;
    });
    theme.updateTheme(
      theme.currentTheme == AppTheme.light() ? AppTheme.dark() : AppTheme.light(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        final theme = Provider.of<AppTheme>(context, listen: true);
        return Stack(
          children: [
            PageView.builder(
              itemCount: 2,
              controller: pageController,
              itemBuilder: (c, i) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  height: Sizing.height(context),
                  width: Sizing.width(context),
                  // color: theme.currentTheme == AppTheme.dark() ? AppColors.bgBlack : AppColors.bgWhite,
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
                    i == 1 ? "DARK" : "LIGHT",
                    style: TextStyle(
                      fontSize: 300,
                      color: i == 0 ? AppColors.textBlack : AppColors.textWhite,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                );
              },
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
            ShadedBottle(activeIndex: activeIndex, duration: duration),
            NavBar(onToggle: () => animate(theme)),
            Positioned(bottom: 10, left: 0, right: 0, child: Follow(activeIndex: activeIndex))
          ],
        );
      }),
    );
  }
}
