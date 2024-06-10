import 'package:flutter/material.dart';
import 'package:flutter_open_animate/pages/models/watch.dart';
import 'package:flutter_open_animate/utils/sizing.dart';

class WatchSlider extends StatelessWidget {
  final PageController pageController;
  final List<AppWatch> watches;
  const WatchSlider({super.key, required this.pageController, required this.watches});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        // color: Colors.teal,
        clipBehavior: Clip.none,
        height: Sizing.height(context),
        width: Sizing.width(context) * 0.25,
        child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: watches.length,
          controller: pageController,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Image.asset("assets/images/watch_$index.png", fit: BoxFit.contain);
          },
        ),
      ),
    );
  }
}
