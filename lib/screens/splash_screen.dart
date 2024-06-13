import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_openui/screens/home_screen.dart';
import 'package:flutter_openui/utils/assets.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animateRotation;

  @override
  void initState() {
    controller = AnimationController(duration: Duration(seconds: 20), vsync: this)..repeat();
    final Animation<double> curve = CurvedAnimation(parent: controller!, curve: Curves.linear);
    animateRotation = Tween<double>(begin: 0, end: pi * 2).animate(curve);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            // top: 50,
            child: AnimatedBuilder(
              animation: controller!,
              builder: (context, value) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.02)
                    ..rotateZ(animateRotation?.value ?? 0)
                    ..rotateY(0.2)
                    ..rotateX(0.01),
                  child: SvgPicture.asset(
                    AppAsset.splash_grid,
                    color: Colors.white.withOpacity(0.3),
                    width: AppSizing.width(context),
                    height: AppSizing.height(context) * 0.6,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Container(
              width: AppSizing.width(context),
              height: AppSizing.height(context),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      AppSizing.k20(context),
                      TweenAnimationBuilder(
                        tween: Tween<Offset>(begin: Offset(0, -500), end: Offset.zero),
                        curve: Curves.bounceInOut,
                        duration: const Duration(seconds: 3),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: value,
                            child: Opacity(
                              opacity: 1 - (value.dy / 500).clamp(0, 1),
                              child: const Chip(label: Text("Personal AI Buddy")),
                            ),
                          );
                        },
                      ),
                      AppSizing.k20(context),
                      AppSizing.k20(context),
                    ],
                  ),
                  Container(
                    // color: AppColors.pink,
                    alignment: Alignment.center,
                    height: AppSizing.height(context) * 0.5,
                    child: Transform.scale(scale: 1.2, child: Image.asset(AppAsset.botImage)),
                  ),
                  TweenAnimationBuilder(
                      tween: Tween<Offset>(begin: Offset(0, 500), end: Offset.zero),
                      curve: Curves.elasticOut,
                      duration: const Duration(seconds: 5),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: value,
                          child: Opacity(
                            opacity: 1 - (value.dy / 500).clamp(0, 1),
                            child: Column(
                              children: [
                                Text(
                                  "How may I help \n you today!",
                                  style: Theme.of(context).textTheme.displayLarge,
                                  textAlign: TextAlign.center,
                                ),
                                AppSizing.k30(context),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: ((context, animation, secondaryAnimation) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: const HomeScreen(),
                                          );
                                        }),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    fixedSize: Size(AppSizing.width(context), 60),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                    backgroundColor: AppColors.white,
                                  ),
                                  child: Text("Get Started", style: TextStyle(color: Theme.of(context).primaryColorDark)),
                                ),
                                AppSizing.k30(context),
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
