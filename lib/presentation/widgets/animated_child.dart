import 'package:flutter/material.dart';
import 'package:flutter_openui/shared/utils/sizing.dart';

class AnimatedChild extends StatelessWidget {
  final Widget child;
  final double animation;
  final double offset;
  const AnimatedChild({super.key, required this.child, required this.animation, required this.offset});
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, offset * animation * AppSizing.kHPercentage(context, 10)),
      child: Opacity(
        opacity: 1 - animation,
        child: child,
      ),
    );
  }
}
