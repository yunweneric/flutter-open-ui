import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class CardItem {
  final String title;
  final String date;
  final String subtitle;

  CardItem({required this.title, required this.date, required this.subtitle});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isExpanded = true;

  List<CardItem> items = [
    CardItem(title: "Firebase", date: "April 2012", subtitle: "Acquired by Google in 2014"),
    CardItem(title: "Flutter", date: "May 2017", subtitle: "Developed by Google"),
    CardItem(title: "Dart", date: "October 2011", subtitle: "Developed by Google"),
    CardItem(title: "VS Code", date: "April 2015", subtitle: "Developed by Microsoft"),
  ];

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isExpanded = !isExpanded;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: AppSizing.height(context),
        width: AppSizing.width(context),
        child: Center(
          child: Container(
            alignment: Alignment.center,
            height: AppSizing.height(context) * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: pi,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...List.generate(items.length, (i) => i).map((index) {
                          final scaleFactor = isExpanded ? 1.0 : 1 - (items.length - 1.0 * index) / 30;
                          final item = items[index];
                          return AnimatedAlign(
                            duration: const Duration(milliseconds: 2500),
                            alignment: Alignment.center,
                            curve: Curves.elasticInOut,
                            heightFactor: isExpanded ? 1.2 : 0.15,
                            child: AnimatedScale(
                              scale: scaleFactor,
                              duration: const Duration(milliseconds: 2500),
                              alignment: Alignment.center,
                              curve: Curves.elasticInOut,
                              child: Transform.rotate(
                                angle: pi,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 2, spreadRadius: 1),
                                    ],
                                  ),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(color: AppColors.bgBlack.withOpacity(0.1)),
                                    ),
                                    leading: Container(
                                      width: 50,
                                      height: 50,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppColors.bgBlack,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: SvgPicture.asset(
                                        width: 50,
                                        height: 50,
                                        "assets/images/${item.title.split(' ').join("").toLowerCase()}.svg",
                                      ),
                                    ),
                                    title: Text(item.title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                                    subtitle: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(item.subtitle),
                                        Text(item.date),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: AppSizing.height(context) * 0.08),
                TweenAnimationBuilder(
                  key: ValueKey(isExpanded),
                  tween: isExpanded ? Tween(begin: 1.0, end: 0.0) : Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 2500),
                  builder: (context, value, child) {
                    return ElevatedButton(
                      iconAlignment: IconAlignment.end,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(value <= 0.5 ? "Hide" : "Show All"),
                          Icon(value >= 0.5 ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up_rounded),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
