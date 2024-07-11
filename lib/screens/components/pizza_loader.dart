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
  bool isAdding = true;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (tick) {
      setState(() {
        if (activeIndex > 8) {
          activeIndex = 0;
        } else {
          activeIndex += 1;
        }
        // if (isAdding) {
        //   activeIndex++;
        //   if (activeIndex >= 8) {
        //     isAdding = false;
        //   }
        // } else {
        //   activeIndex--;
        //   if (activeIndex <= 0) {
        //     isAdding = true;
        //   }
        // }
      });
      print(activeIndex);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.asset(
            "assets/images/loader_${7}.png",
            width: 250,
            height: 250,
            fit: BoxFit.contain,
          ),
          Container(
            child: CustomPaint(
              size: Size(250, 250),
              painter: Ellipse43Painter(index: 8),
            ),
          )
        ],
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
