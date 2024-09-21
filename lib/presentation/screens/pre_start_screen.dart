import 'package:flutter/material.dart';
import 'package:flutter_openui/data/models/category.dart';
import 'package:flutter_openui/presentation/screens/home_screen.dart';
import 'package:flutter_openui/presentation/screens/learning_screen.dart';
import 'package:flutter_openui/presentation/widgets/animated_child.dart';
import 'package:flutter_openui/presentation/widgets/animated_screen.dart';
import 'package:flutter_openui/presentation/widgets/app_bar.dart';
import 'package:flutter_openui/presentation/widgets/app_button.dart';
import 'package:flutter_openui/presentation/widgets/app_icon.dart';
import 'package:flutter_openui/routes/router.dart';
import 'package:flutter_openui/shared/icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_openui/shared/utils/sizing.dart';

class PreStartScreen extends StatefulWidget {
  final List<Category> categories;
  const PreStartScreen({super.key, required this.categories});

  @override
  State<PreStartScreen> createState() => _PreStartScreenState();
}

class _PreStartScreenState extends State<PreStartScreen> {
  Category? selectedCategory;
  bool animated = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((d) {
      setState(() => animated = true);
    });
    selectedCategory = widget.categories.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedScreen(
      builder: (context, animated, animation) {
        return Scaffold(
          appBar: appBar(
            title: "Pre-start",
            theme: theme,
            onBack: () => Navigator.pop(context),
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(
              bottom: kBottomNavigationBarHeight / 2,
              left: 20.w,
              right: 20.w,
            ),
            child: AppButton(
              icon: const AppIcon(icon: AppIcons.book),
              onPressed: () => AppRouter.navigate(
                context,
                LearningScreen(selectedCategory: selectedCategory!),
              ),
              text: "Start Learning",
            ),
          ),
          body: SafeArea(
            child: AnimatedChild(
              offset: 2,
              animation: animation,
              child: SingleChildScrollView(
                child: Padding(
                  padding: AppSizing.kMainPadding(context),
                  child: Column(
                    children: [
                      AppSizing.kh20Spacer(),
                      ...widget.categories.map((category) {
                        return TweenAnimationBuilder(
                          tween: category == selectedCategory
                              ? ColorTween(begin: theme.cardColor, end: theme.primaryColor)
                              : ColorTween(
                                  begin: theme.primaryColor,
                                  end: theme.cardColor,
                                ),
                          duration: const Duration(milliseconds: 700),
                          builder: (context, value, child) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                tileColor: theme.cardColor,
                                onTap: () {
                                  setState(() => selectedCategory = category);
                                  AppRouter.navigate(context, HomeScreen(level: category));
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  side: BorderSide(color: value!),
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
                                      AppSizing.kwSpacer(5.w),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: theme.highlightColor,
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(3),
                                          child: AppIcon(
                                            icon: AppIcons.chevron_right,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                      AppSizing.kh10Spacer(),
                      Text(
                        "Customize your progress if you wish",
                        style: theme.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
