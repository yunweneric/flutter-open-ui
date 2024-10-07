import 'package:flutter/material.dart';
import 'package:flutter_openui/data/models/category.dart';
import 'package:flutter_openui/data/models/word.dart';
import 'package:flutter_openui/presentation/widgets/basuu_app_bar.dart';
import 'package:flutter_openui/presentation/widgets/basuu_app_button.dart';
import 'package:flutter_openui/presentation/widgets/basuu_app_icon.dart';
import 'package:flutter_openui/shared/basuu_icons.dart';
import 'package:flutter_openui/shared/utils/basuu_colors.dart';
import 'package:flutter_openui/shared/utils/sizing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasuuHomeScreen extends StatefulWidget {
  final BasuuCategory level;

  const BasuuHomeScreen({super.key, required this.level});

  @override
  State<BasuuHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<BasuuHomeScreen> {
  List<BasuuWord> words = [
    BasuuWord(title: "mother", hasLearned: true),
    BasuuWord(title: "day", hasLearned: false),
    BasuuWord(title: "put", hasLearned: false),
    BasuuWord(title: "trailblazing", hasLearned: true),
    BasuuWord(title: "start", hasLearned: false),
    BasuuWord(title: "race", hasLearned: false),
    BasuuWord(title: "race", hasLearned: false),
  ];
  void updateCheckedItem(BasuuWord word, bool status) {
    final index = words.indexOf(word);
    final newCategories = words;
    newCategories[index] = word.copyWith(hasLearned: status);
    setState(() => words = newCategories);
  }

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
        title: "${widget.level.label} Level",
        theme: theme,
        rightIcon: BasuuIcons.close,
        onNext: () => Navigator.pop(context),
      ),
      body: SizedBox(
        width: AppSizing.width(context),
        child: SingleChildScrollView(
          child: Padding(
            padding: AppSizing.kMainPadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppSizing.kh20Spacer(),
                BasuuButton(
                  bgColor: theme.scaffoldBackgroundColor,
                  width: AppSizing.width(context),
                  onPressed: () {
                    setState(() {
                      words = words.map((item) => item.copyWith(hasLearned: false)).toList();
                    });
                  },
                  style: TextStyle(color: BasuuColors.RED, fontSize: 18.sp),
                  text: 'Reset all progress',
                  side: BorderSide(color: theme.highlightColor),
                  icon: const BasuuIcon(icon: BasuuIcons.reset),
                ),
                AppSizing.kh20Spacer(),
                const Text(
                  "20 new words left  ·  80% complete",
                  textAlign: TextAlign.center,
                ),
                AppSizing.kh20Spacer(),
                ...words.map((item) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        side: BorderSide(
                          color: theme.highlightColor,
                        ),
                      ),
                      leading: Text(
                        item.title,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: item.hasLearned ? theme.primaryColorDark : theme.highlightColor,
                        ),
                      ),
                      trailing: SizedBox(
                        width: AppSizing.kHPercentage(context, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: List.generate(3, (index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 5.w),
                                  child: CircleAvatar(
                                    radius: 4.r,
                                    backgroundColor: item.hasLearned ? BasuuColors.GREEN : theme.highlightColor,
                                  ),
                                );
                              }),
                            ),
                            AppSizing.kwSpacer(5.w),
                            TweenAnimationBuilder(
                              tween: ColorTween(
                                begin: item.hasLearned ? BasuuColors.GREEN : theme.cardColor,
                                end: item.hasLearned ? BasuuColors.GREEN : theme.cardColor,
                              ),
                              duration: const Duration(milliseconds: 700),
                              builder: (context, color, child) {
                                return InkWell(
                                  splashColor: color,
                                  borderRadius: BorderRadius.circular(10.r),
                                  onTap: () => updateCheckedItem(item, true),
                                  child: Chip(
                                    backgroundColor: color,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.h,
                                      horizontal: 4.w,
                                    ),
                                    label: BasuuIcon(
                                      icon: BasuuIcons.check,
                                      size: 20,
                                      color: item.hasLearned ? theme.primaryColorDark : null,
                                    ),
                                  ),
                                );
                              },
                            ),
                            AppSizing.kwSpacer(5.w),
                            TweenAnimationBuilder(
                                tween: ColorTween(
                                  begin: item.hasLearned ? theme.cardColor : theme.primaryColorDark,
                                  end: item.hasLearned ? theme.cardColor : theme.primaryColorDark,
                                ),
                                duration: const Duration(milliseconds: 700),
                                builder: (context, color, child) {
                                  return InkWell(
                                    splashColor: color,
                                    borderRadius: BorderRadius.circular(10.r),
                                    onTap: () => updateCheckedItem(item, false),
                                    child: Chip(
                                      backgroundColor: color,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 15.h,
                                        horizontal: 12.w,
                                      ),
                                      label: Text(
                                        "Learn",
                                        style: TextStyle(
                                          color: item.hasLearned ? theme.primaryColorDark : theme.cardColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
