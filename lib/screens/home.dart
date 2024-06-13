import 'package:flutter/material.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              width: AppSizing.width(context),
              height: AppSizing.height(context),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Chip(label: Text("Personal AI Buddy")),
                  AppSizing.k20(context),
                  AppSizing.k20(context),
                  Container(
                    // color: AppColors.pink,
                    alignment: Alignment.center,
                    height: AppSizing.height(context) * 0.5,
                    child: Transform.scale(scale: 1.2, child: Image.asset(AppAsset.botImage)),
                  ),
                  Text(
                    "How may I help \n you today!",
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  AppSizing.k20(context),
                  AppSizing.k10(context),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: ((context, animation, secondaryAnimation) {
                            return FadeTransition(
                              opacity: animation,
                              child: ChatScreen(),
                            );
                          }),
                        ),
                      );
                    },
                    child: Text("Get Started"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      fixedSize: Size(AppSizing.width(context), 60),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      backgroundColor: AppColors.white,
                    ),
                  ),
                  AppSizing.k20(context),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            child: SvgPicture.asset(AppAsset.home_grid),
          ),
        ],
      ),
    );
  }
}
