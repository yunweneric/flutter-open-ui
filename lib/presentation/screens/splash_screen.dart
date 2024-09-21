import 'package:flutter/material.dart';
import 'package:flutter_openui/presentation/widgets/app_button.dart';
import 'package:flutter_openui/shared/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: AppSizing.kMainPadding(context),
        child: Column(
          children: [
            AppSizing.khSpacer(kToolbarHeight),
            Image.asset("assets/images/splash_logo.png"),
            Text(
              "Learn a language easily with cards",
              style: theme.textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            AppSizing.kh10Spacer(),
            Text(
              "Learn words using cards, choosing levels that are convenient for you",
              style: theme.textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            AppSizing.kh10Spacer(),
            AppButton(
              icon: SvgPicture.asset("assets/icons/flash.svg"),
              text: "Get started",
            ),
          ],
        ),
      ),
    );
  }
}
