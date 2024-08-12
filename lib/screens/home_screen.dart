import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class Subscription {
  final String name;
  final int amount;
  final String type;
  final String expireDate;
  final String cycle;

  Subscription({
    required this.name,
    required this.amount,
    required this.type,
    required this.expireDate,
    required this.cycle,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<Subscription> subs = [
      Subscription(
        name: "Amazone",
        amount: 12,
        type: "Business",
        expireDate: "12/02/2024",
        cycle: "Monthly",
      ),
      Subscription(
        name: "Prime",
        amount: 12,
        type: "Business",
        expireDate: "12/02/2024",
        cycle: "Monthly",
      ),
      Subscription(
        name: "Google Drive",
        amount: 12,
        type: "Business",
        expireDate: "12/02/2024",
        cycle: "Monthly",
      ),
      Subscription(
        name: "PlayStation",
        amount: 12,
        type: "Business",
        expireDate: "12/02/2024",
        cycle: "Monthly",
      ),
      Subscription(
        name: "Dropbox",
        amount: 12,
        type: "Business",
        expireDate: "12/02/2024",
        cycle: "Monthly",
      ),
      Subscription(
        name: "HBO",
        amount: 12,
        type: "Business",
        expireDate: "12/02/2024",
        cycle: "Monthly",
      ),
      Subscription(
        name: "Netflix",
        amount: 12,
        type: "Business",
        expireDate: "12/02/2024",
        cycle: "Monthly",
      ),
      Subscription(
        name: "Spotify",
        amount: 12,
        type: "Business",
        expireDate: "12/02/2024",
        cycle: "Monthly",
      ),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              // color: Colors.teal,
              height: AppSizing.height(context) * 3,
              width: AppSizing.width(context),
              child: Transform.rotate(
                angle: pi,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: AppSizing.height(context) / 3),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        // controller: ScrollController(initialScrollOffset: 0),
                        itemCount: subs.length,
                        separatorBuilder: (c, i) => SizedBox(height: 0),
                        itemBuilder: (c, i) {
                          final item = subs[i];
                          return Align(
                            heightFactor: 0.9,
                            child: Transform.rotate(
                              angle: pi,
                              child: SubscriptionCard(
                                item: item,
                                index: i,
                              ),
                            ),
                          );
                        },
                      ),
                      // SizedBox(height: AppSizing.height(context) / 3),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: Container(
                height: AppSizing.height(context) / 3,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: AppSizing.width(context),
            height: AppSizing.height(context) / 3,
            color: Theme.of(context).highlightColor.withOpacity(0.4),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("All subscriptions", style: Theme.of(context).textTheme.displayLarge),
                      CircleAvatar(
                        backgroundColor: Theme.of(context).cardColor,
                        child: SvgPicture.asset("assets/icons/sun.svg"),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      counter("1", "My Subs"),
                      counter("1", "My Subs"),
                      counter("1", "My Subs"),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget counter(String counter, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          counter,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(title),
      ],
    );
  }
}

class SubscriptionCard extends StatefulWidget {
  final Subscription item;
  final int index;

  const SubscriptionCard({super.key, required this.item, required this.index});

  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  @override
  Widget build(BuildContext context) {
    final isEven = widget.index % 2 == 0;

    return Container(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.01)
        ..rotateZ(!isEven ? 0.02 : -0.02),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            spreadRadius: 5,
            blurRadius: 2,
            color: Theme.of(context).highlightColor.withOpacity(0.1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            leading: SvgPicture.asset("assets/images/logo_${widget.index}.svg", width: 50),
            title: Text(
              widget.item.name,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            trailing: Text(
              "\$${widget.item.amount}",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          SizedBox(height: 30),
          Container(
            alignment: Alignment.centerRight,
            width: AppSizing.width(context) * 0.65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                option("Expiry Date", widget.item.expireDate),
                option("Cycle", widget.item.cycle),
                option("Type", widget.item.type),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget option(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(value, style: Theme.of(context).textTheme.displayMedium),
      ],
    );
  }
}
