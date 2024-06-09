import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_car_rental/components/arrows.dart';
import 'package:flutter_car_rental/components/car_component.dart';
import 'package:flutter_car_rental/components/car_name.dart';
import 'package:flutter_car_rental/components/follow.dart';
import 'package:flutter_car_rental/components/navbar.dart';
import 'package:flutter_car_rental/utils/colors.dart';
import 'package:flutter_car_rental/utils/sizing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int activeIndex = 0;
  final duration = const Duration(milliseconds: 2500);
  PageController? scrollController = PageController(initialPage: 0);
  PageController? textScrollController = PageController(initialPage: 0);
  bool hasReversed = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () => triggerAnimation(1));
  }

  triggerAnimation(int newIndex) {
    scrollController?.animateToPage(
      newIndex,
      duration: duration,
      curve: Curves.easeInOutBack,
    );
    textScrollController?.animateToPage(
      newIndex,
      duration: duration,
      curve: Curves.easeInOutBack,
    );
    setState(() {
      activeIndex = newIndex;
    });
  }

  List<int> cars = [0, 1, 2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          animatedName(context),
          animatedCar(context),
          Arrows(index: activeIndex, onTap: triggerAnimation),
          bottomButtons(context),
          Positioned(bottom: 10, left: 10, child: Follow(activeIndex: activeIndex)),
          Positioned(
            top: 40,
            left: Sizing.width(context) / 20,
            right: Sizing.width(context) / 20,
            child: NavBar(),
          )
        ],
      ),
    );
  }

  Positioned bottomButtons(BuildContext context) {
    return Positioned(
      bottom: Sizing.height(context) / 15,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  backgroundColor: AppColors.darkBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text("Rent Now", style: TextStyle(color: AppColors.white)),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bg,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  elevation: 0,
                  side: const BorderSide(color: AppColors.darkBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text("Details"),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...cars.map(
                (car) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => triggerAnimation(car),
                    child: AnimatedContainer(
                      duration: duration,
                      height: 15,
                      width: 15,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: car == activeIndex ? AppColors.gray : AppColors.white,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container animatedCar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Sizing.height(context) / 4),
      child: PageView.builder(
        controller: scrollController,
        onPageChanged: (page) => activeIndex = page,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cars.length,
        itemBuilder: (context, i) {
          return CarComponent(index: i);
        },
      ),
    );
  }

  Positioned animatedName(BuildContext context) {
    return Positioned(
      bottom: Sizing.width(context) / 30,
      left: 20,
      right: 20,
      child: SizedBox(
        height: Sizing.height(context),
        child: PageView.builder(
          controller: textScrollController,
          scrollDirection: Axis.vertical,
          itemCount: cars.length,
          itemBuilder: (context, i) => CarName(index: i),
        ),
      ),
    );
  }
}
