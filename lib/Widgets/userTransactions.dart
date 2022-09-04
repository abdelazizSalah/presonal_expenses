import 'package:flutter/material.dart';
import '../Models/Transaction.dart';
import 'package:intl/intl.dart';

class UserTransactions extends StatelessWidget {
  final List<Transaction> txs;

  const UserTransactions({
    required this.txs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.5,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
              child: Column(children: [
            Container(
                // color: Colors.amber[700],
                color: Colors.blue[900],
                height: 55.4,
                margin: EdgeInsets.all(3),
                child: Card(
                  color: Colors.blue[600],
                  // color: Colors.amber[700],
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          txs[index].currancy +
                              ' ' +
                              txs[index].price.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                txs[index].title,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                DateFormat.yMMMd().format(txs[index].date),
                                style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        )
                      ]),
                ))
          ]));
        },
        itemCount: txs.length,
      ),
    );
  }
}
