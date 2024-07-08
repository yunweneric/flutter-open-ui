import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_3d_nike_shop/pages/data.dart';
import 'package:flutter_3d_nike_shop/pages/follow.dart';
import 'package:flutter_3d_nike_shop/utils/asset_helper.dart';
import 'package:flutter_3d_nike_shop/utils/colors.dart';
import 'package:flutter_3d_nike_shop/utils/sizing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  PageController controller = PageController();
  PageController controller_2 = PageController();
  int activeIndex = 0;

  List<String> navItems = ["Men", "Women", "Kids", "Collections"];

  final duration = const Duration(milliseconds: 1200);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: duration,
        clipBehavior: Clip.none,
        width: Sizing.width(context),
        height: Sizing.height(context),
        decoration: BoxDecoration(
          color: items[activeIndex].main,
          image: const DecorationImage(image: AssetImage(AssetHelper.lines), fit: BoxFit.cover),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedContainer(
              duration: duration,
              clipBehavior: Clip.none,
              margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 100),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              width: Sizing.width(context),
              height: Sizing.height(context),
              decoration: BoxDecoration(
                color: items[activeIndex].light,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.white.withOpacity(0.3), width: 3),
              ),
              child: Column(
                children: [navBar(), SizedBox(height: 50), buttonAndPrice(context)],
              ),
            ),
            shoeSlider(context),
          ],
        ),
      ),
    );
  }

  Container buttonAndPrice(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...items.map((e) {
                  return indicator(e.index == activeIndex, e.index);
                }),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textSlider(context),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: AnimatedContainer(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      duration: duration,
                      decoration: BoxDecoration(
                        color: items[activeIndex].main,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: const Text(
                          "Add to bag",
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: TweenAnimationBuilder(
                        duration: duration,
                        key: ValueKey(activeIndex),
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Stack(
                            children: [
                              if (activeIndex > 0 && activeIndex < items.length - 1)
                                Opacity(
                                  opacity: 1 - value,
                                  child: Transform.translate(
                                    offset: Offset(50 * value, 0.0),
                                    child: Text(
                                      items[activeIndex - 1].price,
                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.white, fontSize: 28),
                                    ),
                                  ),
                                ),
                              Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(-50 * (1 - value), 0.0),
                                  child: Text(
                                    items[activeIndex].price,
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.white, fontSize: 28),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
              Follow(activeIndex: activeIndex)
            ],
          ),
        ],
      ),
    );
  }

  Row navBar() {
    return Row(
      children: [
        Image.asset(AssetHelper.nike_white),
        const SizedBox(width: 60),
        ...navItems.map(
          (e) => InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 90),
              child: Text(e, style: const TextStyle(fontSize: 16, color: AppColors.white)),
            ),
          ),
        ),
      ],
    );
  }

  SizedBox textSlider(BuildContext context) {
    return SizedBox(
      width: Sizing.width(context) * 0.3,
      height: 300,
      child: PageView.builder(
        controller: controller_2,
        itemCount: items.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (c, i) {
          return AnimatedScale(
            alignment: Alignment.centerLeft,
            duration: duration,
            scale: activeIndex == i ? 1 : 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  items[i].title,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 20),
                Text(
                  items[i].desc,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white, fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Transform shoeSlider(BuildContext context) {
    return Transform.translate(
      offset: Offset(Sizing.width(context) / 2.3, 0),
      child: Container(
        clipBehavior: Clip.none,
        height: Sizing.height(context),
        alignment: Alignment.centerRight,
        width: Sizing.width(context) / 2,
        child: PageView.builder(
          clipBehavior: Clip.none,
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          itemCount: items.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (c, i) {
            return AnimatedOpacity(
              duration: duration,
              opacity: i == activeIndex ? 1 : 0,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..scale(1.2),
                child: Image.asset("assets/images/shoe_${i}.png"),
              ),
            );
          },
        ),
      ),
    );
  }

  void animateChange(int index) async {
    setState(() {
      activeIndex = index;
    });
    await controller.animateToPage(index, duration: Duration(milliseconds: 1500), curve: Curves.easeInOutBack);
    controller_2.animateToPage(index, duration: Duration(milliseconds: 800), curve: Curves.ease);
  }

  Widget indicator(bool isActive, int index) {
    return InkWell(
      onTap: () => animateChange(index),
      child: Row(
        children: [
          AnimatedContainer(
            duration: duration,
            height: activeIndex == index ? 120 : 80,
            width: 6,
            margin: const EdgeInsets.only(right: 25),
            decoration: BoxDecoration(
              color: isActive ? AppColors.white : AppColors.white.withOpacity(0.5),
              borderRadius: index == 0
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )
                  : index == items.length - 1
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )
                      : null,
            ),
          ),
          Text(
            "0${index + 1}",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: isActive ? AppColors.white : AppColors.white.withOpacity(0.5),
                ),
          ),
        ],
      ),
    );
  }
}
