import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/icons.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;

  List<String> icons = [
    AppIcons.lense,
    AppIcons.chat,
    AppIcons.add,
    AppIcons.color,
    AppIcons.setting,
  ];

  Tween<double> tween = Tween<double>(begin: 1.0, end: 1.2);
  bool animationCompleted = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              clipBehavior: Clip.none,
              width: AppSizing.width(context) * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TweenAnimationBuilder(
                  key: ValueKey(activeIndex),
                  tween: tween,
                  duration: Duration(milliseconds: animationCompleted ? 2000 : 200),
                  curve: animationCompleted ? Curves.elasticOut : Curves.easeOut, // Using bounce out curve
                  onEnd: () {
                    setState(() {
                      animationCompleted = true;
                      tween = Tween(begin: 1.5, end: 1.0);
                    });
                  },
                  builder: (context, value, child) {
                    print(['value', value]);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(icons.length, (i) {
                        return Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()
                            ..scale(i == activeIndex ? value : 1.0)
                            ..translate(0.0, i == activeIndex ? 80.0 * (1 - value) : 0.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                animationCompleted = false;
                                tween = Tween(begin: 1.0, end: 1.2);
                                activeIndex = i;
                              });
                              // animate();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.highlightColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SvgPicture.asset(icons[i]),
                            ),
                          ),
                        );
                      }),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
