import 'package:flutter/material.dart';

class CarComponent extends StatelessWidget {
  final int index;
  const CarComponent({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/car_$index.png");
  }
}
