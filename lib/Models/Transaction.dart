import 'package:flutter/material.dart';

class Transaction {
  final String title;
  final String currancy;
  final double price;
  final DateTime date;
  Transaction(
    @required this.title,
    @required this.currancy,
    @required this.price,
    @required this.date,
  );
}
