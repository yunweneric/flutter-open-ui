import 'package:flutter/material.dart';

class CardModel {
  final String amount;
  final String name;
  final String expiryDate;
  final String cardNumber;
  final Color color;

  CardModel({
    required this.amount,
    required this.name,
    required this.expiryDate,
    required this.color,
    required this.cardNumber,
  });
}
