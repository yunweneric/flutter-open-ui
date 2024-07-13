import 'package:flutter/material.dart';

class Helper {
  static Color hexToColor(String hex) {
    // Add the leading hash if it's not included
    hex = hex.replaceAll('#', '');
    // Parse the hex string and return a Color object
    return Color(int.parse('FF$hex', radix: 16));
  }
}
