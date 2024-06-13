import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: AppSizing.width(context),
        height: AppSizing.height(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          border: Border.all(color: Theme.of(context).primaryColor, width: 5),
        ),
        child: Stack(
          children: [
            SvgPicture.asset(AppAsset.listening_grid),
            SafeArea(
              child: Container(
                width: AppSizing.width(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Chip(label: Text("All Buddy")),
                        AppSizing.k20(context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(radius: 5),
                            Text("  Online"),
                          ],
                        )
                      ],
                    ),
                    LottieBuilder.asset(
                      AppAsset.siri,
                      width: AppSizing.width(context) / 2,
                      height: AppSizing.width(context) / 2,
                    ),
                    Container(
                      height: AppSizing.height(context) / 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Listening ...", style: Theme.of(context).textTheme.displayMedium),
                          AppSizing.k10(context),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(context).cardColor,
                                child: SvgPicture.asset(AppAsset.keyboard, color: Theme.of(context).primaryColorLight),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset(AppAsset.mic_circle, color: Theme.of(context).primaryColor),
                                  SvgPicture.asset(AppAsset.microphone, color: Theme.of(context).primaryColorDark),
                                ],
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(context).cardColor,
                                child: SvgPicture.asset(AppAsset.close, color: Theme.of(context).primaryColorLight),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
