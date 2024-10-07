// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_openui/data/models/basuu_category.dart';
import 'package:flutter_openui/presentation/screens/basuu_pre_start_screen.dart';
import 'package:flutter_openui/presentation/widgets/basuu_animated_screen.dart';
import 'package:flutter_openui/presentation/widgets/basuu_animated_child.dart';
import 'package:flutter_openui/presentation/widgets/basuu_app_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_openui/routes/router.dart';
import 'package:flutter_openui/shared/utils/basuu_colors.dart';
import 'package:flutter_openui/shared/utils/sizing.dart';

class BasuuChooseCategoryScreen extends StatefulWidget {
  const BasuuChooseCategoryScreen({super.key});

  @override
  State<BasuuChooseCategoryScreen> createState() => _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends State<BasuuChooseCategoryScreen> {
  List<BasuuCategory> categories = [
    BasuuCategory(label: "A1", title: "1 - 100", color: BasuuColors.TEAL, percentage: 80, isChecked: true),
    BasuuCategory(label: "A2", title: '101 - 1K', color: BasuuColors.DGREEN, percentage: 44),
    BasuuCategory(label: "B1", title: "1K - 2K", color: BasuuColors.DARKORANGE, percentage: 27),
    BasuuCategory(label: "B2", title: "2K - 3K", color: BasuuColors.DARKRED, percentage: 9),
    BasuuCategory(label: "C1", title: "3K - 4K", color: BasuuColors.MIDRED),
    BasuuCategory(label: "C2", title: '4K - 5K', color: BasuuColors.DEEPRED),
  ];
  void updateCheckedItem(BasuuCategory category) {
    final index = categories.indexOf(category);
    final newCategories = categories;
    newCategories[index] = category.copyWith(
      isChecked: category.isChecked == true ? false : true,
    );
    setState(() => categories = newCategories);
  }

  bool? animatedStatus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BasuuAnimatedScreen(
      // animated: animatedStatus,
      builder: (context, animated, animation) {
        return Scaffold(
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(
              bottom: kBottomNavigationBarHeight / 2,
              left: 20.w,
              right: 20.w,
            ),
            child: BasuuButton(
              onPressed: categories.where((item) => item.isChecked == true).isEmpty
                  ? null
                  : () {
                      setState(() => animatedStatus = false);
                      AppRouter.navigate(
                        context,
                        BasuuPreStartScreen(categories: categories.where((item) => item.isChecked == true).toList()),
                      );
                    },
              text: "Continue",
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: AppSizing.kMainPadding(context),
                child: Column(
                  children: [
                    AppSizing.khSpacer(kToolbarHeight),
                    BasuuAnimatedChild(
                      animation: animation,
                      offset: -1,
                      child: Text(
                        "Select categories for learning language",
                        style: theme.textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    AppSizing.kh20Spacer(),
                    AppSizing.kh20Spacer(),
                    BasuuAnimatedChild(
                      animation: animation,
                      offset: 1,
                      child: Column(
                        children: [
                          ...categories.map((category) {
                            return TweenAnimationBuilder(
                                tween: ColorTween(
                                  begin: category.isChecked == true ? theme.primaryColor : theme.cardColor,
                                  end: category.isChecked == true ? theme.primaryColor : theme.cardColor,
                                ),
                                duration: const Duration(milliseconds: 700),
                                builder: (context, color, child) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    child: ListTile(
                                      tileColor: theme.cardColor,
                                      onTap: () => updateCheckedItem(category),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12.r),
                                        side: BorderSide(color: color!),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                                      leading: Chip(
                                        backgroundColor: category.color,
                                        label: Text(
                                          category.label,
                                          style: theme.textTheme.displayMedium,
                                        ),
                                      ),
                                      title: Text(
                                        "${category.title} words",
                                        style: theme.textTheme.displayMedium,
                                      ),
                                      trailing: SizedBox(
                                        width: AppSizing.kHPercentage(context, 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: AppSizing.kHPercentage(context, 4),
                                              child: Text(
                                                category.percentage == null ? '' : "${category.percentage}%",
                                                style: theme.textTheme.displayMedium!.copyWith(color: theme.highlightColor),
                                              ),
                                            ),
                                            Checkbox(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                                              side: BorderSide(
                                                color: theme.highlightColor,
                                                width: 2.w,
                                              ),
                                              value: category.isChecked ?? false,
                                              onChanged: (val) => updateCheckedItem(category),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }),
                        ],
                      ),
                    ),
                    AppSizing.kh10Spacer(),
                    const Text(
                      "5,000 words cover 97% of the English language",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
