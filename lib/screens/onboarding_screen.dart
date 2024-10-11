import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_openui/widgets/app_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            width: AppSizing.width(context),
            height: AppSizing.height(context) * 0.6,
            'assets/images/doctor_0.png',
            fit: BoxFit.cover,
          ),
          AppSizing.kh10Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "Thousands of Online Specialists",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                AppSizing.kh20Spacer(),
                const Text(
                  "Explore a Vast Array of Online Medical Specialists, Offering an Extensive Range of Expertise Tailored to Your Healthcare Needs.",
                  textAlign: TextAlign.center,
                ),
                AppSizing.kh10Spacer(),
                AppButton(
                  title: "Next",
                  onPressed: () {},
                ),
                AppSizing.kh20Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
