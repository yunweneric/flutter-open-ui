import 'package:flutter/material.dart';
import 'package:flutter_open_animate/pages/models/doughnut.dart';

List<Positioned> animatedBg(Duration duration, int activeIndex, List<Doughnut> items) {
  return [
    Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(duration: duration, color: items[activeIndex].color.withOpacity(0.4)),
    ),
    Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 1500),
        tween: Tween<double>(begin: 0.0, end: 1.0),
        curve: Curves.ease,
        key: ValueKey(activeIndex),
        builder: (context, value, c) {
          return AnimatedOpacity(
            opacity: value,
            duration: duration,
            child: AnimatedContainer(duration: duration, color: items[activeIndex].color.withOpacity(0.4)),
          );
        },
      ),
    ),
    Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 2500),
        tween: Tween<double>(begin: 0.0, end: 1.0),
        curve: Curves.elasticOut,
        key: ValueKey(activeIndex),
        builder: (context, value, c) {
          return Transform.scale(
            scale: value,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/bg_doughnut_$activeIndex.png"),
                ),
              ),
            ),
          );
        },
      ),
    )
  ];
}
