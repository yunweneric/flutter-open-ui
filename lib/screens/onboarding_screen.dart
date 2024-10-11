import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_openui/widgets/app_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingData {
  final String title;
  final String description;

  OnboardingData({required this.title, required this.description});
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int activeIndex = 2;
  int previousIndex = 2;

  List<OnboardingData> data = [
    OnboardingData(
      title: 'Meet Doctors Online',
      description: 'Connect with Specialized Doctors Online for Convenient and Comprehensive Medical Consultations.',
    ),
    OnboardingData(
      title: "Connect with Specialists",
      description: "Connect with Specialized Doctors Online for Convenient and Comprehensive Medical Consultations.",
    ),
    OnboardingData(
      title: 'Thousands of Online Specialists',
      description: ' Explore a Vast Array of Online Medical Specialists, Offering an Extensive Range of Expertise Tailored to Your Healthcare Needs.',
    ),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        activeIndex = 0;
        previousIndex = 0;
      });
    });
    super.initState();
  }

  moveToNext(int index) {
    if (index == 2) {
    } else {
      setState(() {
        previousIndex = index;
        activeIndex = index + 1;
      });
    }
    controller.animateToPage(
      activeIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
    );
  }

  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: AppSizing.width(context),
            height: AppSizing.height(context) * 0.6,
            // alignment: Alignment.center,
            child: Stack(
              children: [
                Image.asset(
                  width: AppSizing.width(context),
                  height: AppSizing.height(context) * 0.6,
                  'assets/images/doctor_$activeIndex.png',
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(50),
                      child: TweenAnimationBuilder(
                        key: ValueKey(activeIndex),
                        tween: Tween<double>(begin: 1, end: 0),
                        duration: const Duration(milliseconds: 1500),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Image.asset(
                              // width: AppSizing.width(context) * value,
                              // height: AppSizing.height(context) * 0.6 * value,
                              width: AppSizing.width(context),
                              height: AppSizing.height(context) * 0.6,
                              // width: 50,
                              // height: 50,
                              'assets/images/doctor_$previousIndex.png',
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppSizing.height(context) * 0.4,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppSizing.kh10Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: AppSizing.kHPercentage(context, 18),
                          child: PageView.builder(
                            scrollDirection: Axis.vertical,
                            controller: controller,
                            itemBuilder: (c, i) {
                              return Column(
                                children: [
                                  AppSizing.kh20Spacer(),
                                  Text(
                                    data[activeIndex].title,
                                    style: Theme.of(context).textTheme.displaySmall,
                                    textAlign: TextAlign.center,
                                  ),
                                  AppSizing.kh20Spacer(),
                                  Text(
                                    data[activeIndex].description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  AppSizing.kh20Spacer(),
                                ],
                              );
                            },
                          ),
                        ),
                        AppButton(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          title: activeIndex >= 2 ? 'Get Started' : "Next",
                          onPressed: () => moveToNext(activeIndex),
                          borderRadius: 30.r,
                        ),
                        AppSizing.kh20Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...[0, 1, 2].map((index) {
                              return InkWell(
                                highlightColor: Theme.of(context).scaffoldBackgroundColor,
                                onTap: () => moveToNext(index),
                                child: AnimatedContainer(
                                  width: activeIndex == index ? 30.w : 10.w,
                                  height: activeIndex == index ? 8.w : 10.w,
                                  margin: EdgeInsets.only(right: 5.w),
                                  decoration: BoxDecoration(
                                    color: activeIndex == index ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(activeIndex == index ? 8.r : 30.r),
                                  ),
                                  duration: const Duration(milliseconds: 500),
                                ),
                              );
                            })
                          ],
                        ),
                        AppSizing.kh20Spacer(),
                        const Text("Skip")
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
