import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/components/pizza_painter.dart';

class PizzaLoader extends StatefulWidget {
  const PizzaLoader({super.key});

  @override
  State<PizzaLoader> createState() => _PizzaLoaderState();
}

class _PizzaLoaderState extends State<PizzaLoader> {
  Timer? timer;
  int activeIndex = 0;
  int previousIndex = 0;
  bool isAdding = true;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 200), (tick) {
      setState(() {
        if (activeIndex >= 7) {
          previousIndex = activeIndex;
          activeIndex = 0;
        } else {
          previousIndex = activeIndex;
          activeIndex += 1;
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(8, (index) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: index <= activeIndex ? 1 : 0,
          child: Image.asset(
            "assets/images/loader_${index}.png",
          ),
        );
      }),
    );
  }
}
