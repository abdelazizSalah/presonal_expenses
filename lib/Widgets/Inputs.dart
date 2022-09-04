import 'package:flutter/material.dart';

class Inputs extends StatelessWidget {
  final setTitle;
  final setDate;
  final setPrice;
  final setCurrnacy;
  final addElement;
  final clearElements;
  final priceController;
  Inputs({
    required this.priceController,
    required this.setCurrnacy,
    required this.clearElements,
    required this.addElement,
    required this.setDate,
    required this.setPrice,
    required this.setTitle,
  });
  void addOnSubmit(String s) {
    addElement();
  }

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
              // this means that we take some parameters which we don't use
              onSubmitted: addOnSubmit),

          TextField(
              keyboardType: TextInputType.number,
              controller: priceController,
              decoration: InputDecoration(labelText: "Price"),

              /// we can use this way or the (_) {addElement();} way
              onSubmitted: addOnSubmit),
          TextField(
              // this type is to make the input is only number
              decoration: InputDecoration(labelText: "currancy"),
              onChanged: setCurrnacy,
              onSubmitted: (_) {
                addElement();
              }),
          // TextField(
          //   decoration: InputDecoration(labelText: "Date"),
          //   onChanged: setDate,
          // ),
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
                        onPressed: clearElements,
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
