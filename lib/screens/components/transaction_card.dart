import 'package:flutter/material.dart';
import 'package:flutter_openui/screens/components/circle_btn.dart';
import 'package:flutter_openui/screens/data/models/transactions.dart';
import 'package:flutter_openui/utils/icons.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionCard extends StatefulWidget {
  final Transaction transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        tileColor: Theme.of(context).highlightColor,
        leading: CircleButton(icon: widget.transaction.isSend ? AppIcons.send : AppIcons.receive),
        title: Text(widget.transaction.title),
        subtitle: Text(widget.transaction.subtitle),
        trailing: Text(
          widget.transaction.amount,
          style: GoogleFonts.inter(
            fontSize: 15,
            color: Theme.of(context).primaryColorLight,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
