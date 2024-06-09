import 'package:flutter/material.dart';
import 'package:flutter_open_animate/pages/models/doughnut.dart';
import 'package:flutter_open_animate/utils/sizing.dart';
import 'dart:math' as math;

SizedBox rotatedItems({
  required BuildContext context,
  required AnimationController controller,
  required Animation<double> animatedAngle,
  required Duration duration,
  required int activeIndex,
  required List<Doughnut> items,
}) {
  double angle = 0.00;
  return SizedBox(
    width: Sizing.width(context),
    height: Sizing.height(context),
    child: Center(
      child: Container(
        transform: Matrix4.identity()..translate(-Sizing.width(context) * 0.67),
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, a) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(animatedAngle.value)
                  ..scale(2.0),
                child: Container(
                  width: Sizing.height(context),
                  height: Sizing.height(context),
                  alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ...items.map((item) {
                        return Builder(builder: (context) {
                          final mainRadius = Sizing.height(context) * 0.34;
                          // Calculate angle for each index
                          double angle = (item.index * (2 * math.pi)) / 4;
                          // Calculate x and y position using trigonometry
                          double x = mainRadius + mainRadius * math.cos(angle);
                          double y = mainRadius + mainRadius * math.sin(angle);

                          return Positioned(
                            top: y,
                            left: x,
                            child: AnimatedOpacity(
                              duration: duration,
                              opacity: item.index == activeIndex ? 1 : 1,
                              child: Image.asset("assets/images/doughnut_${item.index}.png", width: mainRadius, height: mainRadius),
                            ),
                          );
                        });
                      })
                    ],
                  ),
                ),
              );
            }),
      ),
    ),
  );
}
