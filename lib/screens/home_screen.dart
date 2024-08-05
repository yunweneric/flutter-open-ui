import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/sizing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 209, 207, 207),
      body: GestureDetector(
        child: Container(
          child: Stack(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: TweenAnimationBuilder(
                    curve: Curves.fastOutSlowIn,
                    key: ValueKey(isVisible),
                    duration: const Duration(milliseconds: 1500),
                    tween: isVisible ? Tween<double>(begin: 1, end: 0) : Tween<double>(begin: 0, end: 1),
                    builder: (context, value, child) {
                      return Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.02)
                          ..rotateX(-value * 0.2),
                        child: Transform(
                          alignment: Alignment.topCenter,
                          transform: Matrix4.identity()
                            ..translate(
                              0.0,
                              value * -AppSizing.height(context) * 1.2,
                            )
                            ..scale(1 - value, 1.0),
                          child: mainCard(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: Center(
                  child: Container(
                    height: AppSizing.height(context) * 0.5,
                    color: Colors.transparent,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget mainCard() {
    return Container(
      height: AppSizing.height(context) * 0.6,
      width: AppSizing.width(context),
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/image_7.jpg',
              height: AppSizing.height(context) * 0.4,
              width: AppSizing.width(context),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
            width: AppSizing.width(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Yunwen Eric",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  "Flutter Developer",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
