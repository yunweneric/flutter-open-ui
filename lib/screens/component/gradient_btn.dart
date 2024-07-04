import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/sizing.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onTap;
  final EdgeInsetsGeometry? padding;
  final String title;
  const GradientButton({super.key, required this.onTap, required this.title, this.padding});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: 45,
        width: AppSizing.width(context) * 0.5,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: const LinearGradient(
            colors: [
              AppColors.orange,
              AppColors.orangeDark,
            ],
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.white),
        ),
      ),
    );
  }
}
