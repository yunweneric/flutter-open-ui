import 'package:flutter/material.dart';
import 'package:flutter_openui/shared/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizing {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static double kHPercentage(BuildContext context, double value) => (height(context) * value) / 100;
  static double kWPercentage(BuildContext context, double value) => (width(context) * value) / 100;
  static radiusMd() => BorderRadius.circular(10.r);
  static radiusSm() => BorderRadius.circular(5.r);

  static OutlineInputBorder mainBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 0.6, color: color),
      borderRadius: BorderRadius.all(Radius.circular(45.r)),
    );
  }

  static OutlineInputBorder mainFocusBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 0.6, color: AppColors.PRIMARY),
      borderRadius: BorderRadius.all(Radius.circular(45.r)),
    );
  }

  static OutlineInputBorder focusedErrorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: AppColors.RED),
      borderRadius: BorderRadius.all(Radius.circular(45.r)),
    );
  }

  static OutlineInputBorder errorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 0.6, color: AppColors.RED),
      borderRadius: BorderRadius.all(Radius.circular(45.r)),
    );
  }

  static EdgeInsets kMainPadding(BuildContext context) => EdgeInsets.symmetric(horizontal: isMobile(context) ? 15.w : 30.w);

  static EdgeInsets kpadding(double width, double height) => EdgeInsets.symmetric(horizontal: width.w, vertical: height.h);

  static Widget kh20Spacer() => SizedBox(height: 20.h);
  static Widget kh10Spacer() => SizedBox(height: 10.h);

  static Widget khSpacer(double height) => SizedBox(height: height);

  static Widget kwSpacer(double width) => SizedBox(width: width);

  static bool isXMobile(context) => width(context) < 380;
  static bool isMobile(context) => width(context) < 789;
  static bool isTablet(context) => width(context) > 789 && width(context) < 992;
  static bool isDesktop(context) => width(context) > 992;
}
