import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_openui/widgets/app_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingData {
  final String title;
  final String description;
  final String image;

  OnboardingData({
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int activeIndex = 0;
  int previousIndex = 5;
  PageController controller = PageController(initialPage: 1);
  final curve = Curves.fastOutSlowIn;
  final duration = const Duration(milliseconds: 700);

  List<OnboardingData> data = [
    OnboardingData(
      title: 'Meet Doctors Online',
      description: 'Connect with Specialized Doctors Online for Convenient and Comprehensive Medical Consultations.',
      image: 'assets/images/doctor_0.png',
    ),
    OnboardingData(
      title: "Connect with Specialists",
      description: "Connect with Specialized Doctors Online for Convenient and Comprehensive Medical Consultations.",
      image: 'assets/images/doctor_1.png',
    ),
    OnboardingData(
      title: 'Thousands of Online Specialists',
      description: ' Explore a Vast Array of Online Medical Specialists, Offering an Extensive Range of Expertise Tailored to Your Healthcare Needs.',
      image: 'assets/images/doctor_2.png',
    ),
    OnboardingData(
      title: 'Meet Doctors Online',
      description: 'Connect with Specialized Doctors Online for Convenient and Comprehensive Medical Consultations.',
      image: 'assets/images/doctor_0.png',
    ),
    OnboardingData(
      title: "Connect with Specialists",
      description: "Connect with Specialized Doctors Online for Convenient and Comprehensive Medical Consultations.",
      image: 'assets/images/doctor_1.png',
    ),
    OnboardingData(
      title: 'Thousands of Online Specialists',
      description: ' Explore a Vast Array of Online Medical Specialists, Offering an Extensive Range of Expertise Tailored to Your Healthcare Needs.',
      image: 'assets/images/doctor_2.png',
    ),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // *When the post from is called, trigger the initial animation.
      //* Variables are initially declared with edge values
      reset();
    });
    super.initState();
  }

  moveToNext(int index) {
    //* If the index is the last item then move to the next screen
    if (index == data.length - 1) {
      //* Here, you will implement the routing to the next screen
    } else {
      setState(() {
        previousIndex = index;
        activeIndex = index + 1;
      });
    }
    controller.animateToPage(activeIndex, duration: duration, curve: curve);
  }

  reset() {
    setState(() {
      previousIndex = data.length - 1;
      activeIndex = 0;
    });
    controller.animateToPage(activeIndex, duration: duration, curve: curve);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: AppSizing.width(context),
            height: AppSizing.height(context) * 0.6,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TweenAnimationBuilder(
                      key: ValueKey(activeIndex),
                      curve: curve,
                      tween: Tween<double>(begin: 1.0, end: 0.0),
                      duration: duration,
                      builder: (context, value, child) {
                        return Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.01)
                            ..rotateX(value * -0.06),
                          child: Opacity(
                            opacity: 1,
                            child: GestureDetector(
                              onPanUpdate: (coord) {},
                              onVerticalDragUpdate: (_) {},
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r * value),
                                  topRight: Radius.circular(20.r * value),
                                ),
                                child: Image.asset(
                                  width: AppSizing.width(context),
                                  height: AppSizing.height(context) * 0.6,
                                  data[activeIndex].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                TweenAnimationBuilder(
                  key: ValueKey(activeIndex),
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  curve: curve,
                  duration: duration,
                  builder: (context, value, child) {
                    return Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.01)
                        ..rotateX(value * 0.01),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                        child: Opacity(
                          opacity: 1 - value,
                          child: Image.asset(
                            width: AppSizing.width(context),
                            height: AppSizing.height(context) * 0.6,
                            data[previousIndex].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
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
                            itemCount: data.length,
                            scrollDirection: Axis.vertical,
                            controller: controller,
                            itemBuilder: (c, i) {
                              return AnimatedOpacity(
                                opacity: activeIndex == i ? 1 : 0,
                                duration: Duration(seconds: 5),
                                curve: curve,
                                child: Column(
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
                                ),
                              );
                            },
                          ),
                        ),
                        AppButton(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          title: activeIndex >= data.length - 1 ? 'Get Started' : "Next",
                          onPressed: () => moveToNext(activeIndex),
                          borderRadius: 30.r,
                        ),
                        AppSizing.kh20Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(data.length, (i) => i).map((index) {
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
                        InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: reset,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
                            child: const Text("Reset"),
                          ),
                        )
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
