import 'package:flutter/material.dart';
import 'package:flutter_3d_nike_shop/utils/colors.dart';

class CartItem {
  final int index;
  final String title;
  final String desc;
  final String price;
  final Color main;
  final Color light;

  CartItem({
    required this.index,
    required this.title,
    required this.desc,
    required this.price,
    required this.main,
    required this.light,
  });
}

List<CartItem> items = [
  CartItem(
    index: 0,
    title: "Nike Air Max Pre-Day Green",
    desc:
        "Taking the classic look of heritage Nike Running into a new realm, the Nike Air Max Pre-Day brings you a fast-paced look that's ready for today's world.A true nod to the past with a design made from at least 20% recycled material by weight.",
    price: "55,000 XAF",
    main: AppColors.bGreen,
    light: AppColors.lightGreen,
  ),
  CartItem(
    index: 1,
    title: "Nike Air Max Pre-Day Red",
    desc:
        "Taking the classic look of heritage Nike Running into a new realm, the Nike Air Max Pre-Day brings you a fast-paced look that's ready for today's world.A true nod to the past with a design made from at least 20% recycled material by weight.",
    price: "30,000 XAF",
    main: AppColors.bgRed,
    light: AppColors.lightRed,
  ),
  CartItem(
    index: 2,
    title: "Nike Air Max Pre-Day Gray",
    desc:
        "Taking the classic look of heritage Nike Running into a new realm, the Nike Air Max Pre-Day brings you a fast-paced look that's ready for today's world.A true nod to the past with a design made from at least 20% recycled material by weight.",
    price: "73,000 XAF",
    main: AppColors.bgGray,
    light: AppColors.lightGray,
  )
];
