import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_openui/model/shopping_item.dart';
import 'package:flutter_openui/screens/shop_item_details.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/helper.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class ShoppingItems extends StatefulWidget {
  final bool? hideTags;
  const ShoppingItems({super.key, this.hideTags});

  @override
  State<ShoppingItems> createState() => _ShoppingItemsState();
}

class _ShoppingItemsState extends State<ShoppingItems> {
  bool isPushing = false;
  final duration = const Duration(milliseconds: 900);
  Tween<Offset> generateTweens() {
    return isPushing
        ? Tween<Offset>(
            begin: Offset.zero,
            end: Offset(0, AppSizing.height(context) / 5),
          )
        : Tween<Offset>(
            begin: Offset(0, AppSizing.height(context)),
            end: Offset.zero,
          );
  }

  Tween<double> generateScaleTween() {
    return !isPushing ? Tween<double>(begin: 0, end: 1) : Tween<double>(begin: 1, end: 0);
  }

  List<ShoppingItem> items = ShoppingItem.data();
  late ShoppingItem selectedItem;
  @override
  void initState() {
    selectedItem = items.first;
    super.initState();
  }

  final curve = Curves.fastOutSlowIn;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      children: [
        ...items.map((e) => shoppingItem(e)).toList(),
      ],
    );
  }

  Widget shoppingItem(ShoppingItem item) {
    return TweenAnimationBuilder(
        tween: item == selectedItem ? Tween<Offset>(begin: Offset.zero, end: Offset.zero) : generateTweens(),
        key: ValueKey(item.index),
        duration: duration,
        curve: curve,
        builder: (context, offset, child) {
          return Transform.translate(
            offset: offset,
            child: Container(
              margin: EdgeInsets.only(bottom: item.index % 2 == 0 ? 30 : 0),
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    selectedItem = item;
                    isPushing = !isPushing;
                  });
                  final result = await UtilHelper.navigate(
                    context: context,
                    page: ShopItemDetails(item: item),
                  );
                  setState(() {
                    isPushing = result;
                  });
                },
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        height: 30,
                        width: 30,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.grayLight),
                        ),
                        child: SvgPicture.asset("assets/icons/heart.svg"),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: widget.hideTags == true ? Random().nextDouble() * 1000 : item.title,
                          child: Container(
                            width: AppSizing.width(context) * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: item.color.withOpacity(0.1),
                            ),
                            child: Image.asset("assets/images/shop_item_${item.index}.png"),
                          ),
                        ),
                        TweenAnimationBuilder(
                            tween: item != selectedItem ? Tween<double>(begin: 1, end: 1) : generateScaleTween(),
                            key: ValueKey(item.index),
                            duration: duration,
                            builder: (context, value, child) {
                              return Transform.scale(
                                alignment: item.index % 2 == 0 ? Alignment.bottomLeft : Alignment.bottomRight,
                                scale: value,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppSizing.k5(context),
                                    Text(item.title),
                                    Text(item.price.toString()),
                                    SizedBox(
                                      width: AppSizing.width(context) * 0.42,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        dense: true,
                                        leading: Text(
                                          "\$${item.price}",
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w800,
                                              ),
                                        ),
                                        title: Text(
                                          "\$${item.discount}",
                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                decoration: TextDecoration.lineThrough,
                                                fontWeight: FontWeight.w100,
                                                fontSize: 11,
                                              ),
                                        ),
                                        trailing: Transform.scale(
                                          scale: 0.8,
                                          child: Chip(
                                            side: BorderSide.none,
                                            padding: EdgeInsets.zero,
                                            label: Text(
                                              "${item.itemSold} Sold",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
