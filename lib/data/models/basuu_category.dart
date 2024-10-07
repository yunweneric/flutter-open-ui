import 'package:flutter/material.dart';

class BasuuCategory {
  final String label;
  final String title;
  final Color color;
  final int? percentage;
  final bool? isChecked;

  BasuuCategory({
    required this.label,
    required this.title,
    required this.color,
    this.percentage,
    this.isChecked,
  });

  BasuuCategory copyWith({
    String? label,
    String? title,
    Color? color,
    int? percentage,
    bool? isChecked,
  }) {
    return BasuuCategory(
      label: label ?? this.label,
      title: title ?? this.title,
      color: color ?? this.color,
      percentage: percentage ?? this.percentage,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
