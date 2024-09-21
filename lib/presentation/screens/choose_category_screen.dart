// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_openui/data/models/category.dart';
import 'package:flutter_openui/presentation/screens/pre_start_screen.dart';
import 'package:flutter_openui/presentation/widgets/animated_screen.dart';
import 'package:flutter_openui/presentation/widgets/animated_child.dart';
import 'package:flutter_openui/presentation/widgets/app_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_openui/routes/router.dart';
import 'package:flutter_openui/shared/utils/colors.dart';
import 'package:flutter_openui/shared/utils/sizing.dart';

class ChooseCategoryScreen extends StatefulWidget {
  const ChooseCategoryScreen({super.key});

  @override
  State<ChooseCategoryScreen> createState() => _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends State<ChooseCategoryScreen> {
  List<Category> categories = [
    Category(label: "A1", title: "1 - 100", color: AppColors.TEAL, percentage: 80, isChecked: true),
    Category(label: "A2", title: '101 - 1K', color: AppColors.DGREEN, percentage: 44),
    Category(label: "B1", title: "1K - 2K", color: AppColors.DARKORANGE, percentage: 27),
    Category(label: "B2", title: "2K - 3K", color: AppColors.DARKRED, percentage: 9),
    Category(label: "C1", title: "3K - 4K", color: AppColors.MIDRED),
    Category(label: "C2", title: '4K - 5K', color: AppColors.DEEPRED),
  ];
  void updateCheckedItem(Category category) {
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
    return AnimatedScreen(
      // animated: animatedStatus,
      builder: (context, animated, animation) {
        return Scaffold(
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(
              bottom: kBottomNavigationBarHeight / 2,
              left: 20.w,
              right: 20.w,
            ),
            child: AppButton(
              onPressed: categories.where((item) => item.isChecked == true).isEmpty
                  ? null
                  : () {
                      setState(() => animatedStatus = false);
                      AppRouter.navigate(
                        context,
                        PreStartScreen(categories: categories.where((item) => item.isChecked == true).toList()),
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
                    AnimatedChild(
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
                    AnimatedChild(
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
