import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/colors.dart';

class FruitItem {
  final Color color;
  final Color lightColor;
  final String colorName;

  FruitItem({
    required this.color,
    required this.lightColor,
    required this.colorName,
  });
}

List<int> list = List.generate(10, (index) => index);

List<FruitItem> baseList = [
  FruitItem(
    color: AppColors.yellow,
    colorName: "yellow",
    lightColor: AppColors.yellowLight,
  ),
  FruitItem(
    color: AppColors.green,
    colorName: "green",
    lightColor: AppColors.greenLight,
  ),
  FruitItem(
    color: AppColors.purple,
    colorName: "purple",
    lightColor: AppColors.purpleLight,
  ),
];

List<FruitItem> generateItems() {
  List<FruitItem> newList = [];
  for (var _ in list) {
    newList.addAll(baseList);
  }
  return newList;
}
