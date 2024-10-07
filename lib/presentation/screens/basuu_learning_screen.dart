import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_openui/data/models/category.dart';
import 'package:flutter_openui/data/models/word.dart';
import 'package:flutter_openui/presentation/widgets/basuu_app_bar.dart';
import 'package:flutter_openui/presentation/widgets/basuu_app_button.dart';
import 'package:flutter_openui/presentation/widgets/basuu_app_icon.dart';
import 'package:flutter_openui/shared/basuu_icons.dart';
import 'package:flutter_openui/shared/utils/basuu_colors.dart';
import 'package:flutter_openui/shared/utils/sizing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasuuLearningScreen extends StatefulWidget {
  final BasuuCategory selectedCategory;
  const BasuuLearningScreen({super.key, required this.selectedCategory});

  @override
  State<BasuuLearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<BasuuLearningScreen> {
  final activeIndex = 0;
  List<BasuuWord> words = [
    BasuuWord(title: "mother", hasLearned: true),
    BasuuWord(title: "day", hasLearned: false),
    BasuuWord(title: "put", hasLearned: false),
    BasuuWord(title: "trailblazing", hasLearned: true),
    BasuuWord(title: "start", hasLearned: false),
    BasuuWord(title: "race", hasLearned: false),
    BasuuWord(title: "race", hasLearned: false),
  ];
  bool? isCorrect;
  bool isWordVisible = false;
  bool animated = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((d) {
      setState(() => animated = true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: basuuAppBar(
        onBack: () => Navigator.pop(context),
        theme: theme,
        title: "Learn new words",
      ),
      body: SingleChildScrollView(
        child: AnimatedContainer(
          curve: Curves.elasticOut,
          duration: const Duration(milliseconds: 2500),
          transformAlignment: Alignment.bottomCenter,
          transform: Matrix4.identity()
            ..rotateZ(
              isCorrect == null
                  ? 0
                  : isCorrect == true
                      ? pi * -0.02
                      : pi * 0.02,
            ),
          margin: AppSizing.kMainPadding(context) + EdgeInsets.symmetric(vertical: 20, horizontal: 10.w),
          height: AppSizing.kHPercentage(context, 80),
          width: AppSizing.width(context),
          padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 30.w),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  AppSizing.kh20Spacer(),
                  Column(
                    children: [
                      Text("${widget.selectedCategory.label} Level"),
                      AppSizing.kh20Spacer(),
                      Text(
                        words[activeIndex].title,
                        style: theme.textTheme.displayLarge,
                      ),
                    ],
                  ),
                  AppSizing.kh20Spacer(),
                  AppSizing.kh20Spacer(),
                  InkWell(
                    onTap: () => setState(() {
                      isWordVisible = !isWordVisible;
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 700),
                      width: AppSizing.width(context),
                      padding: EdgeInsets.symmetric(vertical: 80.h),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        border: Border.all(color: isWordVisible ? theme.primaryColor.withOpacity(0.3) : theme.highlightColor),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: isWordVisible
                            ? Text(
                                words[activeIndex].title,
                                style: theme.textTheme.displayLarge,
                              )
                            : const Center(
                                child: BasuuIcon(icon: BasuuIcons.eye_visible),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  actionBtn(context, theme, isLeft: true),
                  actionBtn(context, theme, isLeft: false),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget actionBtn(BuildContext context, ThemeData theme, {required bool isLeft}) {
    return Builder(builder: (context) {
      Color color = theme.cardColor;
      if (isLeft && isCorrect == true) {
        color = BasuuColors.GREEN;
      } else if (!isLeft && isCorrect == false) {
        color = BasuuColors.RED;
      } else {
        color = theme.cardColor;
      }
      return TweenAnimationBuilder(
        tween: ColorTween(begin: theme.cardColor, end: color),
        duration: const Duration(milliseconds: 700),
        builder: (context, color, child) {
          return BasuuButton(
            onPressed: () => setState(() {
              isCorrect = isLeft;
            }),
            text: isLeft ? "I Know" : "Learn",
            width: AppSizing.kWPercentage(context, 35),
            bgColor: color,
            side: BorderSide(color: theme.highlightColor),
            style: theme.textTheme.displayMedium?.copyWith(color: theme.primaryColorDark),
            padding: EdgeInsets.symmetric(vertical: 25.h),
          );
        },
      );
    });
  }
}
