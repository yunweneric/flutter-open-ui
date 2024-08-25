import 'package:flutter/material.dart';
import 'package:flutter_openui/core/instances.dart';
import 'package:flutter_openui/data/controllers/bloc/navigation_bloc.dart';
import 'package:flutter_openui/screens/components/circle_btn.dart';
import 'package:flutter_openui/screens/components/section_title.dart';
import 'package:flutter_openui/screens/components/transaction_card.dart';
import 'package:flutter_openui/screens/data/models/card_model.dart';
import 'package:flutter_openui/screens/data/models/transactions.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/icons.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class CardDetailsScreen extends StatefulWidget {
  final CardModel card;
  const CardDetailsScreen({super.key, required this.card});

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  List<Transaction> transactions = [
    Transaction(title: "Amazon", subtitle: "09 Feb 2024", amount: "-\$103.56", isSend: false),
    Transaction(title: "Netflix", subtitle: "12 May 2023", amount: "-\$303.87", isSend: true),
    Transaction(title: "Visa", subtitle: "12 May 2023", amount: "+\$1029.87", isSend: false),
    Transaction(title: "Apple", subtitle: "08 June 2024", amount: "+\$1,000.97", isSend: true),
  ];

  bool hasPushed = false;
  final duration = const Duration(milliseconds: 3000);
  final curve = Curves.elasticOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.card.cardNumber,
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyMedium!,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                  decoration: BoxDecoration(
                    color: widget.card.color,
                    // color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppSizing.khSpacer(AppSizing.height(context) * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleButton(
                              icon: AppIcons.back,
                              color: AppColors.bgBlack,
                              onTap: () {
                                navBloc.add(UpdateNavigator());
                                Navigator.pop(context);
                                setState(() {
                                  hasPushed = true;
                                });
                              },
                            ),
                            CircleButton(
                              icon: AppIcons.eq,
                              color: AppColors.bgBlack,
                              onTap: () {},
                            ),
                          ],
                        ),
                        AppSizing.k20(context),
                        AppSizing.k10(context),
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
                        AppSizing.k10(context),
                        Text(
                          widget.card.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        AppSizing.k20(context),
                        const Divider(),
                        AppSizing.k20(context),
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
            AppSizing.khSpacer(AppSizing.height(context) * 0.03),
            transactionList(context)
          ],
        ),
      ),
    );
  }

  Widget transactionList(BuildContext context) {
    return TweenAnimationBuilder(
        duration: duration,
        curve: curve,
        key: ValueKey(hasPushed),
        tween: hasPushed ? Tween<double>(begin: 0.0, end: 1.0) : Tween(begin: 1.0, end: 0.0),
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0.0, value * 100),
            child: Column(
              children: [
                sectionTitle(
                  context: context,
                  icon: AppIcons.chart,
                  fontSize: 30,
                  title: "Card",
                  subtitle: "History",
                ),
                AppSizing.khSpacer(AppSizing.height(context) * 0.02),
                ListView.separated(
                  padding: AppSizing.kMainPadding(context),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: transactions.length,
                  separatorBuilder: (c, i) => AppSizing.k10(context),
                  itemBuilder: (context, index) {
                    return TransactionCard(transaction: transactions[index]);
                  },
                ),
              ],
            ),
          );
        });
  }
}
