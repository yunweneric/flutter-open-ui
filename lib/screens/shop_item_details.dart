import 'package:flutter/material.dart';
import 'package:flutter_openui/model/shopping_item.dart';
import 'package:flutter_openui/screens/cart_screen.dart';
import 'package:flutter_openui/screens/component/gradient_btn.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/helper.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class Huddy {
  final int index;
  final Color color;

  Huddy({required this.index, required this.color});
}

class ShoppingSize {
  final String label;
  final double factor;

  ShoppingSize({required this.label, required this.factor});
}

class ShopItemDetails extends StatefulWidget {
  final ShoppingItem item;
  const ShopItemDetails({super.key, required this.item});

  @override
  State<ShopItemDetails> createState() => _ShopItemDetailsState();
}

class _ShopItemDetailsState extends State<ShopItemDetails> {
  List<Huddy> huddies = [
    Huddy(index: 0, color: AppColors.blue),
    Huddy(index: 1, color: AppColors.orangeDark),
    Huddy(index: 2, color: AppColors.darkBlue),
    Huddy(index: 3, color: AppColors.orange),
  ];
  late ShoppingSize activeSize;

  final duration = const Duration(milliseconds: 900);
  final curve = Curves.fastOutSlowIn;
  List<ShoppingSize> sizes = [
    ShoppingSize(label: "XS", factor: 0.8),
    ShoppingSize(label: "S", factor: 0.9),
    ShoppingSize(label: "M", factor: 1),
    ShoppingSize(label: "L", factor: 1.2),
    ShoppingSize(label: "XL", factor: 1.3),
    ShoppingSize(label: "XXL", factor: 1.4),
  ];
  int quantity = 0;
  bool isPushing = true;
  late String tag;

  @override
  void initState() {
    setState(() {
      tag = widget.item.title;
      activeSize = sizes[2];
    });
    super.initState();
  }

  Tween<Offset> generateTween() {
    return isPushing
        ? Tween<Offset>(
            begin: Offset(0, AppSizing.height(context)),
            end: Offset.zero,
          )
        : Tween<Offset>(
            begin: Offset.zero,
            end: Offset(0, AppSizing.height(context)),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: TweenAnimationBuilder(
          duration: duration,
          curve: curve,
          tween: generateTween(),
          key: ValueKey(isPushing),
          builder: (context, value, child) {
            return Transform.translate(offset: value, child: bottomAddBar(context));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shoppingItemHero(context),
            TweenAnimationBuilder(
                duration: duration,
                curve: curve,
                tween: generateTween(),
                key: ValueKey(isPushing),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSizing.k20(context),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.grayLight.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...huddies.map((huddy) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: huddy.color.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Image.asset(
                                    "assets/images/huddies_${huddy.index}.png",
                                    scale: 4,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        AppSizing.k20(context),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(widget.item.title, style: Theme.of(context).textTheme.displayMedium),
                                  Text("\$${widget.item.price}", style: Theme.of(context).textTheme.displayMedium),
                                ],
                              ),
                              AppSizing.k10(context),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/icons/star.svg"),
                                      Text("4.3(2.5k Reviews)", style: Theme.of(context).textTheme.bodyMedium),
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 10),
                                        child: CircleAvatar(
                                          backgroundColor: Theme.of(context).primaryColor,
                                          radius: 5,
                                        ),
                                      ),
                                      Chip(
                                        label: Text("${widget.item.itemSold} Sold", style: Theme.of(context).textTheme.bodySmall),
                                        backgroundColor: AppColors.grayLight,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "\$${widget.item.discount}",
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                          decoration: TextDecoration.lineThrough,
                                          color: AppColors.gray,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        AppSizing.k10(context),
                        Container(
                          height: 2,
                          width: AppSizing.width(context),
                          decoration: BoxDecoration(
                            color: AppColors.bgCard,
                            gradient: LinearGradient(
                              stops: const [0.1, 0.5, 0.85],
                              colors: [Colors.transparent, AppColors.grayLight.withOpacity(0.5), Colors.transparent],
                            ),
                          ),
                        ),
                        AppSizing.k20(context),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sizes", style: Theme.of(context).textTheme.displayMedium),
                              AppSizing.k10(context),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: sizes.map((e) {
                                  return GestureDetector(
                                    onTap: () => setState(() {
                                      activeSize = e;
                                    }),
                                    child: Chip(
                                      backgroundColor: activeSize == e ? Theme.of(context).primaryColor : Colors.transparent,
                                      label: Text(e.label),
                                      side: BorderSide(
                                        color: activeSize == e ? Theme.of(context).primaryColor : AppColors.grayLight,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Container bottomAddBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => setState(() {
                  if (quantity > 0) quantity = --quantity;
                }),
                child: const CircleAvatar(
                  backgroundColor: AppColors.grayLight,
                  child: Icon(Icons.remove),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                child: TweenAnimationBuilder(
                  duration: duration,
                  curve: Curves.easeInOutBack,
                  key: ValueKey(quantity),
                  tween: Tween<double>(begin: 1.5, end: 1),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Text(
                        "${quantity < 10 ? "0$quantity" : quantity}",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  quantity = ++quantity;
                }),
                child: const CircleAvatar(
                  backgroundColor: AppColors.grayLight,
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
          GradientButton(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            onTap: () async {
              setState(() {
                isPushing = !isPushing;
              });
              await UtilHelper.navigate(
                context: context,
                page: CartScreen(item: widget.item),
              );
              setState(() {
                isPushing = !isPushing;
              });
            },
            title: "Add to cart",
          ),
        ],
      ),
    );
  }

  Stack shoppingItemHero(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: tag,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.item.color.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: AnimatedScale(
              curve: Curves.elasticInOut,
              scale: activeSize.factor,
              duration: Duration(seconds: 2),
              child: Image.asset(
                "assets/images/shop_item_${widget.item.index}.png",
                scale: 0.4,
              ),
            ),
          ),
        ),
        Positioned(
          top: AppSizing.height(context) * 0.06,
          left: 15,
          right: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isPushing = !isPushing;
                  });
                  Navigator.pop(context, isPushing);
                },
                child: const Icon(Icons.arrow_back),
              ),
              Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gray),
                ),
                child: SvgPicture.asset("assets/icons/heart.svg"),
              )
            ],
          ),
        ),
      ],
    );
  }
}
