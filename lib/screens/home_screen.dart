import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openui/utils/fruits.dart';
import 'package:flutter_openui/utils/sizing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int activeBgIndex = 0;
  int activeFruitIndex = 0;

  AnimationController? fruitController;
  AnimationController? fruitMiniController;
  AnimationController? bottleController;
  PageController pageController = PageController(initialPage: 0);

  bool isScrolling = true;
  bool hasEndedScroll = false;
  bool hasStartedScroll = false;
  final fruitAnimationDuration = const Duration(milliseconds: 300);
  final bottleAnimationDuration = const Duration(milliseconds: 500);
  late Animation<double> fruitAnimation;
  late Animation<double> bottleAnimation;
  late Animation<double> fruitMiniAnimation;
  @override
  void initState() {
    bottleController = AnimationController(vsync: this, duration: bottleAnimationDuration);
    fruitController = AnimationController(vsync: this, duration: fruitAnimationDuration);
    fruitMiniController = AnimationController(vsync: this, duration: fruitAnimationDuration);
    final Animation<double> fruitCurve = CurvedAnimation(parent: fruitController!, curve: Curves.easeInBack);
    final Animation<double> bottleCurve = CurvedAnimation(parent: bottleController!, curve: Curves.elasticOut);
    bottleAnimation = Tween<double>(begin: 0.2, end: 1.5).animate(bottleCurve);
    fruitAnimation = Tween<double>(begin: 1.5, end: 0).animate(fruitCurve);
    fruitMiniAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(fruitCurve);
    animate();
    super.initState();
  }

  @override
  void dispose() {
    pageController.removeListener(listToScroll);
    pageController.dispose();
    bottleController?.dispose();
    fruitController?.dispose();
    fruitMiniController?.dispose();
    super.dispose();
  }

  listToScroll() {
    // print(controller.offset);
  }

  _onStartScroll(ScrollStartNotification notification) {
    setState(() {
      isScrolling = false;
      hasEndedScroll = false;
      hasStartedScroll = true;
    });
  }

  _onUpdateScroll(ScrollUpdateNotification notification) {
    setState(() {
      isScrolling = true;
      hasEndedScroll = false;
      hasStartedScroll = false;
    });
  }

  _onEndScroll(ScrollEndNotification notification) {
    updateActiveIndex(notification);
    setState(() {
      isScrolling = false;
      hasEndedScroll = true;
      hasStartedScroll = false;
    });
  }

  updateActiveIndex(ScrollEndNotification notification) async {
    fruitController!.reset();
    bottleController!.reset();
    if (activeBgIndex > activeFruitIndex) {
      fruits.add(fruits[activeFruitIndex]);
    } else {
      // fruits.insert(0, fruits[activeBgIndex]);
    }
    setState(() {
      activeFruitIndex = activeBgIndex;
    });
    await fruitController!.forward();
    await fruitMiniController!.forward();
    await bottleController!.forward();

    // fruits.forEach((item) => print(item.fruit));
  }

  animate() {
    fruitController!.reset();
    bottleController!.reset();
    fruitController!.forward();
    bottleController!.forward();
  }

  String generateAssetName(int index, String suffix) {
    return "assets/images/${fruits[index].colorName}_${suffix}.png";
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedContainer(
              width: AppSizing.width(context),
              duration: const Duration(milliseconds: 700),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    fruits[activeBgIndex].color,
                    fruits[activeBgIndex].lightColor.withOpacity(0.9),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: AnimatedContainer(
                width: AppSizing.width(context) / 2,
                height: AppSizing.height(context) / 2,
                duration: const Duration(milliseconds: 700),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.5),
                      fruits[activeBgIndex].color.withOpacity(0.2),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: AppSizing.height(context) / 15,
              left: 0,
              right: 0,
              child: TweenAnimationBuilder(
                key: ValueKey(activeBgIndex),
                duration: const Duration(milliseconds: 1500),
                tween: Tween<Offset>(
                  begin: Offset(0, 150),
                  end: Offset.zero,
                ),
                curve: Curves.bounceInOut,
                builder: (context, offset, child) {
                  return Container(
                    child: Center(
                      child: Transform.translate(
                        offset: offset,
                        child: Container(
                          width: AppSizing.width(context) * 0.5,
                          color: Colors.teal,
                          child: Image.asset("assets/images/logo.png"),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.bottomCenter,
                // height: AppSizing.height(context) * 0.8,
                height: AppSizing.height(context),
                width: AppSizing.width(context),
                child: NotificationListener(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollStartNotification) {
                      _onStartScroll(scrollNotification);
                    } else if (scrollNotification is ScrollUpdateNotification) {
                      _onUpdateScroll(scrollNotification);
                    } else if (scrollNotification is ScrollEndNotification) {
                      _onEndScroll(scrollNotification);
                    }
                    return true;
                  },
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: fruits.length,
                    onPageChanged: (page) {
                      setState(() {
                        activeBgIndex = page;
                      });
                    },
                    itemBuilder: (c, i) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AnimatedBuilder(
                            animation: bottleController!,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: bottleAnimation.value,
                                child: Opacity(
                                  opacity: i == activeFruitIndex ? 1 : 0,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Image.asset(generateAssetName(i, "bottle"), height: AppSizing.height(context) * 0.7),
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            child: AnimatedBuilder(
                              animation: fruitController!,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: isScrolling && activeFruitIndex == i ? 1 : fruitAnimation.value,
                                  child: Opacity(
                                    opacity: 1,
                                    // opacity: fruitAnimation.value.clamp(0, 1),
                                    child: Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.identity()
                                        ..translate(isScrolling ? AppSizing.width(context) * 0.8 : 0.0, 0)
                                        ..scale(1.5),
                                      child: AnimatedOpacity(
                                        opacity: 1,
                                        duration: Duration(milliseconds: 400),
                                        // opacity: isScrolling && activeBgIndex == i ? 1 : 0,
                                        child: Image.asset(
                                          height: AppSizing.height(context),
                                          width: AppSizing.width(context),
                                          isScrolling && activeFruitIndex == i
                                              ? generateAssetName(
                                                  activeFruitIndex + 1,
                                                  "slice",
                                                )
                                              : generateAssetName(activeFruitIndex + 1, "slice"),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            child: AnimatedBuilder(
                              animation: fruitMiniController!,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: isScrolling ? 0 : fruitAnimation.value,
                                  child: Image.asset(
                                    height: AppSizing.height(context),
                                    width: AppSizing.width(context),
                                    isScrolling && activeFruitIndex == i
                                        ? generateAssetName(
                                            activeFruitIndex + 1,
                                            "mini_slice",
                                          )
                                        : generateAssetName(activeFruitIndex + 1, "mini_slice"),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
