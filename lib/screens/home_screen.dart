import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/sizing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 2500);
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      body: Center(
        child: AnimatedContainer(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          height: AppSizing.height(context) * (isExpanded ? 0.27 : 0.06),
          duration: duration,
          curve: Curves.elasticOut,
          decoration: BoxDecoration(
            color: AppColors.textWhite,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.fullscreen_rounded,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Rounded Corners",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Switch(
                      activeColor: Colors.blue,
                      activeTrackColor: Colors.blue,
                      inactiveTrackColor: const Color.fromARGB(255, 207, 207, 207),
                      trackOutlineColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                        if (states.contains(WidgetState.disabled)) {
                          return AppColors.bgGrey;
                        }
                        return AppColors.bgGrey;
                      }),
                      thumbColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                        if (states.contains(WidgetState.disabled)) {
                          return Colors.blue;
                        }
                        return Colors.white;
                      }),
                      value: isExpanded,
                      onChanged: (val) {
                        setState(() => isExpanded = !isExpanded);
                      },
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CartItem(isExpanded: isExpanded),
                            CartItem(isExpanded: isExpanded),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CartItem(isExpanded: isExpanded),
                            CartItem(isExpanded: isExpanded),
                          ],
                        )
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.textWhite,
                      radius: 30,
                      child: Transform.rotate(
                        alignment: Alignment.center,
                        angle: pi * 0.5,
                        child: const Icon(Icons.link),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final bool isExpanded;
  const CartItem({super.key, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 200);
    return InkWell(
      onTap: () {},
      child: AnimatedContainer(
        duration: duration,
        height: AppSizing.height(context) * 0.09,
        width: AppSizing.width(context) * 0.36,
        decoration: BoxDecoration(
          color: !isExpanded ? AppColors.textWhite : AppColors.bgGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "20",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
