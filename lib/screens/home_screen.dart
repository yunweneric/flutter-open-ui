import 'package:flutter/material.dart';
import 'package:flutter_openui/routes/router.dart';
import 'package:flutter_openui/screens/detail_screen.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class Transaction {
  final String name;
  final String desc;
  final String price;
  final String image;

  Transaction({required this.name, required this.desc, required this.price, required this.image});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Transaction> transactions() => [
        Transaction(
          name: "Netflix",
          desc: "Subscription",
          price: "-\$6.99",
          image: "https://cdn.worldvectorlogo.com/logos/netflix-logo-icon.svg",
        ),
        Transaction(
          name: "Youtube",
          desc: "Subscription",
          price: "-\$4.05",
          image: "https://cdn.worldvectorlogo.com/logos/youtube-shorts-1.svg",
        ),
        Transaction(
          name: "Firebase",
          desc: "Subscription",
          price: "-\$32.00",
          image: "https://cdn.worldvectorlogo.com/logos/firebase-1.svg",
        ),
        Transaction(
          name: "Figma",
          desc: "Subscription",
          price: "-\$15.00",
          image: "https://cdn.worldvectorlogo.com/logos/figma-icon.svg",
        ),
        Transaction(
          name: "Google drive",
          desc: "Restaurant",
          price: "-\$12.05",
          image: "https://cdn.worldvectorlogo.com/logos/google-drive.svg",
        ),
      ];
  bool isDetailedView = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: AppSizing.width(context),
            margin: const EdgeInsets.symmetric(horizontal: 50),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Transactions",
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
                ),
                AppSizing.k10(context),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: transactions().length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (c, i) {
                    final transaction = transactions()[i];
                    return TransactionCard(
                      transaction: transaction,
                      onTap: () {
                        AppRouter.navigate(context, DetailScreen(transaction: transaction));
                        setState(() {
                          isDetailedView = true;
                        });
                      },
                    );
                  },
                ),
                SizedBox(
                  width: AppSizing.width(context),
                  child: ElevatedButton.icon(
                    iconAlignment: IconAlignment.end,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color.fromARGB(255, 232, 231, 231),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    label: const Text(
                      "All Transactions",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    icon: const Icon(Icons.arrow_forward, size: 18),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final void Function()? onTap;
  const TransactionCard({super.key, required this.transaction, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        horizontalTitleGap: 10,
        dense: true,
        visualDensity: VisualDensity.compact,
        contentPadding: EdgeInsets.zero,
        leading: SizedBox(
          child: Hero(
            tag: transaction.image,
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 41, 41, 42),
              child: SvgPicture.network(
                transaction.image,
                width: 25,
                height: 25,
                // color: Colors.white,
              ),
            ),
          ),
        ),
        title: Hero(
          tag: transaction.name,
          child: Text(
            transaction.name,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        subtitle: Text(
          transaction.desc,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        trailing: Text(
          transaction.price,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }
}
