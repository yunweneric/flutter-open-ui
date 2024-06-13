import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_openui/screens/animated_bg.dart';
import 'package:flutter_openui/utils/assets.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animateRotation;
  Animation<double>? scaleAnimation;
  bool isAnimating = false;
  @override
  void initState() {
    controller = AnimationController(duration: Duration(milliseconds: 2000), vsync: this);
    final Animation<double> curve = CurvedAnimation(parent: controller!, curve: Curves.easeInOutBack);
    animateRotation = Tween<double>(begin: 0, end: pi * 2).animate(curve);
    scaleAnimation = Tween<double>(begin: 1.1, end: 1).animate(curve);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void animate() {
    if (isAnimating) {
      controller!.stop();
    } else {
      controller!.repeat();
    }
    setState(() => isAnimating = !isAnimating);
  }

  stopAndClose() async {
    if (isAnimating) {
      setState(() => isAnimating = !false);
      controller!.stop();
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: AnimatedBG(controller: controller!, animateRotation: animateRotation),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset(AppAsset.listening_grid, color: AppColors.white),
            ),
            chatUi(context),
          ],
        ),
      ),
    );
  }

  Visibility chatUi(BuildContext context) {
    return Visibility(
      visible: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.all(isAnimating ? 10 : 0),
        width: AppSizing.width(context),
        height: AppSizing.height(context),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(isAnimating ? AppSizing.top(context) : 0),
          boxShadow: [
            // BoxShadow(color: Theme.of(context).primaryColor.w, blurRadius: 10, spreadRadius: 2),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: AppSizing.width(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Chip(label: Text("Hey Flutter!")),
                    AppSizing.k10(context),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(radius: 5, backgroundColor: Colors.green),
                        Text("  Online"),
                      ],
                    )
                  ],
                ),
                LottieBuilder.asset(
                  AppAsset.siri,
                  animate: isAnimating,
                  width: AppSizing.width(context) / 2,
                  height: AppSizing.width(context) / 2,
                ),
                SizedBox(
                  height: AppSizing.height(context) / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TweenAnimationBuilder(
                        key: ValueKey(isAnimating),
                        duration: Duration(milliseconds: 600),
                        tween: Tween<Offset>(begin: Offset(0, 50), end: Offset.zero),
                        builder: (context, value, child) {
                          // print(1 - (value.dy / 50).clamp(0, 1));
                          return Transform.translate(
                            offset: value,
                            child: Opacity(
                              opacity: 1 - (value.dy / 20).clamp(0, 1),
                              child: isAnimating
                                  ? Text("Listening ...", style: Theme.of(context).textTheme.displayMedium)
                                  : Text(
                                      "Hi Flutterist 👋\n What can I help you with today?",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.displayMedium,
                                    ),
                            ),
                          );
                        },
                      ),
                      AppSizing.k20(context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circleButton(context, AppAsset.keyboard),
                          InkWell(
                            onTap: () => animate(),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                AnimatedBuilder(
                                  animation: controller!,
                                  builder: (context, value) {
                                    return Transform.scale(
                                      scale: scaleAnimation?.value ?? 1,
                                      child: SvgPicture.asset(AppAsset.mic_circle, color: Theme.of(context).primaryColor),
                                    );
                                  },
                                ),
                                SvgPicture.asset(AppAsset.microphone, color: Theme.of(context).primaryColorDark),
                              ],
                            ),
                          ),
                          circleButton(context, AppAsset.close),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget circleButton(BuildContext context, String icon) {
    return InkWell(
      onTap: () {
        if (icon == AppAsset.close) stopAndClose();
      },
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).cardColor,
        child: SvgPicture.asset(icon, color: Theme.of(context).primaryColorLight),
      ),
    );
  }
}
