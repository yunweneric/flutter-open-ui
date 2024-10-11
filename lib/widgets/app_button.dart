import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final Color? bgColor;
  final Color? textColor;
  final Color? disabledBgColor;
  final TextStyle? textStyle;
  final Widget? icon;
  final double? width;
  final double? height;
  final double? borderRadius;
  final bool isDisabled;
  final bool isElevated;
  final BorderSide? side;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    required this.title,
    required this.onPressed,
    this.bgColor,
    this.borderRadius,
    this.textColor,
    this.disabledBgColor,
    this.textStyle,
    this.icon,
    this.side,
    this.width,
    this.height,
    this.padding,
    this.isDisabled = false,
    this.isElevated = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: isElevated ? null : 0,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
        disabledBackgroundColor: disabledBgColor ?? bgColor?.withOpacity(.5),
        backgroundColor: bgColor ?? theme.colorScheme.primary,
        surfaceTintColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 16.r), side: side ?? BorderSide.none),
        shadowColor: AppColors.TEXTBLACK.withOpacity(.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(width: 8),
          ],
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: textStyle ??
                  theme.textTheme.bodyMedium!.copyWith(
                    color: textColor ?? AppColors.TEXTWHITE,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
