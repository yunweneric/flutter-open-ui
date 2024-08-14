import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/data.dart';
import 'package:flutter_openui/screens/widget/footer.dart';
import 'package:flutter_openui/screens/widget/temperature_widget.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class DetailScreen extends StatefulWidget {
  final Condition condition;
  const DetailScreen({super.key, required this.condition});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final duration = const Duration(milliseconds: 300);
  bool hasPopped = true;

  @override
  void initState() {
    setState(() {
      hasPopped = !hasPopped;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TweenAnimationBuilder(
        key: ValueKey(hasPopped),
        duration: duration,
        tween: hasPopped ? Tween<double>(begin: 1.0, end: 0.0) : Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Stack(
            children: [
              Image.asset(
                widget.condition.temperature > 25 ? 'assets/images/sunny.jpg' : "assets/images/rainy.jpg",
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
                top: value * AppSizing.height(context) * 0.25,
                left: 20,
                right: 20,
                duration: duration,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      hasPopped = !hasPopped;
                    });
                    Navigator.pop(context, true);
                  },
                  child: Opacity(
                    opacity: value,
                    child: Column(
                      children: [
                        Text(
                          "New York city",
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                color: AppColors.textWhite,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        AppSizing.k10(context),
                        Text(
                          widget.condition.temperature == 25
                              ? "Normal"
                              : widget.condition.temperature < 25
                                  ? "Too Cold"
                                  : "To Sunny",
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                color: AppColors.textWhite,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: AppSizing.height(context) * 0.35,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      hasPopped = !hasPopped;
                    });
                    Navigator.pop(context, true);
                  },
                  child: Hero(
                    tag: widget.condition.day,
                    flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
                      final customAnimation = Tween<double>(begin: 0, end: 1).animate(animation);
                      return AnimatedBuilder(
                          animation: customAnimation,
                          builder: (context, child) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: customAnimation.value * 80, vertical: customAnimation.value * 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.condition.day,
                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColors.textWhite),
                                  ),
                                  AppSizing.kwSpacer(context, 0.1),
                                  temperatureWidget(widget.condition, context),
                                ],
                              ),
                            );
                          });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.condition.day,
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColors.textWhite),
                          ),
                          AppSizing.kwSpacer(context, 0.1),
                          temperatureWidget(widget.condition, context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: AppSizing.height(context) * 0.7,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: AppSizing.width(context) * 0.3,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.textWhite.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/search.svg", color: AppColors.textWhite),
                          AppSizing.kwSpacer(context, 0.02),
                          const Text(
                            "Search",
                            style: TextStyle(color: AppColors.textWhite, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Transform.translate(offset: Offset(0, (1 - value) * 80), child: Footer()),
              )
            ],
          );
        },
      ),
    );
  }
}
