/**
 * utility widget used to allow the user to insert new transaction by providing 
 * some textfields and buttons
 * 
 * @author Abdelaziz Salah
 * 
 */
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final mediaQuery = MediaQuery.of(context);
    final devWidth = mediaQuery.size.width;
    final devHeight = mediaQuery.size.height;
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    /// the textFields card
    return SingleChildScrollView(
      child: Card(
        /// to give some spacing so i used padding
        child: Container(
          padding: EdgeInsets.only(
              top: 8,
              left: 8,
              right: 8,
              bottom: mediaQuery.viewInsets.bottom + 10),
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
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  date == DateTime(2022)
                      ? "No Date Picked Yet"
                      : DateFormat.yMMMd().format(date),
                  style: TextStyle(color: Theme.of(context).splashColor),
                ),
                TextButton(
                    onPressed: pickDate,
                    child: Text("Pick a Date",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 18))),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: isPortrait == true ? 30 : 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    /// Button Container
                    width: devWidth * 0.25,
                    child: ElevatedButton(
                      onPressed: addElement,
                      child: Text("Add",
                          style: TextStyle(fontSize: 18, shadows: [
                            Shadow(blurRadius: 100, color: Colors.white)
                          ])),
                    ),
                  ),
                  Container(

                      /// The Second Button Container
                      width: devWidth * 0.25,
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
      ),
    );
  }
}
