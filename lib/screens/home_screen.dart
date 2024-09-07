import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/sizing.dart';

class NFTCard {
  final String title;
  final Color color;
  final Color textColor;
  final String image;

  NFTCard({required this.title, required this.color, required this.image, required this.textColor});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NFTCard> cards = [
    NFTCard(title: "Greenfield", color: const Color(0XFFFEAC00), image: "assets/images/craft_0.jpg", textColor: Colors.white),
    NFTCard(title: "Zenithal", color: const Color(0XFFCE8300), image: "assets/images/craft_2.jpg", textColor: Colors.white),
    NFTCard(title: "Nexis", color: const Color(0XFF7DA2D6), image: "assets/images/craft_1.jpg", textColor: Colors.black),
    NFTCard(title: "Horizon Drift", color: const Color(0XFFFE348C), image: "assets/images/craft_3.jpg", textColor: Colors.white),
    NFTCard(title: "Ares Arizonal", color: const Color(0XFFE7851E), image: "assets/images/craft_4.jpg", textColor: Colors.white),
    NFTCard(title: "Constant Lindre", color: const Color(0XFF537327), image: "assets/images/craft_5.jpg", textColor: Colors.black),
  ];

  final duration = const Duration(milliseconds: 500);
  int activeIndex = 1;
  PageController? _controller;

  bool initialAnimate = false;

  @override
  void initState() {
    _controller = PageController(viewportFraction: 0.65);
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        initialAnimate = !initialAnimate;
      });
      _controller?.animateToPage(1, duration: const Duration(milliseconds: 5000), curve: Curves.elasticOut);
    });
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
            AnimatedContainer(
              duration: const Duration(milliseconds: 2500),
              curve: Curves.elasticOut,
              transform: Matrix4.identity()..translate(0.0, initialAnimate ? 0 : -150.0),
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
                    margin: const EdgeInsets.symmetric(vertical: 30),
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
                          TextSpan(text: ' gallery ', style: TextStyle(fontStyle: FontStyle.italic)),
                          TextSpan(text: ' Now'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSizing.height(context) * 0.4,
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (page) {
                  _controller?.animateToPage(page, duration: duration, curve: Curves.easeOutBack);
                  setState(() => activeIndex = page);
                },
                itemCount: cards.length,
                itemBuilder: (c, i) {
                  final item = cards[i];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AnimatedContainer(
                      duration: duration,
                      clipBehavior: Clip.none,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      transformAlignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.02)
                        ..rotateX(-0.02)
                        ..rotateY(-0.03),
                      child: AnimatedScale(
                        duration: duration,
                        scale: activeIndex == i ? 1.0 : 0.6,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                alignment: Alignment.bottomCenter,
                                height: AppSizing.height(context) * 0.4,
                                width: AppSizing.height(context) * 0.4,
                                item.image,
                                fit: BoxFit.cover,
                              ),
                              // if (i == 3 || i == 0)
                              Positioned(
                                child: Container(
                                  color: Colors.black.withOpacity(i == 3 || i == 0 ? 0.4 : 0.05),
                                ),
                              ),
                              Positioned(
                                bottom: 30,
                                left: 0,
                                right: 0,
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.01)
                                    ..rotateX(0.0)
                                    ..rotateY(-0.01),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          // color: Colors.black.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          item.title,
                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                color: item.textColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 25,
                                              ),
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
            AnimatedContainer(
              duration: const Duration(milliseconds: 2500),
              curve: Curves.elasticOut,
              transform: Matrix4.identity()..translate(0.0, initialAnimate ? 0 : 150.0),
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
                  const Text(
                    "Owned by you!",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
