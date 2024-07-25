import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_nike_slider/utils/colors.dart';
import 'package:flutter_nike_slider/components/follow.dart';
import 'package:flutter_nike_slider/components/navbar.dart';
import 'package:flutter_nike_slider/utils/sizing.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int activeIndex = 5;
  final duration = const Duration(milliseconds: 1400);
  AnimationController? _controller;
  Animation<double>? _widthAnimation;
  Animation<double>? _textTranslationAnimation;
  Animation<double>? _widthReduceAnimation;
  Animation<double>? _shoeRotationAnimation;
  Animation<double>? _textRotationAnimation;
  bool hasReversed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    Timer(const Duration(seconds: 1), () {
      setAnimatedValues(5, context);
      _toggleAnimation(5);
    });
  }

  curve(ctrl) => CurvedAnimation(parent: ctrl, curve: Curves.bounceOut);

  setAnimatedValues(int index, BuildContext? context) {
    if (context != null) {
      _widthAnimation = Tween<double>(
        begin: Sizing.isMobile(context) ? Sizing.height(context) / 3 : Sizing.width(context) / 3,
        end: Sizing.isMobile(context) ? Sizing.height(context) : Sizing.width(context),
      ).animate(curve(_controller!));

      _textTranslationAnimation = Tween<double>(
        begin: Sizing.isMobile(context) ? 0.8 : 1.9,
        end: Sizing.isMobile(context) ? 1.9 : 2.5,
      ).animate(curve(_controller!));

      _widthReduceAnimation = Tween<double>(
        begin: Sizing.isMobile(context) ? Sizing.height(context) / 3 : Sizing.width(context) / 3,
        end: 0,
      ).animate(curve(_controller!));

      _shoeRotationAnimation = Tween<double>(
        begin: -0.7,
        end: -0.0,
      ).animate(curve(_controller!));

      _textRotationAnimation = Tween<double>(
        begin: 0.0,
        end: pi * -0.5,
      ).animate(curve(_controller!));
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _toggleAnimation(int index) async {
    if (index == activeIndex) {
      if (hasReversed) {
        _controller?.forward();
        setState(() => hasReversed = !hasReversed);
      } else {
        _controller?.reverse();
        setState(() => hasReversed = !hasReversed);
      }
    } else {
      _controller?.forward();
    }
    setState(() => activeIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Wrap(
              children: [
                ...[0, 1, 2].map((index) {
                  return AnimatedBuilder(
                    animation: _controller!,
                    builder: (context, _) {
                      return nikeSlide(context, index);
                    },
                  );
                }).toList()
              ],
            ),
          ),
          if (Sizing.isDesktop(context))
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Follow(activeIndex: activeIndex),
            ),
          if (Sizing.isDesktop(context))
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: NavBar(),
            ),
        ],
      ),
    );
  }

  Widget nikeSlide(BuildContext context, int index) {
    return Builder(builder: (context) {
      final width = Sizing.isMobile(context)
          ? Sizing.width(context)
          : index == activeIndex
              ? _widthAnimation?.value ?? Sizing.width(context) / 3
              : _widthReduceAnimation?.value ?? Sizing.width(context) / 3;
      final height = Sizing.isMobile(context)
          ? index == activeIndex
              ? _widthAnimation?.value ?? Sizing.height(context) / 3
              : _widthReduceAnimation?.value ?? Sizing.height(context) / 3
          : Sizing.height(context);

      return AnimatedContainer(
        duration: duration,
        curve: Curves.bounceOut,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: index == 0
              ? AppColors.blue
              : index == 1
                  ? AppColors.red
                  : AppColors.yellow,
        ),
        width: width,
        height: height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..scale(index == activeIndex ? _textTranslationAnimation?.value ?? 1.8 : 1.0)
                    ..rotateZ(index == activeIndex ? _textRotationAnimation?.value ?? 0.0 : 0.0),
                  child: Text(
                    index == 0
                        ? "BLUE"
                        : index == 1
                            ? "RED"
                            : "YELLOW",
                    style: GoogleFonts.poppins(
                      fontSize: 90,
                      fontWeight: FontWeight.w900,
                      color: AppColors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: InkWell(
                onTap: () => _toggleAnimation(index),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateZ(index == activeIndex ? _shoeRotationAnimation?.value ?? -0.7 : -0.7)
                    ..scale(1.0),
                  child: Image.asset("assets/images/nike_${index}.png"),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
