/**
 * widget used to show the user 
 * transactions and to make it scrollable 
 * 
 * @author Abdelaziz Salah
 */
import 'package:flutter/material.dart';
import '../Models/Transaction.dart';
import 'package:intl/intl.dart';

class UserTransactions extends StatelessWidget {
  final List<Transaction> txs;
  final deleteTransaction;

  const UserTransactions({
    required this.txs,
    required this.deleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.57,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
              color: Colors.blueGrey[100],
              child: Column(children: [
                Container(
                    // color: Colors.amber[700],
                    color: Colors.blue[900],
                    height: 68,
                    margin: EdgeInsets.all(3),
                    child: Card(
                      color: Colors.blue[600],
                      // color: Colors.amber[700],
                      child: Row(children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              txs[index].currancy +
                                  ' ' +
                                  txs[index].price.toStringAsFixed(2),
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: FittedBox(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    txs[index].title,
                                    style: TextStyle(
                                        fontFamily: 'DancingScript',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    DateFormat.yMMMd().format(txs[index].date),
                                    style: TextStyle(
                                        fontFamily: 'DancingScript',
                                        decoration: TextDecoration.underline,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                              color: Theme.of(context).errorColor,
                              onPressed: () => deleteTransaction(txs[index]),
                              icon: Icon(Icons.delete_sweep_outlined)),
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
