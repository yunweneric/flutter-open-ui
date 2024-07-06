import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/sizing.dart';

class FruitItem {
  final Color color;
  final Color lightColor;
  final String image;
  final String fruit;

  FruitItem({required this.color, required this.lightColor, required this.image, required this.fruit});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  int activeBgIndex = 0;
  List<FruitItem> fruits = [
    FruitItem(
      color: AppColors.yellow,
      lightColor: AppColors.yellowLight,
      image: "assets/images/yellow_bottle.png",
      fruit: "assets/images/yellow_slice.png",
    ),
    FruitItem(
      color: AppColors.green,
      lightColor: AppColors.greenLight,
      image: "assets/images/green_bottle.png",
      fruit: "assets/images/gree_slice.png",
    ),
    FruitItem(
      color: AppColors.purple,
      lightColor: AppColors.purpleLight,
      fruit: "assets/images/purple_slice.png",
      image: "assets/images/purple_bottle.png",
    ),
  ];

  generateGradient() {}
  PageController controller = PageController();
  bool isScrolling = true;
  @override
  void initState() {
    controller.addListener(listToScroll);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(listToScroll);
    controller.dispose();
    super.dispose();
  }

  listToScroll() {
    print(controller.offset);
  }

  Offset scrollOffset = Offset.zero;

  _onStartScroll(ScrollStartNotification notification) {
    print("Scroll Start");
    setState(() => isScrolling = false);
  }

  _onUpdateScroll(ScrollUpdateNotification notification) {
    print("Scroll Update");
    setState(() {
      isScrolling = true;
    });
  }

  _onEndScroll(ScrollEndNotification notification) {
    updateActiveIndex(notification);
    setState(() => isScrolling = false);
  }

  updateActiveIndex(ScrollEndNotification notification) {
    print(notification.metrics.pixels);
    final pixel = notification.metrics.pixels;
    setState(() {
      if (pixel <= 0 && pixel <= 300) {
        activeIndex = 0;
      } else if (pixel > 300 && pixel <= 600) {
        activeIndex = 1;
      } else if (pixel > 600) {
        activeIndex = 2;
      }
    });
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
                    fruits[activeBgIndex].lightColor,
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              clipBehavior: Clip.none,
              width: AppSizing.width(context),
              height: AppSizing.height(context),
              duration: const Duration(milliseconds: 700),
              child: Transform.translate(
                offset: Offset(100, 0),
                child: Image.asset(
                  fruits[activeBgIndex].fruit,
                  fit: BoxFit.cover,
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
                  begin: Offset(0, 20),
                  end: Offset.zero,
                ),
                curve: Curves.bounceInOut,
                builder: (context, offset, child) {
                  return Transform.translate(
                    offset: offset,
                    child: Image.asset("assets/images/logo.png", scale: 4),
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
                height: AppSizing.height(context) * 0.8,
                width: AppSizing.width(context),
                child: NotificationListener(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollStartNotification) {
                      print("Scroll start");
                      _onStartScroll(scrollNotification);
                    } else if (scrollNotification is ScrollUpdateNotification) {
                      print("Scroll Update");
                      _onUpdateScroll(scrollNotification);
                    } else if (scrollNotification is ScrollEndNotification) {
                      print("Scroll End");
                      _onEndScroll(scrollNotification);
                    }
                    return true;
                  },
                  child: PageView.builder(
                    controller: controller,
                    itemCount: fruits.length,
                    onPageChanged: (page) {
                      setState(() {
                        activeBgIndex = page;
                      });
                    },
                    itemBuilder: (c, i) {
                      return AnimatedScale(
                        curve: Curves.bounceIn,
                        scale: i == activeIndex ? 1 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 400),
                          opacity: i == activeIndex ? 1 : 0,
                          child: Image.asset(fruits[i].image),
                        ),
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
