import 'package:flutter/material.dart';
import 'package:flutter_open_animate/utils/colors.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatefulWidget {
  final double? activeIndex;
  final void Function()? onToggle;
  const NavBar({super.key, this.activeIndex, required this.onToggle});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<String> navitems = ["About", "Home", "Store"];
  @override
  Widget build(BuildContext context) {
    print(["Index", widget.activeIndex]);
    return Positioned(
      left: 50,
      top: 30,
      right: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: TweenAnimationBuilder(
          key: ValueKey(widget.activeIndex),
          duration: Duration(milliseconds: 1500),
          curve: Curves.easeInOutExpo,
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(opacity: value, child: navBar(widget.activeIndex ?? 0));
          },
          // child: navBar(widget.activeIndex),
        ),
      ),
    );
  }

  Widget navBar(double index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Logo",
          style: TextStyle(color: index == 0 ? AppColors.textBlack : AppColors.textWhite),
        ),
        Expanded(
          child: Container(
            // color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                navItem(title: 'Home'),
                navDivider(),
                navItem(title: 'About'),
                navDivider(),
                navItem(title: 'Store'),
              ],
            ),
          ),
        ),
        Row(
          children: [
            navItem(title: 'EN'),
            navDivider(width: 20),
            TweenAnimationBuilder(
              key: ValueKey(widget.activeIndex),
              tween: Tween<Offset>(begin: Offset(0, 90), end: Offset(0, 0)),
              duration: Duration(milliseconds: 1500),
              curve: Curves.easeInOutExpo,
              builder: ((context, value, child) {
                return Transform.translate(
                  offset: value,
                  child: Opacity(
                    opacity: (1 - value.dy / 50).clamp(0, 1),
                    child: InkWell(
                      onTap: widget.onToggle,
                      child: widget.activeIndex == 0.0
                          ? SvgPicture.asset(
                              "assets/icons/moon.svg",
                              height: 25,
                              width: 25,
                            )
                          : SvgPicture.asset(
                              "assets/icons/sun.svg",
                              height: 25,
                              width: 25,
                            ),
                    ),
                  ),
                );
              }),
            ),
          ],
        )
      ],
    );
  }

  Widget navDivider({double? width}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      width: width ?? 40,
      height: 2,
      color: widget.activeIndex == 0 ? AppColors.textBlack : AppColors.textWhite,
    );
  }

  Widget navItem({required String title}) {
    return InkWell(
      onTap: () {},
      child: Text(
        title,
        style: TextStyle(color: widget.activeIndex == 0 ? AppColors.textBlack : AppColors.textWhite),
      ),
    );
  }
}
