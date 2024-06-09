import 'package:flutter/material.dart';
import 'package:flutter_open_animate/utils/colors.dart';

class NavBar extends StatefulWidget {
  final double? activeIndex;
  const NavBar({super.key, this.activeIndex});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<String> navitems = ["About", "Home", "Store"];
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: 30,
      right: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 1000),
          child: widget.activeIndex == 0 ? darkNavBar() : navBar(),
        ),
      ),
    );
  }

  Row navBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Logo",
          style: TextStyle(color: AppColors.textBlack),
        ),
        Row(
          children: [
            ...navitems.map((item) {
              return Row(
                children: [
                  InkWell(
                    child: Text(
                      item,
                      style: TextStyle(color: AppColors.textBlack),
                    ),
                  ),
                  if (navitems.last != item)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      width: 40,
                      height: 2,
                      color: AppColors.textBlack,
                    )
                ],
              );
            })
          ],
        ),
        Row(
          children: [
            ...navitems.map((item) {
              return InkWell(
                child: Text(item),
              );
            })
          ],
        )
      ],
    );
  }

  Row darkNavBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Logo", style: TextStyle(color: AppColors.textWhite)),
        Row(
          children: [
            ...navitems.map((item) {
              return Row(
                children: [
                  InkWell(
                    child: Text(
                      item,
                      style: TextStyle(color: AppColors.textWhite),
                    ),
                  ),
                  Container(margin: EdgeInsets.symmetric(horizontal: 30), width: 40, height: 2, color: AppColors.textWhite)
                ],
              );
            })
          ],
        ),
        Row(
          children: [
            ...navitems.map((item) {
              return InkWell(
                child: Text(item),
              );
            })
          ],
        )
      ],
    );
  }
}
