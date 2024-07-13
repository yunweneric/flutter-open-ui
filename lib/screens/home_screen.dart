import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_openui/data/data.dart';
import 'package:flutter_openui/data/mountain.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/helper.dart';
import 'package:flutter_openui/utils/sizing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int activeIndex = 1;
  int previousIndex = 0;

  List<Mountain> data = allMountains.map((item) => Mountain.fromJson(item)).toList();
  List<Mountain> mountains = [];
  final duration = const Duration(milliseconds: 500);
  late PageController pageController;
  late AnimationController _animationController;
  late AnimationController _closetItemController;
  late Animation<double> _animation;
  late Animation<double> _closestItemInitAnimation;
  bool isExpanded = true;

  @override
  void initState() {
    setState(() {
      mountains = data.reversed.toList();
      activeIndex = mountains.length - 2;
      previousIndex = mountains.length - 2;
    });
    pageController = PageController(viewportFraction: 1, initialPage: mountains.length - 2);
    _animationController = AnimationController(vsync: this, duration: duration);
    _closetItemController = AnimationController(vsync: this, duration: duration);
    Future.delayed(Duration(seconds: 5), () => resetViewportFraction());
    super.initState();
  }

  void resetViewportFraction() {
    _animation = Tween<double>(begin: 1, end: 0.9).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {
          pageController = PageController(
            viewportFraction: _animation.value,
            initialPage: mountains.length - 2,
          );
        });
      });
    _animationController.forward();
    setState(() {
      activeIndex = mountains.length - 2;
      previousIndex = mountains.length - 2;
      isExpanded = false;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    _closetItemController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          resetViewportFraction();
        },
      ),
      body: AnimatedContainer(
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(color: Helper.hexToColor(mountains[activeIndex].bg)),
        height: AppSizing.height(context),
        width: AppSizing.width(context),
        child: Stack(
          children: [
            mountainNamesAndCoordinates(context),
            Positioned(
              child: SizedBox(
                height: AppSizing.height(context),
                width: AppSizing.width(context),
                child: Transform.rotate(
                  angle: pi * 1.2,
                  child: Builder(builder: (context) {
                    return PageView.builder(
                      itemCount: mountains.length,
                      clipBehavior: Clip.none,
                      controller: pageController,
                      onPageChanged: (page) {
                        print(["page", page]);
                        if (page == mountains.length - 1 || page == 1) {
                          setState(() {
                            mountains = [...mountains, ...mountains];
                          });
                        }
                        setState(() {
                          previousIndex = activeIndex;
                          activeIndex = page;
                        });
                      },
                      itemBuilder: (c, i) {
                        final mountain = mountains[i];
                        return Center(
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()..rotateZ(pi * -1.2),
                            child: Stack(
                              children: [
                                AnimatedContainer(
                                    duration: duration,
                                    padding: const EdgeInsets.all(10),
                                    margin: isExpanded ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: AppSizing.width(context) * 0.15),
                                    constraints: BoxConstraints(
                                      maxHeight: isExpanded ? AppSizing.height(context) : AppSizing.height(context) * 0.4,
                                    ),
                                    width: AppSizing.width(context),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(mountain.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Italia",
                                              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.white),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: AppColors.white),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                "B",
                                                style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Monti Lessini",
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.white),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned mountainNamesAndCoordinates(BuildContext context) {
    return Positioned(
      top: AppSizing.height(context) * 0.1,
      child: Container(
        alignment: Alignment.center,
        height: AppSizing.height(context) * 0.8,
        width: AppSizing.width(context),
        child: Builder(builder: (context) {
          List<String> items = mountains[activeIndex].name.split("\n");
          List<String> coordinates = mountains[activeIndex].coordinates.split(",");
          String north = coordinates.isNotEmpty ? coordinates[0] : "----";
          String east = coordinates.isNotEmpty ? coordinates[0] : "----";
          String formattedCoord = "${north.substring(0, 5)}N - ${east.substring(0, 5)}E";

          return TweenAnimationBuilder(
              duration: duration,
              tween: Tween<double>(begin: 1, end: 0),
              key: ValueKey(activeIndex),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                final isLeft = previousIndex < activeIndex;
                final leftOffset = isLeft ? value * AppSizing.width(context) * 0.5 : value * AppSizing.width(context) * -0.5;
                final rightOffset = isLeft ? value * AppSizing.width(context) * -0.5 : value * AppSizing.width(context) * 0.5;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.translate(
                      offset: Offset(leftOffset, 0),
                      child: Text(
                        items.isNotEmpty ? items[0] : "----",
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                              color: Helper.hexToColor(mountains[activeIndex].fg),
                            ),
                      ),
                    ),
                    Column(
                      children: [
                        Transform.translate(
                          offset: Offset(rightOffset, 0),
                          child: Text(
                            items.length > 1 ? items[1] : "----",
                            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                  color: Helper.hexToColor(mountains[activeIndex].fg),
                                ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(leftOffset, 0),
                          child: Column(
                            children: [
                              Text(
                                mountains[activeIndex].location,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
                              ),
                              Text(
                                formattedCoord,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                );
              });
        }),
      ),
    );
  }
}
