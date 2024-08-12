import 'dart:math';
// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openui/routes/router.dart';
import 'package:flutter_openui/screens/detail_screen.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class Subscription {
  final String name;
  final int amount;
  final String type;
  final String expireDate;
  final String cycle;
  final Color color;

  Subscription({
    required this.name,
    required this.amount,
    required this.type,
    required this.expireDate,
    required this.cycle,
    required this.color,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController? _scrollController;

  List<Subscription> subs = [
    Subscription(
      name: "Amazon",
      amount: 7,
      type: "Individual",
      expireDate: "01/05/2022",
      cycle: "Daily",
      color: Color(0xFFFF9900),
    ),
    Subscription(
      name: "Prime",
      amount: 33,
      type: "Individual",
      expireDate: "09/02/2024",
      cycle: "Yearly",
      color: Color(0xff00A8E1),
    ),
    Subscription(
      name: "Google Drive",
      amount: 54,
      type: "Business",
      expireDate: "15/01/2024",
      cycle: "Monthly",
      color: Color(0XFF4185F3),
    ),
    Subscription(
      name: "PlayStation",
      amount: 12,
      type: "Business",
      expireDate: "02/11/2024",
      cycle: "Monthly",
      color: Color(0xff000000),
    ),
    Subscription(
      name: "Dropbox",
      amount: 87,
      type: "Individual",
      expireDate: "01/05/2024",
      cycle: "Daily",
      color: Color(0xff0062FF),
    ),
    Subscription(
      name: "HBO",
      amount: 18,
      type: "Individual",
      expireDate: "03/02/2024",
      cycle: "Daily",
      color: Color(0xff000000),
    ),
    Subscription(
      name: "Netflix",
      amount: 12,
      type: "Business",
      expireDate: "22/09/2024",
      cycle: "Monthly",
      color: Color(0xffFA0000),
    ),
    Subscription(
      name: "Spotify",
      amount: 5,
      type: "Individual",
      expireDate: "11/02/2024",
      cycle: "Daily",
      color: Color(0XFF2EBD59),
    ),
  ];
  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: 600);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  int activeTap = 0;

  bool hasPushed = false;

  final duration = const Duration(milliseconds: 2000);
  final curve = Curves.elasticOut;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            scrollView(context, subs),
            headerBlur(context),
            header(context),
            tabs(context),
            bottomBar(context),
          ],
        ),
      ),
    );
  }

  Positioned headerBlur(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        child: Container(
          height: AppSizing.height(context) / 3,
          // child: BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          //   child: Container(
          //     color: Colors.transparent,
          //   ),
          // ),
          child: SizedBox(
            // imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  Positioned scrollView(BuildContext context, List<Subscription> subs) {
    return Positioned(
      child: SizedBox(
        height: AppSizing.height(context) * 3,
        width: AppSizing.width(context),
        child: Transform.rotate(
          angle: pi,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(height: AppSizing.height(context) * 0.05),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: subs.length,
                  itemBuilder: (c, i) {
                    final item = subs[i];
                    return Align(
                      heightFactor: 0.9,
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            hasPushed = true;
                          });
                          final hasPopped = await AppRouter.navigate(context, DetailScreen(index: i, sub: item));
                          setState(() {
                            hasPushed = !hasPopped;
                          });
                        },
                        child: GestureDetector(
                          child: Transform.rotate(
                            angle: pi,
                            child: Hero(
                              tag: i,
                              child: SubscriptionCard(
                                item: item,
                                index: i,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: AppSizing.height(context) * 0.4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnimatedPositioned header(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      top: hasPushed ? -100 : 0,
      curve: curve,
      child: Container(
        width: AppSizing.width(context),
        height: AppSizing.height(context) / 3,
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    counter("7", "My Subs"),
                    counter("4", "With trial period"),
                    counter("\$207", "Amount"),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedPositioned tabs(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      left: 20,
      right: 20,
      curve: curve,
      top: hasPushed ? AppSizing.height(context) * 0.2 : AppSizing.height(context) * 0.3,
      child: Container(
        alignment: Alignment.center,
        width: AppSizing.width(context) / 2,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            button(index: 0, context: context, title: "Card"),
            button(index: 1, context: context, title: "Calendar"),
            button(index: 2, context: context, title: "Flow"),
          ],
        ),
      ),
    );
  }

  Widget bottomBar(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      bottom: hasPushed ? -100 : 20,
      curve: curve,
      // child: ClipRRect(
      //   child: BackdropFilter(
      //     filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      //     child: Container(
      //       alignment: Alignment.center,
      //       width: AppSizing.width(context),
      //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //       decoration: BoxDecoration(
      //         color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
      //         borderRadius: BorderRadius.circular(10),
      //       ),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Container(
      //             decoration: BoxDecoration(
      //               color: Theme.of(context).hoverColor,
      //               borderRadius: BorderRadius.circular(30),
      //             ),
      //             child: Container(
      //               width: AppSizing.width(context) * 0.35,
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                 children: [
      //                   circleIcon("assets/icons/card.svg"),
      //                   circleIcon("assets/icons/sun.svg"),
      //                   circleIcon("assets/icons/settings.svg"),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               circleIcon("assets/icons/filter.svg"),
      //               const SizedBox(width: 10),
      //               circleIcon("assets/icons/add.svg"),
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      child: ClipRRect(
        child: SizedBox(
          // imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            alignment: Alignment.center,
            width: AppSizing.width(context),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).hoverColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    width: AppSizing.width(context) * 0.35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        circleIcon("assets/icons/card.svg"),
                        circleIcon("assets/icons/sun.svg"),
                        circleIcon("assets/icons/settings.svg"),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    circleIcon("assets/icons/filter.svg"),
                    const SizedBox(width: 10),
                    circleIcon("assets/icons/add.svg"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget circleIcon(String icon) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).hoverColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SvgPicture.asset(icon),
      ),
    );
  }

  ElevatedButton button({required BuildContext context, required int index, required String title}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 2),
        fixedSize: Size.fromWidth(AppSizing.width(context) * 0.26),
        backgroundColor: index == activeTap ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5) : Theme.of(context).cardColor,
      ),
      onPressed: () {
        setState(() {
          activeTap = index;
        });
      },
      child: Text(
        title,
        style: Theme.of(context).textTheme.displayMedium,
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
        Text(title, style: Theme.of(context).textTheme.labelMedium),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 5,
            color: Theme.of(context).highlightColor.withOpacity(0.1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Material(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
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
          ),
          const SizedBox(height: 30),
          Container(
            alignment: Alignment.centerRight,
            width: AppSizing.width(context) * 0.6,
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
        Text(title, style: Theme.of(context).textTheme.labelSmall),
        Text(value, style: Theme.of(context).textTheme.displaySmall),
      ],
    );
  }
}
