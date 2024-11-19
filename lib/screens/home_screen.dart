import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class TileItem {
  final String title;
  final String icon;
  final Color color;

  TileItem({required this.title, required this.icon, required this.color});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  List<TileItem> items = [
    TileItem(title: "Primary", icon: 'assets/icons/user.svg', color: Colors.blue),
    TileItem(title: "Transactions", icon: 'assets/icons/cart.svg', color: Colors.green),
    TileItem(title: "Updates", icon: 'assets/icons/chat.svg', color: Colors.deepPurple),
    // TileItem(title: "Files", icon: 'assets/icons/files.svg', color: Colors.redAccent),
  ];

  double textWidth = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizing.width(context) * 0.04),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: AppSizing.width(context) * 0.02, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: AnimatedAlign(
                    curve: Curves.decelerate,
                    duration: const Duration(milliseconds: 300),
                    alignment: activeIndex == 0
                        ? Alignment.centerLeft
                        : activeIndex == 1
                            ? Alignment.topCenter
                            : Alignment.centerRight,
                    child: Container(
                      width: textWidth,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...items.map(
                      (item) {
                        final index = items.indexOf(item);
                        return LayoutBuilder(builder: (context, c) {
                          final textPainter = TextPainter(
                            text: TextSpan(
                              text: item.title,
                              style: const TextStyle(color: Colors.black),
                            ),
                            maxLines: 1,
                            textDirection: TextDirection.ltr,
                          )..layout();
                          final width = textPainter.size.width + AppSizing.width(context) * 0.12;
                          textWidth = width;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: textWidth,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () => setState(() {
                                activeIndex = index;
                                textWidth = width;
                              }),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: TweenAnimationBuilder<double>(
                                    key: ValueKey(activeIndex),
                                    duration: const Duration(milliseconds: 500),
                                    tween: Tween(begin: activeIndex == index ? 4.0 : 0.0, end: 0),
                                    builder: (context, value, child) {
                                      return ImageFiltered(
                                        imageFilter: ImageFilter.blur(sigmaX: value, sigmaY: value, tileMode: TileMode.decal),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(item.icon, height: 20),
                                            SizedBox(width: AppSizing.width(context) * 0.02),
                                            Text(
                                              item.title,
                                              softWrap: true,
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
