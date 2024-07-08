import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openui/utils/fruits.dart';
import 'package:flutter_openui/utils/sizing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int activeBgIndex = 12;
  int activeFruitIndex = 12;

  AnimationController? fruitController;
  AnimationController? fruitMiniController;
  AnimationController? bottleController;
  PageController pageController = PageController(initialPage: 12);

  bool isScrolling = false;
  bool hasEndedScroll = false;
  bool hasStartedScroll = false;
  ScrollDirection? scrollDirection;
  final fruitAnimationDuration = const Duration(milliseconds: 200);
  final bottleAnimationDuration = const Duration(milliseconds: 500);
  late Animation<double> fruitAnimation;
  late Animation<double> bottleAnimation;
  late Animation<double> fruitMiniAnimation;
  List<FruitItem> fruits = generateItems();
  @override
  void initState() {
    bottleController = AnimationController(vsync: this, duration: bottleAnimationDuration);
    fruitController = AnimationController(vsync: this, duration: fruitAnimationDuration);
    fruitMiniController = AnimationController(vsync: this, duration: bottleAnimationDuration);
    Animation<double> fruitCurve = CurvedAnimation(parent: fruitController!, curve: Curves.easeInBack);
    Animation<double> bottleCurve = CurvedAnimation(parent: bottleController!, curve: Curves.elasticOut);
    Animation<double> fruitMinCurve = CurvedAnimation(parent: fruitMiniController!, curve: Curves.elasticOut);
    bottleAnimation = Tween<double>(begin: 0.2, end: 1.5).animate(bottleCurve);
    fruitAnimation = Tween<double>(begin: 1.5, end: 0.0).animate(fruitCurve);
    fruitMiniAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(fruitMinCurve);
    toggleAnimationAndUpdateFruitIndex();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    bottleController?.dispose();
    fruitController?.dispose();
    fruitMiniController?.dispose();
    super.dispose();
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
      scrollDirection = pageController.position.userScrollDirection;
      isScrolling = true;
      hasEndedScroll = false;
      hasStartedScroll = false;
    });
  }

  _onEndScroll(ScrollEndNotification notification) {
    toggleAnimationAndUpdateFruitIndex();
    setState(() {
      isScrolling = false;
      hasEndedScroll = true;
      hasStartedScroll = false;
    });
  }

  toggleAnimationAndUpdateFruitIndex() async {
    fruitController!.reset();
    bottleController!.reset();

    setState(() {
      activeFruitIndex = activeBgIndex;
    });

    await fruitController!.forward();
    fruitMiniController!.reset();
    fruitMiniController!.forward();
    await bottleController!.forward();
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
              top: AppSizing.height(context) / 8,
              left: AppSizing.height(context) * 0.08,
              right: AppSizing.height(context) * 0.08,
              child: Container(
                width: AppSizing.width(context) * 0.3,
                // color: Colors.teal,
                child: Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 150,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.bottomCenter,
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
                      print(page);
                    },
                    itemBuilder: (c, i) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          fruitMiniSlice(i),
                          bottle(i),
                          fruitSlice(i),
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

  Positioned fruitSlice(int i) {
    return Positioned(
      child: AnimatedBuilder(
        animation: fruitController!,
        builder: (context, child) {
          return Transform.scale(
            scale: isScrolling && activeFruitIndex == i ? 1 : fruitAnimation.value,
            child: AnimatedOpacity(
              duration: fruitAnimationDuration,
              // opacity: isScrolling || hasEndedScroll && activeFruitIndex == i ? 1 : 0,
              opacity: 1,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..translate(
                    isScrolling
                        ? scrollDirection == ScrollDirection.forward
                            ? -AppSizing.width(context) * 0.8
                            : AppSizing.width(context) * 0.8
                        : 0.0,
                    0,
                  )
                  ..scale(1.5),
                child: Builder(
                  builder: (context) {
                    bool condition = scrollDirection == ScrollDirection.reverse && activeFruitIndex == i;
                    final newIndex = condition ? activeFruitIndex + 1 : (activeFruitIndex - 1).clamp(0, fruits.length - 1);
                    return Image.asset(
                      height: AppSizing.height(context),
                      width: AppSizing.width(context),
                      isScrolling ? generateAssetName(newIndex, "slice") : generateAssetName(activeFruitIndex, "slice"),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AnimatedBuilder bottle(int i) {
    return AnimatedBuilder(
      animation: bottleController!,
      builder: (context, child) {
        return Transform.scale(
          scale: bottleAnimation.value,
          child: Opacity(
            opacity: i == activeFruitIndex ? 1 : 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                generateAssetName(i, "bottle"),
                height: AppSizing.height(context) * 0.7,
                width: AppSizing.width(context),
              ),
            ),
          ),
        );
      },
    );
  }

  Positioned fruitMiniSlice(int index) {
    return Positioned(
      child: AnimatedBuilder(
        animation: fruitMiniController!,
        builder: (context, child) {
          return Transform.scale(
            scale: fruitMiniAnimation.value,
            child: Opacity(
              opacity: fruitMiniAnimation.value.clamp(0, 1),
              child: Image.asset(
                height: AppSizing.height(context),
                width: AppSizing.width(context),
                generateAssetName(index, "mini_slice"),
              ),
            ),
          );
        },
      ),
    );
  }
}
