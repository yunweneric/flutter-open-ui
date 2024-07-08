import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fruits_animation/components/carousel_card.dart';
import 'package:flutter_fruits_animation/components/follow.dart';
import 'package:flutter_fruits_animation/utils/colors.dart';
import 'package:flutter_fruits_animation/utils/nav_bar.dart';
import 'package:flutter_fruits_animation/utils/sizing.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  final gradientColors = [
    HomeGradient(0, AppColors.strawberry, AppColors.strawberry_light, "Strawberry"),
    HomeGradient(1, AppColors.orange, AppColors.orange_light, "Orange"),
    HomeGradient(2, AppColors.apple, AppColors.apple_light, "Apple"),
  ];
  int activeIndex = 0;
  final duration = const Duration(milliseconds: 2000);
  AnimationController? _controller;
  Animation<double>? _rotationAnimation;
  Animation<Offset>? _textTranslationAnimation;
  Animation<Offset>? _fruitsTranslationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration); // Repeats the animation
    setAnimatedValues(2);
    _toggleAnimation(2);
  }

  CurvedAnimation curve(ctrl) => CurvedAnimation(parent: ctrl, curve: Curves.elasticOut);
  setAnimatedValues(index) {
    _rotationAnimation = Tween<double>(
      begin: index > activeIndex ? 0.4 * 3.14159 : -0.4 * 3.14159,
      end: 0,
    ).animate(curve(_controller!));

    _textTranslationAnimation = Tween<Offset>(
      begin: index > activeIndex ? Offset(1000, 0) : Offset(-1000, 0),
      end: Offset.zero,
    ).animate(curve(_controller!));

    _fruitsTranslationAnimation = Tween<Offset>(
      begin: index > activeIndex ? Offset(0, 1000) : Offset(0, -1000),
      end: Offset.zero,
    ).animate(curve(_controller!));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _toggleAnimation(index) async {
    if (index != activeIndex) {
      setAnimatedValues(index);
      _controller?.reset();
      _controller?.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: duration,
            curve: Curves.elasticOut,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [gradientColors[activeIndex].light, gradientColors[activeIndex].color],
                radius: 0.6,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedBuilder(
                animation: _controller!,
                builder: (context, _) {
                  return Transform.translate(
                    offset: _textTranslationAnimation?.value ?? Offset.zero,
                    child: Text(
                      gradientColors[activeIndex].title.toUpperCase(),
                      style: const TextStyle(fontSize: 160, fontWeight: FontWeight.w900, color: AppColors.white),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ),
          AnimatedBuilder(
              animation: _controller!,
              builder: (context, _) {
                return Transform.translate(
                  offset: _fruitsTranslationAnimation?.value ?? Offset.zero,
                  child: Image.asset(
                    "assets/images/fruit_$activeIndex.png",
                    fit: BoxFit.cover,
                    height: Sizing.height(context),
                    width: Sizing.width(context),
                  ),
                );
              }),
          Positioned(
            top: 0,
            bottom: 0,
            left: Sizing.width(context) / 3,
            right: Sizing.width(context) / 3,
            child: AnimatedBuilder(
              animation: _controller!,
              builder: (context, _) {
                return Transform(
                  transform: Matrix4.rotationZ(_rotationAnimation?.value ?? 0),
                  child: Transform.scale(scale: 2.5, child: Image.asset("assets/images/can_$activeIndex.png")),
                );
              },
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: Sizing.width(context) / 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.white, width: Sizing.width(context) / 300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...gradientColors.map(
                        (item) => CarouselCard(
                          index: item.index,
                          activeIndex: activeIndex,
                          onTap: () {
                            print('$item');
                            _toggleAnimation(item.index);
                            setState(() => activeIndex = item.index);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            child: Follow(
              activeIndex: activeIndex,
              duration: duration,
            ),
          ),
          const Positioned(top: 0, child: NavBar()),
        ],
      ),
    );
  }

  carouselCard({required int index, required VoidCallback onTap}) {
    return MouseRegion(
      onEnter: (event) {},
      child: InkWell(
        mouseCursor: MaterialStateMouseCursor.clickable,
        onTap: () => onTap(),
        child: Container(
          height: Sizing.height(context) / 6,
          width: Sizing.width(context) / 12 - Sizing.width(context) / 450,
          decoration: BoxDecoration(
            color: index == 0
                ? AppColors.strawberry
                : index == 1
                    ? AppColors.orange
                    : AppColors.apple,
            border: BorderDirectional(
              start: index == 0 ? BorderSide.none : BorderSide(color: AppColors.white, width: Sizing.width(context) / 450),
              end: index == 2 ? BorderSide.none : BorderSide(color: AppColors.white, width: Sizing.width(context) / 450),
            ),
          ),
          child: Image.asset("assets/images/card_${index}.png"),
        ),
      ),
    );
  }
}

class HomeGradient {
  final int index;
  final Color color;
  final Color light;
  final String title;

  HomeGradient(this.index, this.color, this.light, this.title);
}
