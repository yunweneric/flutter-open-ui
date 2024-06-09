import 'package:flutter/material.dart';
import 'package:flutter_car_rental/utils/colors.dart';
import 'package:flutter_car_rental/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  List<String> navItems = ["HOME", "ELECTRIC CARS", "SPORTS CARS", "SUV"];
  List<String> navIcons = ["bag", "user", "heart"];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: Sizing.width(context) / 8,
          child: Transform.scale(scale: 2, child: SvgPicture.asset("assets/icons/logo.svg")),
        ),
        SizedBox(
          width: Sizing.width(context) / 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...navItems.map((item) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(item, style: const TextStyle(color: AppColors.black, fontSize: 16)),
                  ),
                );
              })
            ],
          ),
        ),
        SizedBox(
          width: Sizing.width(context) / 8,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
            child: Row(
              children: [
                Image.asset("assets/images/profile.png", width: 40, height: 40),
                const SizedBox(width: 5),
                const Text("MY ACCOUNT", style: TextStyle(color: AppColors.black)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
