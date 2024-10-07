import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BasuuIcon extends StatelessWidget {
  final String icon;
  final double? size;
  final Color? color;
  const BasuuIcon({super.key, required this.icon, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      color: color,
      width: size?.w ?? 30.w,
      height: size?.w ?? 30.w,
    );
  }
}
