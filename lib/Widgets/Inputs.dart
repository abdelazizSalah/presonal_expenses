/**
 * utility widget used to allow the user to insert new transaction by providing 
 * some textfields and buttons
 * 
 * @author Abdelaziz Salah
 * 
 */
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Inputs extends StatelessWidget {
  /// utility variables
  final priceController;
  final titleController;
  final addElement;
  final clearEntries;
  final pickDate;
  final date;
  Inputs({
    required this.priceController,
    required this.titleController,
    required this.pickDate,
    required this.date,
    required this.clearEntries,
    required this.addElement,
  });

  /// utility function to be able to call add element
  /// using the anonymous function
  void addOnSubmit(String s) {
    addElement();
  }

  @override
  Widget build(BuildContext context) {
    /// the textFields card
    return Card(
      /// to give some spacing so i used padding
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              // this means that we take some parameters which we don't use
              onSubmitted: addOnSubmit),
          TextField(
              keyboardType: TextInputType.number,
              controller: priceController,
              decoration: InputDecoration(labelText: "Price"),

              /// we can use this way or the (_) {addElement();} way
              onSubmitted: addOnSubmit),
          Row(
            children: [
              Text(date == DateTime(2022)
                  ? "No Date Picked Yet"
                  : DateFormat.yMMMd().format(date)),
              TextButton(onPressed: pickDate, child: Text("Pick a Date"))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: addElement,
                    child: Text("Add",
                        style: TextStyle(fontSize: 18, shadows: [
                          Shadow(blurRadius: 100, color: Colors.white)
                        ])),
                  ),
                ),
                Container(
                    width: 100,
                    child: ElevatedButton(
                        onPressed: clearEntries,
                        child: Text("Clear",
                            style: TextStyle(fontSize: 18, shadows: [
                              Shadow(blurRadius: 100, color: Colors.white)
                            ]))))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
