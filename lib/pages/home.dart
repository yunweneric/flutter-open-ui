import 'dart:async';

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
  final duration = const Duration(milliseconds: 400);
  AnimationController? _controller;
  Animation<double>? _widthAnimation;
  Animation<double>? _textTranslationAnimation;
  Animation<double>? _widthReduceAnimation;
  Animation<double>? _rotationAnimation;
  bool hasReversed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    Timer(Duration(seconds: 2), () {
      setAnimatedValues(5, context);
    });
  }

  curve(ctrl) => CurvedAnimation(parent: ctrl, curve: Curves.linear);

  setAnimatedValues(int index, BuildContext? context) {
    if (context != null) {
      _widthAnimation = Tween<double>(
        begin: Sizing.width(context) / 3,
        end: Sizing.width(context),
      ).animate(curve(_controller!));

      _textTranslationAnimation = Tween<double>(
        begin: 1.8,
        end: 2.5,
      ).animate(curve(_controller!));

      _widthReduceAnimation = Tween<double>(
        begin: Sizing.width(context) / 3,
        end: 0,
      ).animate(curve(_controller!));

      _rotationAnimation = Tween<double>(
        begin: -0.7,
        end: -0.1,
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
            child: Row(
              children: [
                ...[0, 1, 2].map(
                  (index) {
                    return AnimatedBuilder(
                      animation: _controller!,
                      builder: (context, _) {
                        return nikeSlide(context, index);
                      },
                    );
                  },
                ).toList()
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Follow(activeIndex: activeIndex),
          ),
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

  Container nikeSlide(BuildContext context, int index) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: index == 0
            ? AppColors.blue
            : index == 1
                ? AppColors.red
                : AppColors.yellow,
      ),
      width: index == activeIndex ? _widthAnimation?.value ?? Sizing.width(context) / 3 : _widthReduceAnimation?.value ?? Sizing.width(context) / 3,
      height: Sizing.height(context),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Transform.scale(
                scale: _textTranslationAnimation?.value ?? 1.8,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  index == 0
                      ? "BLUE"
                      : index == 1
                          ? "RED"
                          : "YELLOW",
                  style: GoogleFonts.montserrat(
                    fontSize: 100,
                    fontWeight: FontWeight.w800,
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
              child: Transform.rotate(
                angle: _rotationAnimation?.value ?? -0.7,
                child: Image.asset("assets/images/nike_${index}.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
