import 'package:flutter/material.dart';
import 'package:flutter_car_rental/utils/colors.dart';
import 'package:flutter_svg/svg.dart';

class Arrows extends StatefulWidget {
  final int index;
  final Function(int newIndex) onTap;
  const Arrows({super.key, required this.index, required this.onTap});

  @override
  State<Arrows> createState() => _ArrowsState();
}

class _ArrowsState extends State<Arrows> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 30,
          top: 0,
          bottom: 0,
          child: hoverAnimated(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: widget.index > 0 ? 1 : 0,
              child: arrow(widget.index, "assets/icons/arrow_left.svg", true),
            ),
          ),
        ),
        Positioned(
          right: 30,
          top: 0,
          bottom: 0,
          child: hoverAnimated(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: widget.index == 2 ? 0 : 1,
              child: arrow(widget.index, "assets/icons/arrow_right.svg", false),
            ),
          ),
        ),
      ],
    );
  }

  Widget hoverAnimated({required Widget child}) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
      },
      onExit: (_) {
        setState(() => isHovered = false);
      },
      child: Center(
        child: AnimatedScale(
          scale: isHovered ? 1.2 : 1,
          duration: const Duration(milliseconds: 200),
          child: child,
        ),
      ),
    );
  }

  updateActiveIndex(int index, bool isLeft) {
    if (isLeft) {
      if (index > 0) {
        widget.onTap(index - 1);
      }
    } else if (index < 2) {
      widget.onTap(index + 1);
    }
  }

  Widget arrow(int index, String asset, bool isLeft) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () => updateActiveIndex(index, isLeft),
      child: CircleAvatar(
        backgroundColor: AppColors.white,
        child: SvgPicture.asset(asset),
      ),
    );
  }
}
