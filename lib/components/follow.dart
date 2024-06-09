import 'package:flutter/material.dart';
import 'package:flutter_car_rental/utils/colors.dart';
import 'package:flutter_car_rental/utils/helper.dart';
import 'package:flutter_svg/svg.dart';

class Link {
  final int index;
  final String url;
  final String icon;
  final String title;

  Link(this.index, this.icon, this.url, this.title);
}

class Follow extends StatelessWidget {
  final int activeIndex;
  Follow({super.key, required this.activeIndex});

  List<Link> links = [
    Link(0, "github", "https://github.com/yunweneric/", "Github"),
    Link(1, "x", "https://twitter.com/yunweneric", "X"),
    Link(2, "linkedIn", "https://www.linkedin.com/in/yunweneric", "LinkedIn"),
  ];

  linkItem(Link link, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          fixedSize: const Size(120, 35),
          alignment: Alignment.centerLeft,
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: () => Helper.navigate(link.url),
        label: Text(link.title, style: const TextStyle(color: AppColors.black)),
        icon: SvgPicture.asset("assets/icons/${link.icon}.svg"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...links.map((link) {
            return linkItem(link, context);
          })
        ],
      ),
    );
  }
}
