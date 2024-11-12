import 'package:flutter/material.dart';

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
    TileItem(title: "Primary", icon: '', color: Colors.blue),
    TileItem(title: "Transactions", icon: '', color: Colors.green),
    TileItem(title: "Updates", icon: '', color: Colors.deepPurple),
    TileItem(title: "Promotions", icon: '', color: Colors.redAccent),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6E6E6),
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
                      final textWidth = textPainter.size.width + 50;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            activeIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                            color: isActive ? item.color : Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: isActive ? textWidth : 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.card_travel),
                              if (isActive) ...[
                                SizedBox(width: 5),
                                SizedBox(
                                  // width: textWidth,
                                  child: Text(
                                    item.title,
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ],
                            ],
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
