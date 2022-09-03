import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Transaction.dart';

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
  List<Transaction> txs = [
    Transaction("PlayStation5", "\$", 200, DateTime.now()),
    Transaction("Laptop Acer", "EGP ", 39043.99, DateTime.now()),
    Transaction("Rolex Watch", "Euro ", 4500, DateTime.now()),
    Transaction("I Pad", "\$", 421.43, DateTime.now()),
  ];

  String titleInput = "no item";
  String currancyInput = "\$";
  double priceInput = 0.0;
  DateTime dateInput = DateTime.now();

  void setTitle(String inp) {
    titleInput = inp;
    print(titleInput);
  }

  void setCurrnacy(String inp) {
    currancyInput = inp;
    print(currancyInput);
  }

  void setPrice(String inp) {
    priceInput = double.parse(inp);
    print(priceInput);
  }

  void setDate(String inp) {
    dateInput = DateTime.now();
    print(DateFormat.yMMMd().format(dateInput));
  }

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
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10),
            child: Card(
              child: Text("My Chart!"),
            ),
          ),

          /// the textFields card
          Card(
            child: Column(children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                onSubmitted: setTitle,
              ),
              TextField(
                decoration: InputDecoration(labelText: "currancy"),
                onSubmitted: setCurrnacy,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Price"),
                onSubmitted: setPrice,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Date"),
                onSubmitted: setDate,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Add"),
              ),
            ]),
          ),

          ///the transactions card
          Card(
            child: Column(children: [
              ...(txs as List<Transaction>).map((trans) {
                return Container(
                  height: 50,
                  margin: EdgeInsets.all(3),
                  child: Card(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            trans.currancy + trans.price.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                trans.title,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                DateFormat.yMMMd().format(trans.date),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ]),
                  ),
                );
              }).toList()
            ]),
          ),
        ]),
      ),
    );
  }
}
