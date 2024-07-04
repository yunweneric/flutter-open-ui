import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_openui/model/shopping_item.dart';
import 'package:flutter_openui/screens/component/gradient_btn.dart';
import 'package:flutter_openui/screens/component/shopping_items.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class CartScreen extends StatefulWidget {
  final ShoppingItem item;
  const CartScreen({super.key, required this.item});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final controller = ScrollController();
  @override
  void initState() {
    controller.addListener(listenToScroll);
    super.initState();
  }

  double scaleFactor = 1.0;
  final duration = const Duration(milliseconds: 900);
  final curve = Curves.fastOutSlowIn;
  Offset arrowTranslation = const Offset(0, 0);
  double rotationOffset = 0.0;
  bool isExpanded = true;
  bool isPushing = true;

  listenToScroll() {
    final totalHeight = AppSizing.height(context) * 0.8;
    final offset = controller.offset;
    final scale = 1 - offset / totalHeight;
    final newOffset = Offset(
      AppSizing.width(context) * (offset / totalHeight).clamp(0, 0.4),
      AppSizing.height(context) * (offset / AppSizing.height(context)),
    );

    setState(() {
      arrowTranslation = newOffset;
      scaleFactor = scale;

      if (offset > AppSizing.height(context) * 0.2) {
        isExpanded = false;
      } else {
        isExpanded = true;
      }
    });
  }

  animateAction() {
    controller.animateTo(
      !isExpanded ? AppSizing.height(context) * 0.005 : AppSizing.height(context) * 0.8,
      duration: duration,
      curve: curve,
    );
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  void dispose() {
    controller.removeListener(listenToScroll);
    controller.dispose();
    super.dispose();
  }

  Tween<Offset> generateTween() {
    return isPushing
        ? Tween<Offset>(
            begin: Offset(0, AppSizing.height(context) / 10),
            end: Offset.zero,
          )
        : Tween<Offset>(
            begin: Offset.zero,
            end: Offset(0, AppSizing.height(context) / 10),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 700),
        tween: generateTween(),
        key: ValueKey(isPushing),
        builder: (context, offset, child) {
          return Transform.translate(
            offset: offset,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  children: [
                    topBar(context),
                    shoppingItemSection(context),
                    bottomBar(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget bottomBar() {
    return Container(
      alignment: Alignment.topCenter,
      height: AppSizing.height(context) * 0.9,
      // color: Colors.amber,
      constraints: BoxConstraints(maxHeight: AppSizing.height(context), minHeight: 0),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 100),
                margin: EdgeInsets.only(left: isExpanded ? 20 : 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..translate((1 - scaleFactor).clamp(-20.0, 30.0), 0.0)
                            ..scale(2 - scaleFactor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Cart",
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.white),
                            ),
                          ),
                        ),
                        Transform.scale(
                          alignment: Alignment.centerLeft,
                          scale: scaleFactor,
                          child: Opacity(
                            opacity: scaleFactor.clamp(0, 1),
                            child: Row(
                              children: [
                                ...[2, 3, 4].map((index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2),
                                    child: CircleAvatar(
                                      radius: 18,
                                      child: Image.asset(
                                        "assets/images/shop_item_${index}.png",
                                      ),
                                    ),
                                  );
                                }),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2),
                                  child: CircleAvatar(
                                    radius: 18,
                                    child: Hero(
                                      tag: widget.item.title,
                                      child: Image.asset(
                                        "assets/images/shop_item_${widget.item.index}.png",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Transform.scale(
                      scale: scaleFactor,
                      child: Opacity(
                        opacity: scaleFactor.clamp(0, 1),
                        child: const CircleAvatar(
                          backgroundColor: AppColors.orange,
                          child: Text("04"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              innerCartItems(context)
            ],
          ),
          Positioned(
            top: 0,
            left: -20,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..translate(arrowTranslation.dx, arrowTranslation.dy * 0.95)
                ..rotateZ((pi * -scaleFactor.clamp(0, 1)).clamp(-pi, pi * 2))
                ..scale(2 - scaleFactor),
              child: GestureDetector(
                onTap: () => animateAction(),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.bgCard,
                  child: Transform.scale(scale: 1.8, child: SvgPicture.asset("assets/icons/arrow_down.svg")),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container shoppingItemSection(BuildContext context) {
    return Container(
      height: AppSizing.height(context) * 0.78,
      width: AppSizing.width(context),
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.symmetric(horizontal: AppSizing.width(context) * 0.05),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: const SingleChildScrollView(
        child: ShoppingItems(hideTags: true),
      ),
    );
  }

  Container topBar(BuildContext context) {
    return Container(
      width: AppSizing.width(context),
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.symmetric(horizontal: AppSizing.width(context) * 0.05),
      decoration: const BoxDecoration(color: AppColors.white),
      child: Column(
        children: [
          const SizedBox(height: kToolbarHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = false;
                    isPushing = false;
                  });
                  Navigator.pop(context, true);
                },
                child: const Icon(Icons.arrow_back),
              ),
              Text(
                "Your Cart",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SvgPicture.asset('assets/icons/more.svg'),
            ],
          ),
          AppSizing.k20(context),
        ],
      ),
    );
  }

  Widget innerCartItems(BuildContext context) {
    return TweenAnimationBuilder(
        duration: const Duration(milliseconds: 1000),
        curve: curve,
        key: ValueKey(isExpanded),
        tween: !isExpanded
            ? Tween<Offset>(
                begin: Offset(0, AppSizing.height(context) / 4),
                end: Offset.zero,
              )
            : Tween<Offset>(end: Offset.zero, begin: Offset.zero),
        builder: (context, offset, child) {
          return Transform.translate(
            offset: offset,
            child: Opacity(
              opacity: (1 - scaleFactor).clamp(0, 1),
              child: Column(
                children: [
                  AppSizing.k20(context),
                  SizedBox(
                    height: AppSizing.height(context) * 0.4,
                    width: AppSizing.width(context),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        ...ShoppingItem.data().map((item) {
                          return ListTile(
                            leading: CircleAvatar(
                              child: Image.asset("assets/images/shop_item_${item.index}.png"),
                            ),
                            contentPadding: EdgeInsets.zero,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: AppColors.white,
                                        fontSize: 16,
                                      ),
                                ),
                                AppSizing.k10(context),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.bgCard,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const CircleAvatar(
                                        radius: 18,
                                        backgroundColor: AppColors.circleAvatarDark,
                                        child: Icon(Icons.remove, color: AppColors.white, size: 15),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Text(
                                          item.index.toString(),
                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColors.white),
                                        ),
                                      ),
                                      const CircleAvatar(
                                        radius: 18,
                                        backgroundColor: AppColors.circleAvatarDark,
                                        child: Icon(Icons.add, color: AppColors.white, size: 15),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            trailing: Text(
                              "\$${item.price}",
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.white, fontSize: 16),
                            ),
                          );
                        }).toList()
                      ],
                    ),
                  ),
                  AppSizing.k20(context),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Text(
                      "Total Price",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColors.white),
                    ),
                    trailing: Text(
                      "\$1200",
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.white),
                    ),
                  ),
                  AppSizing.k30(context),
                  GradientButton(onTap: () {}, title: "Checkout")
                ],
              ),
            ),
          );
        });
  }
}
