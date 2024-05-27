import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openui/screens/onboarding/desktop.dart';
import 'package:flutter_openui/screens/onboarding/mobile.dart';
import 'package:flutter_openui/screens/theme/colors.dart';
import 'package:flutter_openui/screens/utils/sizing.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  Widget showWidget(BoxConstraints constraints) {
    if (Sizing.isMobile(constraints)) return const MobileOnboardingScreen();
    if (Sizing.isMobile(constraints)) return const DesktopOnboardingScreen();
    return const DesktopOnboardingScreen();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.black,
        statusBarColor: AppColors.black,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            print(constraints.maxWidth);
            return AnimatedSwitcher(
              duration: const Duration(seconds: 2),
              child: showWidget(constraints),
            );
          },
        ),
      ),
    );
  }
}
