import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openui/screens/animated_bg.dart';
import 'package:flutter_openui/screens/chat_screen.dart';
import 'package:flutter_openui/utils/assets.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  List<ListItem> items = [
    ListItem(title: "I need some UI inspiration for dark...", icon: AppAsset.speech, color: AppColors.pink),
    ListItem(title: "Show me some color palettes for AI...", icon: AppAsset.chat, color: AppColors.purple),
    ListItem(title: "What are the best mobile apps 2023...", icon: AppAsset.picture, color: AppColors.purple),
  ];

  AnimationController? controller;
  Animation<double>? animateRotation;
  Animation<double>? scaleAnimation;
  bool isAnimating = false;
  @override
  void initState() {
    controller = AnimationController(duration: Duration(seconds: 5), vsync: this)..repeat();
    final Animation<double> curve = CurvedAnimation(parent: controller!, curve: Curves.ease);
    animateRotation = Tween<double>(begin: 0, end: pi * 2).animate(curve);
    scaleAnimation = Tween<double>(begin: 1.1, end: 1).animate(curve);
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
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
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
              top: -20,
              left: 50,
              child: SvgPicture.asset(
                AppAsset.home_grid,
                color: AppColors.white.withOpacity(0.8),
                width: AppSizing.width(context),
                height: AppSizing.height(context) * 0.4,
              ),
            ),
            SafeArea(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                width: AppSizing.width(context),
                height: AppSizing.height(context),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appbar(context),
                      AppSizing.k30(context),
                      Text("How may I help\nyou today?", style: Theme.of(context).textTheme.displayLarge),
                      AppSizing.k30(context),
                      homeCards(context),
                      AppSizing.k20(context),
                      listItems(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column listItems(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text("History", style: Theme.of(context).textTheme.displayMedium),
          trailing: Text("See all", style: Theme.of(context).textTheme.displaySmall),
        ),
        ...items.map(
          (e) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).cardColor.withOpacity(0.8),
            ),
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              tileColor: Theme.of(context).cardColor,
              leading: CircleAvatar(
                backgroundColor: e.color,
                child: Image.asset(e.icon, height: 20, width: 20),
              ),
              title: Text(
                e.title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: Icon(Icons.more_vert_rounded),
            ),
          ),
        )
      ],
    );
  }

  Row homeCards(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: ((context, animation, secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: const ChatScreen(),
                  );
                }),
              ),
            );
          },
          child: Container(
            height: AppSizing.height(context) * 0.25,
            width: AppSizing.width(context) * 0.42,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      child: Image.asset(AppAsset.speech, width: 20, height: 20),
                      backgroundColor: Theme.of(context).cardColor.withOpacity(0.2),
                    ),
                    Icon(CupertinoIcons.arrow_up_right),
                  ],
                ),
                Text(
                  "Talk \nwith Bot",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 28, color: AppColors.bgColor),
                )
              ],
            ),
          ),
        ),
        Column(
          children: [
            homeMinorCard(
              context: context,
              icon: AppAsset.chat,
              text: "Chat with bot",
              color: AppColors.pink,
            ),
            AppSizing.k10(context),
            homeMinorCard(
              context: context,
              icon: AppAsset.picture,
              text: "Search by Image",
              color: AppColors.purple,
            ),
          ],
        )
      ],
    );
  }

  Row appbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).cardColor,
          child: SvgPicture.asset(AppAsset.menu),
        ),
        Text("Hi, Flutter 👋"),
        ClipOval(
          child: Image.asset(AppAsset.user, width: 40, height: 40),
        ),
      ],
    );
  }

  Container homeMinorCard({required BuildContext context, required String icon, required Color color, required String text}) {
    return Container(
      height: AppSizing.height(context) * 0.25 * 0.48,
      width: AppSizing.width(context) * 0.42,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).cardColor.withOpacity(0.2),
                child: Image.asset(icon, width: 20, height: 20),
              ),
              Icon(CupertinoIcons.arrow_up_right),
            ],
          ),
          Text(
            text,
            style: TextStyle(color: AppColors.bgColor, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class ListItem {
  final String title;
  final String icon;
  final Color color;

  ListItem({required this.title, required this.icon, required this.color});
}
