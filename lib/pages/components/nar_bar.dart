import 'package:flutter/material.dart';
import 'package:flutter_open_animate/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NavBar extends StatefulWidget {
  final int? activeIndex;
  const NavBar({super.key, this.activeIndex});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<String> navitems = ["About", "Home", "Store"];
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 50,
      top: 30,
      right: 50,
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 0), child: navBar()),
    );
  }

  Widget navBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("S’wisp", style: GoogleFonts.cabin(color: AppColors.textWhite)),
        Row(
          children: [
            navItem(title: 'Men'),
            navDivider(),
            navItem(title: 'Women'),
            navDivider(),
            navItem(title: 'EN'),
            navDivider(width: 20),
            InkWell(
              onTap: () {},
              child: SvgPicture.asset("assets/icons/bag.svg", height: 25, width: 25),
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
      color: AppColors.textWhite,
    );
  }

  Widget navItem({required String title}) {
    return InkWell(
      onTap: () {},
      child: Text(
        title,
        style: TextStyle(color: AppColors.textWhite),
      ),
    );
  }
}
