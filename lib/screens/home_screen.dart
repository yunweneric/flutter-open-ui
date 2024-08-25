import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_openui/core/instances.dart';
import 'package:flutter_openui/data/controllers/bloc/navigation_bloc.dart';
import 'package:flutter_openui/routes/router.dart';
import 'package:flutter_openui/screens/card_details_screen.dart';
import 'package:flutter_openui/screens/components/app_card.dart';
import 'package:flutter_openui/screens/components/circle_btn.dart';
import 'package:flutter_openui/screens/components/section_title.dart';
import 'package:flutter_openui/screens/components/transaction_card.dart';
import 'package:flutter_openui/screens/data/models/card_model.dart';
import 'package:flutter_openui/screens/data/models/transactions.dart';
import 'package:flutter_openui/utils/colors.dart';
import 'package:flutter_openui/utils/icons.dart';
import 'package:flutter_openui/utils/sizing.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CardModel> cards = [
    CardModel(
      amount: "12,322.98",
      name: "YUNWEN ERIC",
      expiryDate: "12/29",
      cardNumber: "0944",
      color: AppColors.bgWhite,
    ),
    CardModel(
      amount: "3,350.99",
      name: "MUSAB ALFAWAL",
      expiryDate: "04/39",
      cardNumber: "4532",
      color: AppColors.primaryYellow,
    ),
    CardModel(
      amount: "76,540.45",
      name: "MUSAB ALFAWAL",
      expiryDate: "04/39",
      cardNumber: "4502",
      color: AppColors.blueLight,
    ),
  ];

  List<Transaction> transactions = [
    Transaction(title: "Amazon", subtitle: "09 Feb 2024", amount: "-\$103.56", isSend: false),
    Transaction(title: "Netflix", subtitle: "12 May 2023", amount: "-\$303.87", isSend: true),
    Transaction(title: "Visa", subtitle: "12 May 2023", amount: "+\$1029.87", isSend: false),
    Transaction(title: "Apple", subtitle: "08 June 2024", amount: "+\$1,000.97", isSend: true),
  ];
  PageController? pageController;

  bool hasPushed2 = true;
  bool hasZoomed = true;
  bool hasPushed = true;
  final duration = const Duration(milliseconds: 3000);
  final curve = Curves.elasticOut;
  @override
  void initState() {
    pageController = PageController(initialPage: 1, viewportFraction: 0.85);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        hasPushed = false;
        hasPushed2 = false;
        hasZoomed = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController?.dispose();

    super.dispose();
  }

  int activeIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            heroSection(context, 0),
            AppSizing.khSpacer(AppSizing.height(context) * 0.04),
            pageView(context),
            AppSizing.khSpacer(AppSizing.height(context) * 0.04),
            BlocListener<NavigationBloc, NavigationState>(
              bloc: navBloc,
              listener: (context, state) {
                if (state is NavigateToHomeSuccess) {
                  setState(() {
                    hasPushed = false;
                    hasPushed2 = false;
                    hasZoomed = false;
                  });
                }
              },
              child: transactionSections(context, 0),
            ),
          ],
        ),
      ),
    );
  }

  Widget transactionSections(BuildContext context, double value) {
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
                icon: AppIcons.openTab,
                fontSize: 30,
                title: "Last",
                subtitle: "Transactions",
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
      },
    );
  }

  Widget pageView(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      height: AppSizing.height(context) * 0.38,
      child: Center(
        child: PageView.builder(
          controller: pageController,
          itemCount: cards.length,
          onPageChanged: (page) {
            setState(() => activeIndex = page);
          },
          itemBuilder: (c, i) {
            return TweenAnimationBuilder(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.fastLinearToSlowEaseIn,
              key: ValueKey(hasZoomed),
              tween: hasZoomed ? Tween<double>(begin: 0.0, end: 1.0) : Tween(begin: 1.0, end: 0.0),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: 1 - value,
                  child: Center(
                    child: AppCard(
                      onTap: () async {
                        setState(() {
                          hasPushed = true;
                          hasPushed2 = true;
                        });
                        AppRouter.navigate(
                          context,
                          CardDetailsScreen(card: cards[i]),
                        );
                      },
                      card: cards[i],
                      index: i,
                      activeIndex: activeIndex,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget heroSection(BuildContext context, double value) {
    return TweenAnimationBuilder(
        duration: duration,
        curve: curve,
        key: ValueKey(hasPushed2),
        tween: hasPushed ? Tween<double>(begin: 0.0, end: 1.0) : Tween(begin: 1.0, end: 0.0),
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0.0, value * -100),
            child: Column(
              children: [
                AppSizing.k20(context),
                AppSizing.khSpacer(kToolbarHeight),
                Padding(
                  padding: AppSizing.kMainPadding(context),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleButton(icon: AppIcons.menu),
                      CircleButton(icon: AppIcons.notification),
                    ],
                  ),
                ),
                AppSizing.khSpacer(AppSizing.height(context) * 0.04),
                sectionTitle(
                  context: context,
                  icon: AppIcons.add,
                  fontSize: 40,
                  title: "My",
                  subtitle: "Cards",
                ),
              ],
            ),
          );
        });
  }
}
