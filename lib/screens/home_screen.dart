import 'package:flutter/material.dart';
import 'package:flutter_openui/model/shopping_item.dart';
import 'package:flutter_openui/screens/component/shopping_items.dart';
import 'package:flutter_openui/screens/shop_item_details.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/helper.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text("Fashion Shop"),
        actions: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: SvgPicture.asset('assets/icons/more.svg'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: AppSizing.width(context),
          padding: EdgeInsets.symmetric(horizontal: AppSizing.width(context) * 0.05),
          child: ShoppingItems(),
        ),
      ),
    );
  }
}
