import 'package:flutter/material.dart';
import 'package:flutter_openui/presentation/widgets/basuu_app_icon.dart';
import 'package:flutter_openui/shared/basuu_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar basuuAppBar({
  required ThemeData theme,
  required String title,
  String? rightIcon,
  void Function()? onBack,
  void Function()? onNext,
}) {
  return AppBar(
    leadingWidth: 70.w,
    leading: onBack == null
        ? const SizedBox.shrink()
        : Container(
            margin: EdgeInsets.only(left: 20.w, top: 5.h),
            child: InkWell(
              borderRadius: BorderRadius.circular(10.r),
              onTap: onBack,
              child: Container(
                width: 30.w,
                height: 30.w,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const BasuuIcon(icon: BasuuIcons.arrow_back),
              ),
            ),
          ),
    actions: [
      if (rightIcon != null)
        Container(
          margin: EdgeInsets.only(right: 20.w, top: 5.h),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: onNext,
            child: Container(
              width: 40.w,
              height: 40.w,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: BasuuIcon(icon: rightIcon),
            ),
          ),
        ),
    ],
    title: Text(
      title,
      style: theme.textTheme.displayLarge,
      textAlign: TextAlign.center,
    ),
  );
}
