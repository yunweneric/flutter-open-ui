import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nike_slider/utils/colors.dart';
import 'package:flutter_nike_slider/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  List<String> navItems = ["Home", "Shows", "Movies", "Live TV"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/nat_logo.png", scale: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...navItems.map((item) {
                return TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(fixedSize: Size.fromWidth(100)),
                  child: Text(item, style: TextStyle(color: AppColors.white, fontSize: 16)),
                );
              }),
              SizedBox(width: 10),
              Container(width: 2, height: 15, color: Theme.of(context).primaryColorLight),
              SizedBox(width: 20),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(fixedSize: Size.fromWidth(100)),
                child: Text("Login", style: TextStyle(color: AppColors.white, fontSize: 16)),
              ),
              SizedBox(width: 20),
              TextButton(
                onPressed: () {},
                child: Icon(Icons.search, color: Theme.of(context).primaryColorLight),
              )
            ],
          ),
        ],
      ),
    );
  }
}
