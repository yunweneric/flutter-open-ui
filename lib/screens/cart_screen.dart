import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/component/shopping_items.dart';
import 'package:flutter_openui/screens/home_screen.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCard,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: AppSizing.width(context),
              clipBehavior: Clip.hardEdge,
              padding: EdgeInsets.symmetric(horizontal: AppSizing.width(context) * 0.05),
              decoration: const BoxDecoration(color: AppColors.white),
              child: Column(
                children: [
                  const SizedBox(height: kToolbarHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back)),
                      Text(
                        "Your Cart",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      SvgPicture.asset('assets/icons/more.svg'),
                    ],
                  ),
                  AppSizing.k20(context),
                ],
              ),
            ),
            Container(
              height: AppSizing.height(context) * 0.75,
              width: AppSizing.width(context),
              clipBehavior: Clip.hardEdge,
              padding: EdgeInsets.symmetric(horizontal: AppSizing.width(context) * 0.05),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: const SingleChildScrollView(
                child: ShoppingItems(),
              ),
            ),
            Container(
              height: AppSizing.height(context) * 0.5,
            )
          ],
        ),
      ),
    );
  }
}
