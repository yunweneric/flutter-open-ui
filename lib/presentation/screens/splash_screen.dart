import 'package:flutter/material.dart';
import 'package:flutter_openui/presentation/screens/choose_language_screen.dart';
import 'package:flutter_openui/presentation/widgets/animated_child.dart';
import 'package:flutter_openui/presentation/widgets/app_button.dart';
import 'package:flutter_openui/presentation/widgets/app_icon.dart';
import 'package:flutter_openui/routes/router.dart';
import 'package:flutter_openui/shared/icons.dart';
import 'package:flutter_openui/shared/utils/sizing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
                    AnimatedChild(
                      animation: animation,
                      offset: -1,
                      child: Image.asset(
                        "assets/images/splash_logo.png",
                        height: AppSizing.kHPercentage(context, 40),
                      ),
                    ),
                    AppSizing.khSpacer(AppSizing.kHPercentage(context, 10)),
                    AnimatedChild(
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
                          AppButton(
                            onPressed: () async {
                              setState(() => animated = false);
                              final hasPopped = await AppRouter.navigate(context, const ChooseLanguageScreen());
                              setState(() => animated = hasPopped);
                            },
                            width: AppSizing.width(context),
                            icon: const AppIcon(
                              icon: AppIcons.flash,
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
