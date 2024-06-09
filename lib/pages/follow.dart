import 'package:flutter/material.dart';
import 'package:flutter_open_animate/utils/colors.dart';
import 'package:flutter_open_animate/utils/helper.dart';
import 'package:flutter_open_animate/utils/sizing.dart';
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
      margin: const EdgeInsets.only(right: 15),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () => Helper.navigate(link.url),
        label: Text(link.title, style: const TextStyle(color: AppColors.black, fontSize: 12)),
        icon: SvgPicture.asset("assets/icons/${link.icon}.svg"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizing.width(context) * 0.25,
      height: 40,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        // color: AppColors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...links.map((link) {
              return linkItem(link, context);
            })
          ],
        ),
      ),
    );
  }
}
