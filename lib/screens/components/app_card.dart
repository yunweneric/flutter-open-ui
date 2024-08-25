import 'package:flutter/material.dart';
import 'package:flutter_openui/routes/router.dart';
import 'package:flutter_openui/screens/card_details_screen.dart';
import 'package:flutter_openui/screens/components/circle_btn.dart';
import 'package:flutter_openui/screens/data/models/card_model.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/icons.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class AppCard extends StatefulWidget {
  final CardModel card;
  final int index;
  final int activeIndex;
  final VoidCallback onTap;
  const AppCard({
    super.key,
    required this.card,
    required this.index,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  @override
  Widget build(BuildContext context) {
    double factor = 0.02;
    double maxHeight = widget.activeIndex == widget.index ? AppSizing.height(context) * 0.38 : AppSizing.height(context) * 0.2;
    return GestureDetector(
      onTap: widget.onTap,
      child: Hero(
        tag: widget.card.cardNumber,
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!,
          child: AnimatedContainer(
            clipBehavior: Clip.none,
            duration: const Duration(milliseconds: 300),
            constraints: BoxConstraints(maxHeight: maxHeight),
            height: maxHeight,
            margin: EdgeInsets.symmetric(horizontal: AppSizing.width(context) * factor),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: widget.card.color,
              borderRadius: BorderRadius.circular(30),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(AppIcons.visa),
                      Text(
                        "\$${widget.card.amount}",
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.bgBlack),
                      ),
                    ],
                  ),
                  AppSizing.k20(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/images/card.png", width: 50),
                          Text(
                            "•••• •••• ••••${widget.card.cardNumber}",
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Valid THRU",
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            widget.card.expiryDate,
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  AppSizing.k20(context),
                  Text(
                    widget.card.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  AppSizing.k20(context),
                  const Divider(),
                  AppSizing.k10(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleButton(
                        icon: AppIcons.send,
                        color: Theme.of(context).primaryColorDark,
                        title: "Send",
                      ),
                      CircleButton(
                        icon: AppIcons.receive,
                        color: Theme.of(context).primaryColorDark,
                        title: "Receive",
                      ),
                      CircleButton(
                        icon: AppIcons.add,
                        color: Theme.of(context).primaryColorDark,
                        title: "Add",
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
