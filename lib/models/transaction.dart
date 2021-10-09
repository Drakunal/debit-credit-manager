import 'package:flutter/cupertino.dart';

class Transaction {
  final String id;
  final String details;
  final String type;
  final double amount;
  final DateTime date;
  final Color star;
  Transaction(
      {required this.id,
      required this.star,
      required this.amount,
      required this.date,
      required this.details,
      required this.type});
}
