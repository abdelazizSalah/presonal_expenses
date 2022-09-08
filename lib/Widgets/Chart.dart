import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './/Models/Transaction.dart';
import 'BarChart.dart';

class Charts extends StatelessWidget {
  final List<Transaction> txs;
  const Charts(this.txs);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      /// the weekDay should be modified every index iteration
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double dayAmount = 0.0;
      for (int i = 0; i < txs.length; i++) {
        /// must make sure that this is
        /// the same day
        if (weekDay.day == txs[i].date.day) {
          /// on the same month
          if (weekDay.month == txs[i].date.month) {
            /// on the same year
            if (weekDay.year == txs[i].date.year) {
              /// add this price to the total amount of this day
              dayAmount += txs[i].price;
            }
          }
        }
      }
      return {"day": DateFormat.E().format(weekDay), "amount": dayAmount};
    });
  }

  double get getTotalAmount {
    double total = 0.0;
    for (Map<String, Object> tx in groupedTransactions) {
      total += tx['amount'] as double;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 400,
      child: Flexible(
        child: Card(
            color: Colors.white70,
            elevation: 20,
            // color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: groupedTransactions.map((data) {
                return BarChart(
                    label: data["day"] as String,
                    price: data['amount'] as double,
                    percentageOfTotalSpending: groupedTransactions.isEmpty
                        ? 0.0
                        : (data['amount'] as double) / getTotalAmount);
              }).toList(),
            )),
      ),
    );
  }
}
