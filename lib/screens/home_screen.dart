import 'package:flutter/material.dart';
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
    TileItem(title: "Files", icon: 'assets/icons/files.svg', color: Colors.redAccent),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E6E6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...items.map(
                (item) {
                  final index = items.indexOf(item);
                  final isActive = activeIndex == index;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: LayoutBuilder(builder: (context, c) {
                      final textPainter = TextPainter(
                        text: TextSpan(
                          text: item.title,
                          style: const TextStyle(color: Colors.black),
                        ),
                        maxLines: 1,
                        textDirection: TextDirection.ltr,
                      )..layout();
                      final textWidth = textPainter.size.width + 40;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            activeIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                            color: isActive ? item.color : Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: isActive ? textWidth : 40,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(item.icon, height: 15, color: isActive ? Colors.white : null),
                                if (isActive) ...[
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    child: Text(
                                      item.title,
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(fontSize: 12, color: isActive ? Colors.white : null),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
