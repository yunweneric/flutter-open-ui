import 'package:flutter/material.dart';
import 'package:flutter_openui/presentation/screens/choose_category_screen.dart';
import 'package:flutter_openui/presentation/widgets/animated_child.dart';
import 'package:flutter_openui/presentation/widgets/animated_screen.dart';
import 'package:flutter_openui/presentation/widgets/app_icon.dart';
import 'package:flutter_openui/routes/router.dart';
import 'package:flutter_openui/shared/icons.dart';
import 'package:flutter_openui/shared/utils/sizing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Language {
  final String icon;
  final String name;

  Language({required this.icon, required this.name});
}

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  List<Language> languages = [
    Language(icon: AppIcons.flag_en, name: "English"),
    Language(icon: AppIcons.flag_es, name: "Spanish"),
    Language(icon: AppIcons.flag_fr, name: "French"),
    Language(icon: AppIcons.flag_ru, name: "Russian"),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: AnimatedScreen(
        builder: (context, animated, animation) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: AppSizing.kMainPadding(context),
                child: Column(
                  children: [
                    AppSizing.khSpacer(kToolbarHeight / 2),
                    AnimatedChild(
                      offset: -1,
                      animation: animation,
                      child: ListTile(
                        splashColor: theme.scaffoldBackgroundColor,
                        onTap: () => Navigator.pop(context, true),
                        titleAlignment: ListTileTitleAlignment.top,
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: const AppIcon(icon: AppIcons.arrow_back, size: 20),
                        ),
                        title: Text(
                          "What language are you want to study?",
                          style: theme.textTheme.displayLarge,
                        ),
                      ),
                    ),
                    AppSizing.kh20Spacer(),
                    AnimatedChild(
                      offset: 1,
                      animation: animation,
                      child: Column(
                        children: [
                          ...languages.map((language) {
                            return Material(
                              color: Colors.transparent,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  onTap: () => AppRouter.navigate(context, const ChooseCategoryScreen()),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: theme.highlightColor),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                                  leading: AppIcon(icon: language.icon),
                                  title: Text(language.name),
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
