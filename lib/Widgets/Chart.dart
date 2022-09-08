import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './/Models/Transaction.dart';

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

  @override
  Widget build(BuildContext context) {
    print(groupedTransactions);
    return Card(
        child: Row(
      children: [],
    ));
  }
}
