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
  final double activeIndex;
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
          backgroundColor: activeIndex == 0 ? AppColors.bgBlack : AppColors.bgWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () => Helper.navigate(link.url),
        label: Text(link.title, style: TextStyle(color: activeIndex == 0 ? AppColors.bgWhite : AppColors.bgBlack, fontSize: 12)),
        icon: SvgPicture.asset(
          "assets/icons/${link.icon}.svg",
          color: activeIndex == 0 ? AppColors.bgWhite : AppColors.bgBlack,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: ValueKey(activeIndex),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOutExpo,
      tween: Tween<Offset>(begin: Offset(0, 500), end: Offset.zero),
      builder: (context, value, child) {
        return Transform.translate(
          offset: value,
          child: Container(
            width: Sizing.width(context) * 0.25,
            height: 40,
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
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
          ),
        );
      },
    );
  }
}
