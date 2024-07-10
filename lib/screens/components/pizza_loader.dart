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
  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 200), (tick) {
      setState(() {
        if (activeIndex >= 7) {
          activeIndex = 0;
        } else
          activeIndex += 1;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        "assets/images/loader_${activeIndex}.png",
      ),
    );

    // return Container(
    //   child: Stack(
    //     children: List.generate(8, (index) {
    //       return AnimatedOpacity(
    //         duration: Duration(milliseconds: 200),
    //         opacity: activeIndex == index ? 1 : 0,
    //         child: Image.asset(
    //           "assets/images/loader_${index}.png",
    //         ),
    //       );
    //     }),
    //   ),
    // );
  }
}
