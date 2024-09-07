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
    NFTCard(title: "title", color: const Color(0XFFFEAC00), image: "assets/images/craft_0.jpg"),
    NFTCard(title: "title", color: const Color(0XFF7DA2D6), image: "assets/images/craft_1.jpg"),
    NFTCard(title: "title", color: const Color(0XFFCE8300), image: "assets/images/craft_2.jpg"),
    NFTCard(title: "title", color: const Color(0XFFFE348C), image: "assets/images/craft_3.jpg"),
    NFTCard(title: "title", color: const Color(0XFFE7851E), image: "assets/images/craft_4.jpg"),
    NFTCard(title: "title", color: const Color(0XFF537327), image: "assets/images/craft_5.jpg"),
  ];

  final duration = const Duration(milliseconds: 500);
  int activeIndex = 2;
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 2, viewportFraction: 0.65);
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
              cards[activeIndex].color.withOpacity(0.2),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              height: AppSizing.height(context) * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20, top: 30),
                    child: Text("${activeIndex + 1}/${cards.length}"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(cards.length, (i) => i).map((index) {
                        final width = AppSizing.width(context) / (cards.length + 1);
                        return AnimatedContainer(
                          duration: duration,
                          width: activeIndex == index ? width * 1.8 : width * 0.8,
                          margin: const EdgeInsets.only(left: 5),
                          // height: activeIndex == index ? 5 : 2,
                          height: activeIndex == index ? 4 : 2.5,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        );
                      })
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Explore Your',
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 45,
                            ),
                        children: const <TextSpan>[
                          TextSpan(text: '\nNTF'),
                          TextSpan(text: ' gallery', style: TextStyle(fontStyle: FontStyle.italic)),
                          TextSpan(text: ' Now'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: AppSizing.height(context) * 0.4,
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (page) {
                  _controller?.animateToPage(page, duration: duration, curve: Curves.decelerate);
                  setState(() => activeIndex = page);
                },
                itemCount: cards.length,
                itemBuilder: (c, i) {
                  final item = cards[i];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Transform(
                      transform: Matrix4.skew(0, 0),
                      child: AnimatedContainer(
                        duration: duration,
                        clipBehavior: Clip.none,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        transformAlignment: Alignment.center,
                        transform: Matrix4.identity()..scale(activeIndex == i ? 1.0 : 0.6),
                        margin: const EdgeInsets.symmetric(horizontal: 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                item.image,
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                bottom: 20,
                                left: 0,
                                right: 0,
                                child: Column(
                                  children: [
                                    Text(
                                      item.title,
                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    Chip(
                                      elevation: 0,
                                      surfaceTintColor: Colors.teal,
                                      backgroundColor: Colors.black.withOpacity(1),
                                      side: BorderSide.none,
                                      labelStyle: const TextStyle(
                                        color: Color.fromARGB(255, 229, 229, 229),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      label: Text("Umbrella"),
                                      avatar: ClipOval(
                                        child: Image.asset(
                                          "assets/images/craft_0.jpg",
                                          width: 20,
                                          height: 20,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: AppSizing.height(context) * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/images/craft_0.jpg",
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text("Owned by you!")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
