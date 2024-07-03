import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/colors.dart';

class ShoppingItem {
  final String title;
  final Color color;
  final int price;
  final int discount;
  final int itemSold;
  final int index;

  ShoppingItem({
    required this.title,
    required this.color,
    required this.price,
    required this.discount,
    required this.itemSold,
    required this.index,
  });

  static List<ShoppingItem> data() {
    return [
      ShoppingItem(
        color: AppColors.orangeDark,
        title: "Women's Handbag",
        price: 3499,
        discount: 20,
        itemSold: 180,
        index: 6,
      ),
      ShoppingItem(
        color: AppColors.darkBlue,
        title: "Men's Casual Shirt",
        price: 1999,
        discount: 20,
        itemSold: 150,
        index: 1,
      ),
      ShoppingItem(
        color: AppColors.blue,
        title: "Women's Summer Dress",
        price: 2499,
        discount: 25,
        itemSold: 200,
        index: 2,
      ),
      ShoppingItem(
        color: AppColors.yellow,
        title: "Unisex Sneakers",
        price: 2999,
        discount: 15,
        itemSold: 300,
        index: 3,
      ),
      ShoppingItem(
        color: AppColors.orangeDark,
        title: "Leather Jacket",
        price: 4999,
        discount: 30,
        itemSold: 120,
        index: 4,
      ),
      ShoppingItem(
        title: "Classic Blue Jeans",
        color: AppColors.darkBlue,
        price: 1799,
        discount: 10,
        itemSold: 400,
        index: 5,
      ),
    ];
  }
}
