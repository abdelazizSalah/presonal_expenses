import 'package:flutter/material.dart';
import 'Inputs.dart';
import 'userTransactions.dart';
import 'package:intl/intl.dart';
import '../Models/Transaction.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  List<Transaction> txs = [
    Transaction("PlayStation5", "\$", 200, DateTime.now()),
    // Transaction("Laptop Acer", "EGP ", 39043.99, DateTime.now()),
    // Transaction("Rolex Watch", "Euro ", 4500, DateTime.now()),
    // Transaction("I Pad", "\$", 421.43, DateTime.now()),
  ];

  String titleInput = "no item";
  String currancyInput = "";
  double priceInput = 0.0;
  DateTime dateInput = DateTime.now();

  void setTitle(String inp) {
    titleInput = inp;
    print(titleInput);
  }

  void setCurrnacy(String inp) {
    currancyInput = inp;
    print(currancyInput);
  }

  void setPrice(String inp) {
    priceInput = double.parse(inp);
    print(priceInput);
  }

  void setDate(String inp) {
    dateInput = DateTime.now();
    print(DateFormat.yMMMd().format(dateInput));
  }

  void addElement() {
    // input validations
    if (titleInput == "no item" || currancyInput == "" || priceInput <= 0.0) {
      return;
    }

    Transaction tx =
        Transaction(titleInput, currancyInput, priceInput, dateInput);
    setState(() {
      txs.add(tx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 620,
        child: Column(
          children: [
            /// inputs card
            Inputs(
                setCurrnacy: setCurrnacy,
                addElement: addElement,
                setDate: setDate,
                setPrice: setPrice,
                setTitle: setTitle),

            ///the transactions card
            UserTransactions(txs: txs)
          ],
        ));
  }
}
