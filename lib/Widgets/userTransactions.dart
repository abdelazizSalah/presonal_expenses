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
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
              color: Colors.blueGrey[100],
              child: Column(children: [
                Container(
                    color: Colors.blue[900],
                    height: 68,
                    margin: EdgeInsets.all(3),
                    child: Card(
                      color: Colors.blue[600],
                      child: Row(children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              txs[index].currancy +
                                  ' ' +
                                  txs[index].price.toStringAsFixed(2),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
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
                          child: MediaQuery.of(context).size.width > 400
                              ? TextButton.icon(
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStatePropertyAll(
                                    Theme.of(context).errorColor,
                                  )),
                                  onPressed: () =>
                                      deleteTransaction(txs[index]),
                                  icon: Icon(Icons.delete_sweep_outlined),
                                  label: Text(
                                    'delete',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))
                              : IconButton(
                                  color: Theme.of(context).errorColor,
                                  onPressed: () =>
                                      deleteTransaction(txs[index]),
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
