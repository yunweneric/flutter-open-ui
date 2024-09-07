import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/sizing.dart';

class NFTCard {
  final String title;
  final Color color;
  final String image;

  NFTCard({required this.title, required this.color, required this.image});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NFTCard> cards = [
    NFTCard(title: "title", color: Colors.orange, image: "assets/images/craft_0.jpg"),
    NFTCard(title: "title", color: Colors.blue, image: "assets/images/craft_1.jpg"),
    NFTCard(title: "title", color: Colors.yellow, image: "assets/images/craft_2.jpg"),
    NFTCard(title: "title", color: Colors.pink, image: "assets/images/craft_3.jpg"),
    NFTCard(title: "title", color: Colors.tealAccent, image: "assets/images/craft_4.jpg"),
    NFTCard(title: "title", color: Color(0xff17502F), image: "assets/images/craft_5.jpg"),
  ];

  final duration = const Duration(milliseconds: 500);
  int activeIndex = 2;
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 2, viewportFraction: 0.9);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: duration,
        height: AppSizing.height(context),
        width: AppSizing.width(context),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              cards[activeIndex].color,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              height: AppSizing.height(context) * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(cards.length, (i) => i).map((index) {
                    return Container(
                      width: AppSizing.width(context) / (cards.length + 1),
                      margin: EdgeInsets.only(left: 5),
                      height: 2,
                      color: Colors.black,
                    );
                  })
                ],
              ),
            ),
            Container(
              height: AppSizing.height(context) * 0.5,
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (page) {
                  setState(() {
                    activeIndex = page;
                  });
                },
                itemCount: cards.length,
                itemBuilder: (c, i) {
                  final item = cards[i];
                  return Container(
                    transformAlignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.01)
                      ..rotateZ(pi * 3)
                      ..scale(1.0, 1, 0.3),
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        item.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
