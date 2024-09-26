import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/home_screen.dart';
import 'package:flutter_openui/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class DetailScreen extends StatefulWidget {
  final Transaction transaction;
  const DetailScreen({super.key, required this.transaction});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isDetailedView = false;
  @override
  Widget build(BuildContext context) {
    final transaction = widget.transaction;
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
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
                    AppSizing.k10(context),
                    Hero(
                      tag: transaction.image,
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 41, 41, 42),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SvgPicture.network(
                          transaction.image,
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                    Hero(
                      tag: transaction.name,
                      child: Material(
                        color: Colors.transparent,
                        child: ListTile(
                          horizontalTitleGap: 10,
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            transaction.name,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            transaction.desc,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          trailing: Text(
                            transaction.price,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    Text(
                      "#670920",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      "September 2024",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      "5:32PM",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Divider(),
                    Text(
                      "Paid via Credit Card",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      "XXXX 231980",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 60,
                top: 10,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: Color.fromARGB(255, 206, 206, 206),
                    child: Icon(Icons.close, color: Colors.white, size: 20),
                  ),
                ),
              )
            ],
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
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 10,
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        backgroundColor: Color.fromARGB(255, 41, 41, 42),
      ),
      title: Text(
        transaction.name,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        transaction.desc,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
      ),
      trailing: Text(
        transaction.price,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
      ),
    );
  }
}
