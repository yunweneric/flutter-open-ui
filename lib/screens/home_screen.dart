
import 'package:flutter/material.dart';
import 'package:flutter_openui/routes/router.dart';
import 'package:flutter_openui/screens/data.dart';
import 'package:flutter_openui/screens/detail_screen.dart';
import 'package:flutter_openui/screens/widget/footer.dart';
import 'package:flutter_openui/screens/widget/temperature_widget.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/sizing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeTextAnimation;
  bool isPushed = false;

  Condition? activeCondition;
  @override
  void initState() {
    activeCondition = weather.first;
    super.initState();
  }

  final duration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/cloudy.jpg",
            width: AppSizing.width(context),
            height: AppSizing.height(context),
            fit: BoxFit.cover,
          ),
          Container(
            height: AppSizing.height(context),
            width: AppSizing.width(context),
            color: Colors.black.withOpacity(0.4),
          ),
          AnimatedPositioned(
            duration: duration,
            top: 80,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Text(
                  "Weekview",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: AppColors.textWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: AppSizing.height(context) * 0.5,
                  width: AppSizing.width(context) * 0.8,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: false,
                    itemCount: weather.length,
                    itemBuilder: (context, index) {
                      final condition = weather[index];
                      return AnimatedScale(
                        // alignment: Alignment.bottomCenter,
                        duration: duration,
                        scale: activeCondition == condition
                            ? 1.0
                            : isPushed
                                ? 0.5
                                : 1.0,
                        child: Hero(
                          tag: condition.day,
                          flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
                            final customAnimation = Tween<double>(begin: 0, end: 1).animate(animation);
                            return AnimatedBuilder(
                              animation: customAnimation,
                              builder: (context, child) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: customAnimation.value * 80, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        condition.day,
                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColors.textWhite),
                                      ),
                                      temperatureWidget(condition, context),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  isPushed = true;
                                  activeCondition = condition;
                                });
                                await AppRouter.navigate(context, DetailScreen(condition: condition));
                                setState(() {
                                  isPushed = false;
                                  activeCondition = condition;
                                });
                              },
                              child: Container(
                                // padding: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      condition.day,
                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColors.textWhite),
                                    ),
                                    AppSizing.kwSpacer(context, 0.2),
                                    temperatureWidget(condition, context),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom: isPushed ? -80 : 0,
            left: 0,
            right: 0,
            child: const Footer(),
          )
        ],
      ),
    );
  }
}
