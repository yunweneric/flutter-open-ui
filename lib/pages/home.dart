import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nike_slider/components/navbar.dart';
import 'package:flutter_nike_slider/components/switcher.dart';
import 'package:flutter_nike_slider/components/video_player.dart';
import 'package:flutter_nike_slider/model/scene.dart';
import 'package:flutter_nike_slider/utils/sizing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  bool hasFocus = false;

  Timer? timer;
  List<AppScene> scenes = [
    AppScene(
      title: 'Exotic Jellyfish',
      desc: 'EVERY TUESDAY | 6PM',
      index: 0,
      videoUrl: 'https://videos.pexels.com/video-files/2731905/2731905-uhd_2560_1440_24fps.mp4',
      thumbnail: 'assets/images/slide_0.png',
      duration: '120 Min',
      longDesc:
          'Experience the mesmerizing beauty of jellyfish as they gracefully glide through the water. Watch their delicate, translucent bodies pulse with an ethereal glow, showcasing a captivating dance of color and light. This video captures the serene and hypnotic movement of these fascinating sea creatures, providing a peaceful and enchanting glimpse into the underwater world',
    ),
    AppScene(
      title: 'Deep Sea Dive',
      desc: 'EVERY FRIDAY | 8PM',
      index: 1,
      videoUrl: 'https://videos.pexels.com/video-files/2556894/2556894-hd_1920_1080_25fps.mp4',
      thumbnail: 'assets/images/slide_1.png',
      duration: '10 Min',
      longDesc:
          "Dive into the thrilling world of sharks with this captivating video. Witness the power and grace of these majestic predators as they glide effortlessly through the ocean. From the sleek great whites to the agile hammerheads, observe their fascinating behavior and impressive hunting skills up close. This video offers an exhilarating glimpse into the lives of one of the ocean's most formidable and awe-inspiring creatures.",
    ),
    AppScene(
      title: 'In Plain Sight',
      desc: 'JULY 27 | 6PM',
      index: 2,
      videoUrl: "https://videos.pexels.com/video-files/14097807/14097807-uhd_2560_1440_30fps.mp4",
      thumbnail: 'assets/images/slide_2.png',
      duration: '90 Min',
      longDesc:
          "Explore the intriguing world of lizards with this fascinating video. Observe the diverse array of these agile reptiles, from the vibrant chameleons to the swift geckos, as they navigate their environments. Watch their unique behaviors, stunning adaptations, and impressive hunting techniques up close. This video provides a captivating glimpse into the lives of these remarkable creatures, showcasing their beauty and the diversity of the reptilian world.",
    ),
  ];

  Widget generateVideoPlayerWidget() {
    return AppVideoPlayer(
      url: scenes[activeIndex].videoUrl,
      thumbnail: scenes[activeIndex].thumbnail,
    );
  }

  @override
  void initState() {
    countdownAnimate();
    super.initState();
  }

  int counter = 100;

  void countdownAnimate() {
    timer = Timer.periodic(const Duration(milliseconds: 50), (time) {
      setState(() {
        counter = --counter;
        if (counter == 0) {
          counter = 100;
          if (activeIndex == 0 || activeIndex < 2) {
            activeIndex = activeIndex + 1;
          } else {
            activeIndex = 0;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Stack(
        children: [
          TweenAnimationBuilder(
            key: ValueKey(activeIndex),
            // curve: Curves.bounceOut,
            curve: Curves.elasticOut,
            duration: const Duration(milliseconds: 1800),
            tween: Tween<Offset>(begin: Offset(0, -Sizing.height(context) * 0.2), end: Offset.zero),
            // duration: const Duration(milliseconds: 2500),
            builder: (context, value, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.01)
                  ..translate(value.dx, value.dy),
                child: TweenAnimationBuilder(
                    key: ValueKey(hasFocus),
                    tween: Tween<double>(begin: hasFocus ? 0 : 10, end: hasFocus ? 10 : 0),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, blurValue, child) {
                      return ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
                        child: AppVideoPlayer(
                          url: scenes[activeIndex].videoUrl,
                          thumbnail: scenes[activeIndex].thumbnail,
                        ),
                      );
                    }),
              );
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Switcher(
              counter: counter,
              onHover: (focus) {
                setState(() {
                  hasFocus = focus;
                });
              },
              scenes: scenes,
              activeIndex: activeIndex,
              onSwitch: (index) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
