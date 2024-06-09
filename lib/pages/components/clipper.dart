import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Positioned clipper(int activeIndex, Duration duration, Color activeColor) {
  return Positioned(
    top: 0,
    bottom: 0,
    left: 0,
    right: 0,
    child: TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1000),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      key: ValueKey(activeIndex),
      builder: (context, value, c) {
        return AnimatedOpacity(
          duration: duration,
          opacity: value,
          child: SvgPicture.asset("assets/images/clipper.svg", fit: BoxFit.cover, color: activeColor),
        );
      },
    ),
  );
}
