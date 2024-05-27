import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/theme/colors.dart';
import 'package:flutter_openui/screens/utils/sizing.dart';

class MobileOnboardingScreen extends StatefulWidget {
  const MobileOnboardingScreen({super.key});

  @override
  State<MobileOnboardingScreen> createState() => _MobileOnboardingScreenState();
}

class _MobileOnboardingScreenState extends State<MobileOnboardingScreen> with SingleTickerProviderStateMixin {
  List<PageItem> items = [
    PageItem(
      0,
      "Find petcare around your location",
      "Just turn on your location and you will find the nearest pet care you wish.",
    ),
    PageItem(
      1,
      "Let us give the best treatment",
      "Get the best treatment for your animal with us",
    ),
    PageItem(
      2,
      "Book appointment with us!",
      "What do you think? book our veterinarians now",
    )
  ];

  AnimationController? animationController;
  Animation<double>? _rotationAnimation;
  int activeIndex = 0;

  PageController? controller;
  CurvedAnimation curve(ctrl) => CurvedAnimation(parent: ctrl, curve: Curves.easeInOutBack);

  @override
  void initState() {
    controller = PageController();
    setAnimationController();
    super.initState();
  }

  setAnimationController() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _rotationAnimation = Tween<double>(begin: pi * 0.2, end: 0.0).animate(curve(animationController!));
    runAnimation();
  }

  runAnimation() {
    animationController?.reset();
    animationController?.forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    animationController?.dispose();
    super.dispose();
  }

  final duration = const Duration(milliseconds: 500);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizing.kHeight(context),
      width: Sizing.kWidth(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: Sizing.kHeight(context),
            width: Sizing.kWidth(context),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/shadow.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: SizedBox(
              height: Sizing.kHeight(context),
              width: Sizing.kWidth(context),
              child: PageView.builder(
                controller: controller,
                scrollDirection: Axis.vertical,
                onPageChanged: (page) async {
                  setState(() => activeIndex = page);
                  Future.delayed(const Duration(milliseconds: 500), () => runAnimation());
                },
                itemCount: items.length,
                itemBuilder: (c, i) {
                  return AnimatedScale(
                    duration: duration,
                    scale: activeIndex == i ? 1 : 0.5,
                    child: AnimatedOpacity(
                      opacity: activeIndex == i ? 1 : 0,
                      duration: duration,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedBuilder(
                              animation: animationController!,
                              builder: (context, _) {
                                return Transform.rotate(
                                  angle: _rotationAnimation!.value,
                                  child: Image.asset("assets/images/image_$i.png", scale: 4),
                                );
                              },
                            ),
                            TweenAnimationBuilder(
                                duration: const Duration(milliseconds: 2000),
                                tween: Tween<double>(begin: 20, end: 0.0),
                                curve: Curves.easeInOutBack,
                                builder: (context, value, c) {
                                  return Transform.translate(
                                    offset: Offset(0, value),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 30),
                                        Text(
                                          items[i].title,
                                          style: const TextStyle(fontSize: 22, color: AppColors.white, fontWeight: FontWeight.w800),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          textAlign: TextAlign.center,
                                          items[i].desc,
                                          style: const TextStyle(fontSize: 14, color: AppColors.white),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                indicatorsWidget(),
                TweenAnimationBuilder(
                  tween: activeIndex == 2 ? Tween<double>(begin: 0, end: pi) : Tween<double>(begin: 0, end: 0),
                  duration: duration,
                  builder: (context, value, _) {
                    return Transform.rotate(
                      angle: value,
                      child: GestureDetector(
                        onTap: () {
                          controller?.animateToPage(
                            activeIndex == items.length - 1 ? 0 : items.length,
                            duration: duration,
                            curve: Curves.linear,
                          );
                        },
                        child: const CircleAvatar(
                          radius: 30,
                          child: Icon(Icons.arrow_downward),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget indicatorsWidget() {
    return RotatedBox(
      quarterTurns: 1,
      child: Row(children: [
        ...items.map((item) {
          return AnimatedContainer(
            duration: duration,
            width: activeIndex == item.index ? 30 : 6,
            margin: const EdgeInsets.only(right: 8),
            height: 6,
            decoration: BoxDecoration(
              color: activeIndex == item.index ? AppColors.white : AppColors.shadow.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          );
        }).toList()
      ]),
    );
  }
}

class PageItem {
  final int index;
  final String title;
  final String desc;

  PageItem(this.index, this.title, this.desc);
}
