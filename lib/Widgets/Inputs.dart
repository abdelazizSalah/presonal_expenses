import 'package:flutter/material.dart';

class Inputs extends StatelessWidget {
  final setTitle;
  final setDate;
  final setPrice;
  final setCurrnacy;
  final addElement;

  Inputs({
    required this.setCurrnacy,
    required this.addElement,
    required this.setDate,
    required this.setPrice,
    required this.setTitle,
  });

  @override
  Widget build(BuildContext context) {
    /// the textFields card
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(labelText: "Title"),
            onChanged: setTitle,
          ),
          TextField(
            decoration: InputDecoration(labelText: "currancy"),
            onChanged: setCurrnacy,
          ),
          TextField(
            decoration: InputDecoration(labelText: "Price"),
            onSubmitted: setPrice,
          ),
          // TextField(
          //   decoration: InputDecoration(labelText: "Date"),
          //   onChanged: setDate,
          // ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: addElement,
              child: Text("Add"),
            ),
          ),
        ]),
      ),
    );
  }
}
