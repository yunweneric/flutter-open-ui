import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fruits_animation/utils/colors.dart';
import 'package:flutter_fruits_animation/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final navBarItems = ["Home", "Shop", "Contact"];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: Sizing.width(context) / 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: Sizing.width(context) / 4,
            child: InkWell(
              onTap: () {},
              child: Text(
                "Fruits",
                style: GoogleFonts.lobster(textStyle: TextStyle(fontSize: 30, color: AppColors.white)),
              ),
            ),
          ),
          SizedBox(
            width: Sizing.width(context) / 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: navBarItems.map(
                (item) {
                  return Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        item,
                        style: const TextStyle(color: AppColors.white, fontSize: 16),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          SizedBox(
            width: Sizing.width(context) / 4,
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {},
                label: Text("Choose Your Favorite Beer", style: TextStyle(color: AppColors.white, fontSize: 20)),
                icon: SvgPicture.asset("assets/icons/cup.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
