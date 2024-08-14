import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/data.dart';
import 'package:flutter_openui/screens/widget/temperature_widget.dart';
import 'package:flutter_openui/utils/colors.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...weather.map((condition) {
              return Column(
                children: [
                  Text(
                    condition.day,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColors.textWhite, fontSize: 12),
                  ),
                  temperatureWidget(condition, context),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
