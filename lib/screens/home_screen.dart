import 'package:flutter/material.dart';

class TileItem {
  final String title;
  final bool isCompleted;

  TileItem({required this.title, required this.isCompleted});

  TileItem copyWith({
    String? title,
    bool? isCompleted,
  }) {
    return TileItem(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TileItem> items = [
    TileItem(title: "Post on Twitter", isCompleted: false),
    TileItem(title: "Do the dishes", isCompleted: true),
    TileItem(title: "Prepare slides for presentation", isCompleted: false),
    TileItem(title: "Enjoy the ride to uber island", isCompleted: true),
    TileItem(title: "Pick up kids from school", isCompleted: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6E6E6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...items.map(
              (item) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: CheckboxListTile(
                    // enableFeedback: false,
                    // enabled: false,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    tileColor: Colors.white,
                    fillColor: WidgetStateColor.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.black;
                      }
                      return Colors.grey;
                    }),
                    checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    side: BorderSide.none,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: item.isCompleted,
                    onChanged: (value) {
                      setState(() {
                        final index = items.indexOf(item);
                        final newItem = items[index].copyWith(isCompleted: value!);
                        items[index] = newItem;
                      });
                    },
                    title: LayoutBuilder(builder: (context, constraints) {
                      // Measure text width
                      final textPainter = TextPainter(
                        text: TextSpan(
                          text: item.title,
                          style: const TextStyle(color: Colors.black),
                        ),
                        maxLines: 1,
                        textDirection: TextDirection.ltr,
                      )..layout();
                      final textWidth = textPainter.size.width * 1.2;

                      return Stack(
                        children: [
                          Text(item.title),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.decelerate,
                            top: 2,
                            bottom: 0,
                            left: item.isCompleted ? 0 : -textWidth,
                            child: Center(
                              child: Container(
                                height: 2,
                                color: Colors.black,
                                width: textWidth,
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
