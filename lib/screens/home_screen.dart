import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_openui/data/data.dart';
import 'package:flutter_openui/data/mountain.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/helper.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

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
  final duration = const Duration(milliseconds: 2000);
  late PageController pageController;
  final curve = Curves.elasticOut;

  @override
  void initState() {
    setState(() {
      mountains = data.reversed.toList();
      activeIndex = mountains.length - 2;
      previousIndex = mountains.length - 2;
    });
    pageController = PageController(viewportFraction: 1, initialPage: mountains.length - 2);
    Future.delayed(const Duration(seconds: 2), () => resetViewportFraction());
    super.initState();
  }

  void resetViewportFraction() {
    setState(() {
      activeIndex = mountains.length - 2;
      previousIndex = mountains.length - 2;
    });
    pageController = PageController(
      viewportFraction: 0.95,
      initialPage: mountains.length - 2,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        if (page == mountains.length - 1 || page == 1) {
                          setState(() => mountains = [...mountains, ...mountains]);
                        }
                        setState(() {
                          previousIndex = activeIndex;
                          activeIndex = page;
                        });
                      },
                      itemBuilder: (c, i) {
                        final mountain = mountains[i];
                        final maxHeight = AppSizing.height(context) * 0.35;
                        final margin = EdgeInsets.symmetric(horizontal: AppSizing.width(context) * 0.18);
                        return mountainCard(context, maxHeight, margin, mountain);
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

  Center mountainCard(BuildContext context, double maxHeight, EdgeInsets margin, Mountain mountain) {
    return Center(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.01)
          ..rotateZ(pi * -1.2),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform(
              transform: Matrix4.identity()..translate(40.0, 40.0),
              child: AnimatedContainer(
                duration: duration,
                height: maxHeight,
                margin: margin,
                curve: curve,
                child: SvgPicture.asset(
                  "assets/icons/shadow.svg",
                  width: AppSizing.width(context),
                ),
              ),
            ),
            Transform.scale(
              scaleY: 1.23,
              scaleX: 1.3,
              child: AnimatedContainer(
                duration: duration,
                height: maxHeight,
                margin: margin,
                curve: curve,
                child: SvgPicture.asset(
                  "assets/icons/all.svg",
                  width: AppSizing.width(context),
                  color: AppColors.white,
                ),
              ),
            ),
            Positioned(
              child: AnimatedContainer(
                duration: duration,
                padding: const EdgeInsets.all(10),
                margin: margin,
                curve: curve,
                constraints: BoxConstraints(maxHeight: maxHeight),
                width: AppSizing.width(context),
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(mountain.image), fit: BoxFit.cover),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ITALIA",
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
                      "MONTI LESSINI",
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.white),
                    )
                  ],
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
              curve: curve,
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
                        items.isNotEmpty ? items[0].toUpperCase() : "----",
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
                            items.length > 1 ? items[1].toUpperCase() : "----",
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
                                mountains[activeIndex].location.toUpperCase(),
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
                              ),
                              Text(
                                formattedCoord.toUpperCase(),
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
