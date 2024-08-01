import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/sizing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<int> items = List.generate(13, (item) => item);
    return Scaffold(
      body: Transform.rotate(
        angle: 0.5 * pi,
        child: ListWheelScrollView(
          perspective: 0.009,
          itemExtent: AppSizing.height(context) * 0.15,
          children: items.map(
            (index) {
              return GestureDetector(
                onTap: () => {},
                child: Transform.rotate(
                  angle: -0.5 * pi,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.teal,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/images/image_${index}.jpg",
                        ),
                      ),
                    ),

                    // height: AppSizing.height(context) * 0.1,
                    width: AppSizing.width(context) * 0.3,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
