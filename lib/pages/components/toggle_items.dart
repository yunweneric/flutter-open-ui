import 'package:flutter/material.dart';
import 'package:flutter_open_animate/pages/follow.dart';
import 'package:flutter_open_animate/pages/models/doughnut.dart';
import 'package:flutter_open_animate/utils/colors.dart';
import 'package:flutter_open_animate/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

Positioned titleAndTogglers({
  required BuildContext context,
  required List<Doughnut> items,
  required int activeIndex,
  required Duration duration,
  required Function(Doughnut item) onTap,
}) {
  return Positioned(
    right: 60,
    top: 0,
    child: SizedBox(
      width: Sizing.width(context) * 0.4,
      height: Sizing.height(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/title.svg", color: AppColors.white),
          const SizedBox(height: 30),
          const Text(
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Obcaecati similique cupiditate laboriosam consequuntur facere maxime necessitatibus nemo eius perferendis ea eum laudantium iste a asperiores libero tempore, saepe cum! Ratione?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: AppColors.white),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...items.map((item) {
                return Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(140),
                    splashColor: Colors.transparent,
                    enableFeedback: false,
                    onTap: () => onTap(item),
                    child: AnimatedScale(
                      duration: duration,
                      scale: item.index == activeIndex ? 1.2 : 0.8,
                      child: Image.asset("assets/images/doughnut_${item.index}.png", scale: 5.5),
                    ),
                  ),
                );
              })
            ],
          ),
          const SizedBox(height: 20),
          Follow(activeIndex: activeIndex)
        ],
      ),
    ),
  );
}
