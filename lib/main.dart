import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './Models/Transaction.dart';
import './Widgets/Chart.dart';
import './Widgets/Inputs.dart';
import './Widgets/userTransactions.dart';
import 'Widgets/TransactionView.dart';

void main(List<String> args) {
  runApp(PersonalExpanses());
}

class PersonalExpanses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColorDark: Colors.blueGrey),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Personal Expanses",
          style: TextStyle(
            shadows: [
              Shadow(
                  blurRadius: 30, color: Colors.white, offset: Offset(10, 10))
            ],
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blueGrey,
        child: Column(children: [
          /// the chart card
          Charts(),

          /// responsive widget for transactions
          TransactionView()
        ]),
      ),
    );
  }
}
