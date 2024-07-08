import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_animate/pages/models/watch.dart';
import 'package:flutter_open_animate/utils/colors.dart';
import 'package:flutter_open_animate/utils/sizing.dart';

class AnimatedText extends StatelessWidget {
  final PageController textController;
  final List<AppWatch> watches;
  final int activeIndex;
  const AnimatedText({super.key, required this.textController, required this.watches, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: Sizing.width(context) * 0.18,
      child: Container(
        // color: Colors.teal,
        height: Sizing.height(context),
        width: Sizing.width(context) / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Sizing.height(context) * 0.3,
              child: PageView.builder(
                controller: textController,
                physics: NeverScrollableScrollPhysics(),
                itemCount: watches.length,
                itemBuilder: (context, i) {
                  return SingleChildScrollView(
                    child: AnimatedScale(
                      alignment: Alignment.centerLeft,
                      duration: Duration(milliseconds: 800),
                      scale: i == activeIndex ? 1 : 0.9,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 800),
                        opacity: i == activeIndex ? 1 : 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("FOSSIL", style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColors.textWhite)),
                            // SizedBox(height: 5),
                            Text("Super Luxury", style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColors.textWhite)),
                            const SizedBox(height: 40),
                            Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. sed diam",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 22, color: AppColors.textWhite),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textWhite,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: () {},
              child: const Text("Add to cart - \$433", style: TextStyle(color: AppColors.textBlack)),
            ),
          ],
        ),
      ),
    );
  }
}
