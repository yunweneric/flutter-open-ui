import 'package:flutter/material.dart';
import 'package:flutter_openui/utils/colors.dart';
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
          name: "Bank Transfer",
          desc: "Transfer money to bank account",
          price: "-\$6.99",
          image: "https://cdn.worldvectorlogo.com/logos/netflix-logo-icon.svg",
        ),
        Transaction(
          name: "Debit/Credit Card",
          desc: "Send money from your card",
          price: "-\$4.05",
          image: "https://cdn.worldvectorlogo.com/logos/youtube-shorts-1.svg",
        ),
        Transaction(
          name: "Wallet",
          desc: "Transfer money from your wallet",
          price: "-\$32.00",
          image: "https://cdn.worldvectorlogo.com/logos/firebase-1.svg",
        ),
      ];
  bool isFormVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            clipBehavior: Clip.none,
            duration: const Duration(milliseconds: 500),
            width: AppSizing.width(context),
            height: !isFormVisible ? AppSizing.height(context) * 0.3 : AppSizing.height(context) * 0.48,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            // padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 5, blurRadius: 12),
                BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 1),
              ],
            ),
            child: SingleChildScrollView(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    // bottom: 0,
                    // top: 0,
                    // left: 0,
                    // right: 0,
                    child: Opacity(
                      opacity: isFormVisible ? 1 : 0,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Text(
                                  //   "Bank Transfer",
                                  //   style: Theme.of(context).textTheme.bodyLarge,
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      setState(() => isFormVisible = false);
                                    },
                                    child: AnimatedOpacity(
                                      duration: const Duration(milliseconds: 700),
                                      opacity: isFormVisible ? 1 : 0,
                                      child: const CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Color.fromARGB(255, 206, 206, 206),
                                        child: Icon(Icons.close, color: Colors.white, size: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AppSizing.k10(context),
                            Divider(color: Colors.grey.withOpacity(0.2)),
                            AppSizing.k20(context),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const FormField(label: 'Full Name'),
                                  const FormField(label: 'Account Number'),
                                  const FormField(label: 'Bank Code'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.bgBlack,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      "Proceed",
                                      style: TextStyle(color: AppColors.bgWhite),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    // opacity: !isFormVisible ? 1 : 0,
                    opacity: 1,
                    child: Transform.translate(
                      // offset: Offset(0, !isFormVisible ? 0 : 500),
                      offset: Offset(0, 0),
                      child: sendMoneyWidget(context),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget sendMoneyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Send Money",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          AppSizing.k10(context),
          ListView.builder(
            clipBehavior: Clip.none,
            padding: EdgeInsets.zero,
            itemCount: transactions().length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (c, i) {
              final transaction = transactions()[i];
              return TransactionCard(
                transaction: transaction,
                onTap: () {
                  setState(() {
                    isFormVisible = !isFormVisible;
                  });
                },
              );
            },
          ),

          // TweenAnimationBuilder(
          //     tween: Tween<double>(begin: isFormVisible ? 0 : 1, end: isFormVisible ? 1 : 0),
          //     duration: const Duration(milliseconds: 500),
          //     builder: (context, v, c) {
          //       return Transform.translate(
          //         offset: Offset(0, v * 100),
          //         child: Opacity(
          //           opacity: 1 - v,
          //           child: ListView.builder(
          //             padding: EdgeInsets.zero,
          //             itemCount: transactions().length,
          //             physics: const NeverScrollableScrollPhysics(),
          //             shrinkWrap: true,
          //             itemBuilder: (c, i) {
          //               final transaction = transactions()[i];
          //               return TransactionCard(
          //                 transaction: transaction,
          //                 onTap: () {
          //                   setState(() {
          //                     isFormVisible = !isFormVisible;
          //                   });
          //                 },
          //               );
          //             },
          //           ),
          //         ),
          //       );
          //     }),
        ],
      ),
    );
  }
}

class FormField extends StatelessWidget {
  final String label;
  const FormField({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
        AppSizing.k5(context),
        TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        AppSizing.k10(context),
      ],
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
        // horizontalTitleGap: 10,
        dense: true,
        visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        leading: SizedBox(
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
        title: Transform.translate(
          offset: const Offset(-50, -50),
          child: Text(
            transaction.name,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        subtitle: Text(
          transaction.desc,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
