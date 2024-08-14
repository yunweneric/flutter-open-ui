import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/data.dart';
import 'package:flutter_openui/utils/colors.dart';

Stack temperatureWidget(Condition condition, BuildContext context) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Text(
        condition.temperature < 10 ? condition.temperature.toString().padLeft(2, '0') : condition.temperature.toString(),
        style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColors.textWhite),
      ),
      Positioned(
        right: -10,
        top: 10,
        child: Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.textWhite,
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
        ),
      ),
    ],
  );
}
