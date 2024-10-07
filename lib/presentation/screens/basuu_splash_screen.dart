import 'package:flutter/material.dart';
import 'package:flutter_openui/presentation/screens/basuu_choose_language_screen.dart';
import 'package:flutter_openui/presentation/widgets/basuu_animated_child.dart';
import 'package:flutter_openui/presentation/widgets/basuu_app_button.dart';
import 'package:flutter_openui/presentation/widgets/basuu_app_icon.dart';
import 'package:flutter_openui/routes/router.dart';
import 'package:flutter_openui/shared/basuu_icons.dart';
import 'package:flutter_openui/shared/utils/sizing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasuuSplashScreen extends StatefulWidget {
  const BasuuSplashScreen({super.key});

  @override
  State<BasuuSplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<BasuuSplashScreen> {
  bool animated = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((d) {
      setState(() => animated = true);
    });
    super.initState();
  }

  final url = "https://raw.githubusercontent.com/yunweneric/flutter-open-ui/b53201c1802865cb708d65a5ff2f286eb6ca317a";
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: TweenAnimationBuilder(
          tween: animated ? Tween<double>(begin: 1, end: 0) : Tween<double>(begin: 0, end: 1),
          curve: Curves.fastOutSlowIn,
          key: ValueKey(animated),
          duration: const Duration(milliseconds: 700),
          builder: (context, animation, _) {
            return SafeArea(
              child: Padding(
                padding: AppSizing.kMainPadding(context),
                child: Column(
                  children: [
                    BasuuAnimatedChild(
                      animation: animation,
                      offset: -1,
                      child: Image.network(
                        "$url/assets/images/splash_logo.png",
                        height: AppSizing.kHPercentage(context, 40),
                      ),
                    ),
                    AppSizing.khSpacer(AppSizing.kHPercentage(context, 10)),
                    BasuuAnimatedChild(
                      animation: animation,
                      offset: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Learn a language easily with cards",
                            style: theme.textTheme.displayLarge!.copyWith(fontSize: 42.sp),
                            textAlign: TextAlign.center,
                          ),
                          AppSizing.kh20Spacer(),
                          Text(
                            "Learn words using cards, choosing levels that are convenient for you",
                            style: theme.textTheme.labelMedium?.copyWith(fontSize: 18.sp),
                            textAlign: TextAlign.center,
                          ),
                          AppSizing.khSpacer(AppSizing.kHPercentage(context, 8)),
                          BasuuButton(
                            onPressed: () async {
                              setState(() => animated = false);
                              final hasPopped = await AppRouter.navigate(context, const BasuuChooseLanguageScreen());
                              setState(() => animated = hasPopped);
                            },
                            width: AppSizing.width(context),
                            icon: const BasuuIcon(
                              icon: BasuuIcons.flash,
                              size: 20,
                            ),
                            text: "Get started",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
