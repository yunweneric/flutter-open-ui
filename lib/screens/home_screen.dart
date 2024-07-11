import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/components/annotated_region.dart';
import 'package:flutter_openui/screens/components/app_clipper.dart';
import 'package:flutter_openui/screens/data/pizza.dart';
import 'package:flutter_openui/screens/routes/router.dart';
import 'package:flutter_openui/screens/zoom_screen.dart';
import 'package:flutter_openui/utils/color.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController heighController;
  late AnimationController bounceController;
  late Animation<double> heightAnimation;
  late Animation<double> bounceAnimation;
  final duration = const Duration(milliseconds: 1000);
  final bounceDuration = const Duration(milliseconds: 2500);
  final miniDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    heighController = AnimationController(vsync: this, duration: duration);
    bounceController = AnimationController(vsync: this, duration: bounceDuration);
    final curvedAnimation = CurvedAnimation(parent: heighController, curve: Curves.easeIn);
    final bounceAnimationCurve = CurvedAnimation(parent: bounceController, curve: Curves.elasticInOut);
    heightAnimation = Tween<double>(begin: 1, end: 0.7).animate(curvedAnimation);
    bounceAnimation = Tween<double>(begin: 1, end: 0).animate(bounceAnimationCurve);
    initialAnimation();
    super.initState();
  }

  int activeIndex = 1;
  int previousIndex = 0;
  double scaleFactor = 1.0;
  int previousQuantity = 0;
  List<Pizza> cartItems = [];

  initialAnimation() async {
    heighController.reset();
    bounceController.reset();
    bounceController.forward();
    heighController.forward();
  }

  animateTransition() {
    final bounceAnimationCurve = CurvedAnimation(parent: bounceController, curve: Curves.easeIn);
    bounceAnimation = Tween<double>(begin: 1, end: 0).animate(bounceAnimationCurve);
    bounceController.forward();
  }

  reverseAnimateTransition() {
    bounceController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(viewportFraction: 0.6, initialPage: 1);
    return AppAnnotatedRegion(
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: Colors.white, width: AppSizing.width(context), height: AppSizing.height(context)),
            pizzaCarousel(pageController),
            appBar(),
            scalingActions(context),
            footerAndCartActions(context),
          ],
        ),
      ),
    );
  }

  Positioned footerAndCartActions(BuildContext context) {
    return Positioned(
      left: AppSizing.width(context) * 0.1,
      right: AppSizing.width(context) * 0.1,
      bottom: AppSizing.height(context) * 0.05,
      child: AnimatedBuilder(
          animation: bounceController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, bounceAnimation.value * AppSizing.height(context) * 0.5),
              child: Column(
                children: [
                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 400),
                    tween: Tween<double>(begin: 1, end: 0),
                    key: ValueKey(activeIndex),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, value * 20),
                        child: Opacity(
                          opacity: 1 - value,
                          child: Text(
                            pizzas[activeIndex].description,
                            style: const TextStyle(height: 1.8),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: AppSizing.height(context) * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      cartActions(),
                      TweenAnimationBuilder(
                          duration: miniDuration,
                          key: ValueKey(pizzas[activeIndex].quantity),
                          tween: Tween<double>(begin: 1, end: 0),
                          builder: (context, value, child) {
                            final factor = previousQuantity > pizzas[activeIndex].quantity ? -10 : 30;
                            return Transform(
                              transform: Matrix4.identity()..translate(value * factor),
                              child: Opacity(
                                opacity: 1 - value,
                                child: Text(
                                  "\$${(pizzas[activeIndex].price * pizzas[activeIndex].quantity).toStringAsFixed(2)}",
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                            );
                          }),
                      TweenAnimationBuilder(
                          duration: miniDuration,
                          tween: ColorTween(
                            begin: cartItems.contains(pizzas[activeIndex]) ? AppColors.blue : AppColors.primary,
                            end: cartItems.contains(pizzas[activeIndex]) ? AppColors.primary : AppColors.blue,
                          ),
                          builder: (context, value, child) {
                            return ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  cartItems.add(pizzas[activeIndex]);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: value,
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                fixedSize: Size(AppSizing.width(context) * 0.25, 45),
                              ),
                              child: Text(
                                cartItems.contains(pizzas[activeIndex]) ? "Checkout" : "Add",
                                style: TextStyle(
                                  color: cartItems.contains(pizzas[activeIndex]) ? AppColors.black : AppColors.white,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          })
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }

  Positioned scalingActions(BuildContext context) {
    return Positioned(
      top: AppSizing.height(context) * 0.5,
      bottom: AppSizing.height(context) * 0.38,
      left: 0,
      right: 0,
      child: Container(
        alignment: Alignment.bottomCenter,
        height: 150,
        width: AppSizing.width(context),
        // color: const Color.fromARGB(255, 7, 7, 7).withOpacity(0.2),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 25,
              left: AppSizing.width(context) * 0.15,
              child: circleAvatar(
                bgColor: scaleFactor == 0.8 ? AppColors.black : Theme.of(context).primaryColorLight,
                onTap: () => setState(() => scaleFactor = 0.8),
                icon: Center(
                  child: Text(
                    "S",
                    style: TextStyle(
                      color: scaleFactor == 0.8 ? Theme.of(context).primaryColorLight : AppColors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 25,
              right: AppSizing.width(context) * 0.15,
              child: circleAvatar(
                bgColor: scaleFactor == 1.2 ? AppColors.black : Theme.of(context).primaryColorLight,
                onTap: () => setState(() => scaleFactor = 1.2),
                icon: Center(
                  child: Text(
                    "L",
                    style: TextStyle(
                      color: scaleFactor == 1.2 ? Theme.of(context).primaryColorLight : AppColors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: circleAvatar(
                bgColor: scaleFactor == 1 ? AppColors.black : Theme.of(context).primaryColorLight,
                onTap: () => setState(() => scaleFactor = 1),
                icon: Center(
                  child: Text(
                    "M",
                    style: TextStyle(
                      color: scaleFactor == 1 ? Theme.of(context).primaryColorLight : AppColors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned appBar() {
    return Positioned(
      top: kToolbarHeight,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: AnimatedBuilder(
            animation: bounceController,
            builder: (context, value) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.translate(
                    offset: Offset(bounceAnimation.value * AppSizing.width(context) * -0.3, 0),
                    child: circleAvatar(
                      icon: SvgPicture.asset("assets/icons/back.svg"),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, bounceAnimation.value * -AppSizing.height(context) * 0.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(pizzas[activeIndex].title, style: TextStyle(fontSize: 12)),
                        TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 200),
                          key: ValueKey(activeIndex),
                          tween: Tween<double>(begin: 1.0, end: 0.0),
                          builder: (context, value, child) {
                            final factor = previousIndex > activeIndex ? 30 : -30;
                            return Transform(
                              transform: Matrix4.identity()..translate(value * factor),
                              child: Opacity(
                                opacity: (1 - value).clamp(0, 1),
                                child: Text(
                                  pizzas[activeIndex].subtitle,
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(bounceAnimation.value * AppSizing.width(context) * 0.3, 0),
                    child: circleAvatar(
                      icon: SvgPicture.asset("assets/icons/heart.svg"),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  AnimatedBuilder pizzaCarousel(PageController pageController) {
    return AnimatedBuilder(
      animation: heighController,
      builder: (context, child) {
        return ClipPath(
          clipper: AppClipper(factor: heightAnimation.value.clamp(0.7, 1)),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: AppSizing.height(context) * heightAnimation.value,
                color: AppColors.primary,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: pizzas.sublist(0, 3).length,
                  onPageChanged: (page) {
                    setState(() {
                      previousIndex = activeIndex;
                      activeIndex = page;
                    });
                  },
                  itemBuilder: (c, i) {
                    return AnimatedScale(
                      duration: const Duration(milliseconds: 1200),
                      scale: activeIndex == i ? 1 * scaleFactor : 0.5,
                      curve: Curves.elasticInOut,
                      child: Hero(
                        tag: i,
                        child: Image.asset("assets/images/pizza_$i.png"),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                child: InkWell(
                  onTap: () async {
                    await reverseAnimateTransition();
                    final res = await AppRouter.navigate(
                      context,
                      ZoomScreen(activePizza: pizzas[activeIndex]),
                    );
                    if (res) {
                      animateTransition();
                    }
                  },
                  child: SvgPicture.asset('assets/icons/zoom.svg'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Stack cartActions() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: AppSizing.width(context) * 0.32,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: TweenAnimationBuilder(
              duration: miniDuration,
              key: ValueKey(pizzas[activeIndex].quantity),
              tween: Tween<double>(begin: 1, end: 0),
              builder: (context, value, child) {
                final factor = previousQuantity > pizzas[activeIndex].quantity ? -10 : 10;
                return Transform.translate(
                  offset: Offset(0, value * factor),
                  child: Opacity(
                    opacity: 1 - value,
                    child: Text(
                      pizzas[activeIndex].quantity.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: -5,
          child: circleAvatar(
            onTap: () {
              if (pizzas[activeIndex].quantity > 0) {
                setState(() {
                  previousQuantity = pizzas[activeIndex].quantity;
                  final newQuantity = pizzas[activeIndex].quantity - 1;
                  pizzas[activeIndex].quantity = newQuantity;
                });
              }
              if (pizzas[activeIndex].quantity == 0) {
                setState(() {
                  cartItems.removeWhere((item) => item.index == pizzas[activeIndex].index);
                });
              }
            },
            icon: const Icon(Icons.remove),
          ),
        ),
        Positioned(
          right: 0,
          top: -5,
          child: circleAvatar(
            onTap: () {
              setState(() {
                previousQuantity = pizzas[activeIndex].quantity;
                final newQuantity = pizzas[activeIndex].quantity + 1;
                pizzas[activeIndex].quantity = newQuantity;
              });
            },
            icon: Icon(Icons.add),
          ),
        )
      ],
    );
  }

  Widget circleAvatar({required Widget icon, Color? bgColor, Function()? onTap}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: AppSizing.height(context) * 0.06,
      padding: const EdgeInsets.all(15),
      width: AppSizing.height(context) * 0.06,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor ?? Theme.of(context).primaryColorLight,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 1),
        ],
      ),
      child: GestureDetector(onTap: onTap, child: icon),
    );
  }
}
