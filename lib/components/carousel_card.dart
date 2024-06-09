import 'package:flutter/material.dart';
import 'package:flutter_fruits_animation/utils/colors.dart';
import 'package:flutter_fruits_animation/utils/sizing.dart';

class CarouselCard extends StatefulWidget {
  final int index;
  final int activeIndex;
  final VoidCallback onTap;
  const CarouselCard({super.key, required this.index, required this.activeIndex, required this.onTap});

  @override
  State<CarouselCard> createState() => _CarouselCardState();
}

class _CarouselCardState extends State<CarouselCard> {
  bool isLarge = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() => isLarge = true);
      },
      onExit: (event) {
        setState(() => isLarge = false);
      },
      child: InkWell(
        mouseCursor: MaterialStateMouseCursor.clickable,
        onTap: () => widget.onTap(),
        child: Container(
          height: Sizing.height(context) / 6,
          width: Sizing.width(context) / 12 - Sizing.width(context) / 450,
          decoration: BoxDecoration(
            color: widget.index == 0
                ? AppColors.strawberry
                : widget.index == 1
                    ? AppColors.orange
                    : AppColors.apple,
            border: BorderDirectional(
              start: widget.index == 0 ? BorderSide.none : BorderSide(color: AppColors.white, width: Sizing.width(context) / 450),
              end: widget.index == 2 ? BorderSide.none : BorderSide(color: AppColors.white, width: Sizing.width(context) / 450),
            ),
          ),
          child: AnimatedScale(
            duration: Duration(milliseconds: 100),
            scale: isLarge ? 0.8 : 0.75,
            child: Image.asset(
              "assets/images/card_${widget.index}.png",
            ),
          ),
        ),
      ),
    );
  }
}
