import 'package:flutter/material.dart';

class Category {
  final String label;
  final String title;
  final Color color;
  final int? percentage;
  final bool? isChecked;

  Category({
    required this.label,
    required this.title,
    required this.color,
    this.percentage,
    this.isChecked,
  });

  Category copyWith({
    String? label,
    String? title,
    Color? color,
    int? percentage,
    bool? isChecked,
  }) {
    return Category(
      label: label ?? this.label,
      title: title ?? this.title,
      color: color ?? this.color,
      percentage: percentage ?? this.percentage,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
