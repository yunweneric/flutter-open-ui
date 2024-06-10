import 'package:flutter/material.dart';
import 'package:flutter_open_animate/pages/models/watch.dart';
import 'package:flutter_open_animate/utils/colors.dart';
import 'package:flutter_open_animate/utils/sizing.dart';

class AnimatedCounter extends StatelessWidget {
  final List<AppWatch> watches;
  final void Function(int index) onTap;
  final Duration duration;
  final int activeIndex;
  const AnimatedCounter({super.key, required this.watches, required this.onTap, required this.duration, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 30,
      top: 0,
      child: SizedBox(
        height: Sizing.height(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...watches.map(
              (watch) {
                return InkWell(
                  onTap: () => onTap(watch.index),
                  child: AnimatedScale(
                    duration: duration,
                    scale: activeIndex == watch.index ? 1.8 : 1,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Text(
                        "0${watch.index + 1}",
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                              fontSize: 20,
                              color: AppColors.textWhite,
                            ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
