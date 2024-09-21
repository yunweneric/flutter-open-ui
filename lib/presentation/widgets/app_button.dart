import 'package:flutter/material.dart';
import 'package:flutter_openui/shared/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatefulWidget {
  final Widget? icon;
  final String text;
  final double? width;
  final Color? bgColor;
  final BorderSide? side;
  final void Function()? onPressed;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;
  const AppButton({
    super.key,
    this.icon,
    required this.text,
    this.bgColor,
    this.width,
    this.onPressed,
    this.side,
    this.style,
    this.padding,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          backgroundColor: widget.bgColor ?? Theme.of(context).primaryColor,
          side: widget.side,
          elevation: 0,
        ),
        onPressed: widget.onPressed,
        icon: widget.icon,
        label: Text(
          widget.text,
          style: widget.style ??
              Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.TEXTBLACK,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
        ),
      ),
    );
  }
}
