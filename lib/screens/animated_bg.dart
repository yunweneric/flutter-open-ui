import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_openui/utils/sizing.dart';

class AnimatedBG extends StatefulWidget {
  final AnimationController controller;
  final Animation<double>? animateRotation;

  const AnimatedBG({super.key, required this.controller, this.animateRotation});

  @override
  State<AnimatedBG> createState() => _AnimatedBGState();
}

class _AnimatedBGState extends State<AnimatedBG> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller!,
      builder: (context, value) {
        return Transform.rotate(
          angle: widget.animateRotation?.value ?? 0.0,
          child: Container(
            alignment: Alignment.center,
            width: AppSizing.height(context),
            height: AppSizing.height(context),
            decoration: const BoxDecoration(
              gradient: SweepGradient(
                colors: [
                  Color(0XFFAA6EEE),
                  Color(0XFF8D99FF),
                  Color(0XFFF5B9EA),
                  Color(0XFFFFBA71),
                  Color(0XFFBC82F3),
                  Color(0XFFC686FF),
                  Color(0XFFFF6778),
                  Color(0XFFAA6EEE),
                  Color(0XFFFFBA71),
                  Color(0XFFAA6EEE),
                ],
                stops: [0.0, 0.1, 0.26, 0.31, 0.36, 0.42, 0.70, 0.80, 0.9, 1.0],
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              // child: chatUi(context),
              child: const Text(""),
            ),
          ),
        );
      },
    );
  }
}
