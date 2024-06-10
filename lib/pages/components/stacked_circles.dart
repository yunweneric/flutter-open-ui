import 'package:flutter/material.dart';
import 'package:flutter_open_animate/pages/components/watch_slider.dart';
import 'package:flutter_open_animate/pages/models/watch.dart';
import 'package:flutter_open_animate/utils/sizing.dart';

class StackedCircles extends StatelessWidget {
  final PageController pageController;
  final List<AppWatch> watches;
  final int activeIndex;
  const StackedCircles({super.key, required this.pageController, required this.watches, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: Sizing.width(context) * 0.2,
      top: 0,
      child: Container(
        height: Sizing.height(context),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1200),
                width: Sizing.height(context) * 0.5,
                height: Sizing.height(context) * 0.5,
                decoration: BoxDecoration(
                  color: watches[activeIndex].borderColor,
                  borderRadius: BorderRadius.circular(Sizing.height(context) * 0.5),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 16, blurRadius: 20),
                  ],
                ),
              ),
            ),
            Positioned(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1200),
                width: Sizing.height(context) * 0.4,
                height: Sizing.height(context) * 0.4,
                decoration: BoxDecoration(
                  color: watches[activeIndex].color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 16,
                      blurRadius: 20,
                    )
                  ],
                ),
              ),
            ),
            WatchSlider(pageController: pageController, watches: watches),
          ],
        ),
      ),
    );
  }
}
