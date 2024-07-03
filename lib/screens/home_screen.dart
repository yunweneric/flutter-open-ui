import 'package:flutter/material.dart';
import 'package:flutter_openui/model/shopping_item.dart';
import 'package:flutter_openui/screens/shop_item_details.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPushing = false;
  Tween<Offset> generateTweens() {
    print(["isPushing", isPushing]);
    return isPushing
        ? Tween<Offset>(
            begin: Offset.zero,
            end: Offset(0, AppSizing.height(context) / 5),
          )
        : Tween<Offset>(
            begin: Offset(0, AppSizing.height(context)),
            end: Offset.zero,
          );
  }

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
          child: TweenAnimationBuilder(
              // tween: generateTweens(),
              tween: generateTweens(),
              curve: Curves.easeOutExpo,
              // curve: Curves.easeInOutExpo,
              key: ValueKey(isPushing),
              duration: Duration(milliseconds: 750),
              builder: (context, value, child) {
                return Transform.translate(
                  // offset: Offset(0, AppSizing.height(context) / 2),
                  offset: value,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      ...ShoppingItem.data().map((e) => shoppingItem(e)).toList(),
                      // ...ShoppingItem.data().map((e) => shoppingItem(e)).toList(),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget shoppingItem(ShoppingItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: item.index % 2 == 0 ? 50 : 0),
      child: InkWell(
        onTap: () async {
          setState(() {
            isPushing = !isPushing;
          });
          final result = await Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 1000),
              reverseTransitionDuration: Duration(milliseconds: 1000),
              pageBuilder: (context, animation, secondaryAnimation) => ShopItemDetails(item: item),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // return child;
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
          setState(() {
            isPushing = result;
          });
        },
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                height: 30,
                width: 30,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.grayLight),
                ),
                child: SvgPicture.asset("assets/icons/heart.svg"),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: item.title,
                  child: Container(
                    width: AppSizing.width(context) * 0.42,
                    margin: EdgeInsets.only(bottom: item.index % 2 == 0 ? 0 : 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: item.color.withOpacity(0.1),
                    ),
                    child: Image.asset("assets/images/shop_item_${item.index}.png"),
                  ),
                ),
                AppSizing.k10(context),
                Text(item.title),
                Text(item.price.toString()),
                SizedBox(
                  width: AppSizing.width(context) * 0.42,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Text(
                      "\$${item.price}",
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    title: Text(
                      "\$${item.discount}",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w100,
                            fontSize: 11,
                          ),
                    ),
                    trailing: Transform.scale(
                      scale: 0.8,
                      child: Chip(
                        side: BorderSide.none,
                        padding: EdgeInsets.zero,
                        label: Text(
                          "${item.itemSold} Sold",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
