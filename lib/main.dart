import 'package:flutter/material.dart';
import './Models/Transaction.dart';
import './Widgets/Chart.dart';
import './Widgets/Inputs.dart';
import './Widgets/userTransactions.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColorDark: Color.fromARGB(255, 72, 122, 148),
          splashColor: Colors.blueGrey,
          fontFamily: ' '),
      home: PersonalExpanses(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PersonalExpanses extends StatefulWidget {
  @override
  State<PersonalExpanses> createState() => _PersonalExpansesState();
}

class _PersonalExpansesState extends State<PersonalExpanses> {
  List<Transaction> txs = [
    Transaction("PlayStation5", "\$", 200, DateTime.now()),
    Transaction("I Pad", "\$", 421.43, DateTime.now()),
    Transaction("Rolex", "\$", 421.43, DateTime.now()),
    Transaction("I Phone", "\$", 421.43, DateTime.now()),
    Transaction("Ice watch", "\$", 421.43, DateTime.now()),
  ];

  String titleInput = "";
  String currancyInput = "";
  double priceInput = 0.0;
  DateTime dateInput = DateTime(2022);
  TextEditingController priceController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  void addElement() {
    // input validations
    if (titleController.text == "" ||
        priceController.text == "" ||
        double.parse(priceController.text) <= 0.0 ||
        dateInput == DateTime(2022)) {
      return;
    }

    Transaction tx = Transaction(titleController.text, "\$",
        double.parse(priceController.text), dateInput);
    setState(() {
      txs.add(tx);
    });
    clearInputs();
    Navigator.of(context).pop();
  }

  void deleteTransaction(Transaction tx) {
    setState(() {
      txs.remove(tx);
    });
  }

  void clearListElement() {
    setState(() {
      txs.clear();
    });
  }

  void clearInputs() {
    Navigator.of(context).pop();
    setState(() {
      titleController.text = "";
      priceController.text = "";
      dateInput = DateTime(2022);
    });
    _showEntryWidget(context);
  }

  void pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) return;
      Navigator.of(context).pop();
      _showEntryWidget(context);
      dateInput = date;
    });
  }

  void _showEntryWidget(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,

        /// this builder should takes context as a parameter for it but i won't
        /// use it now so we can just accept _ which means that we don't care
        /// about the thing that this function takes
        builder: ((_) {
          return GestureDetector(
            child: Inputs(
              priceController: priceController,
              titleController: titleController,
              pickDate: pickDate,
              clearEntries: clearInputs,
              addElement: addElement,
              date: dateInput,
            ),
          );
        }));
  }

  /// i want to make a function that returns a list of only the transactions
  /// happend in the last week only
  List<Transaction> get _recentTransactions {
    var newTxs = txs.where((tx) {
      /// bgeb el w2t delw2ty w atr7 meno duration bl days w el duration
      /// de hya 7 ayam 34an a8ty el esbo3 kolo
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
    // txs = newTxs;

    /// to always remove the old transactions
    return newTxs;
  }

  @override
  Widget build(BuildContext context) {
    // print(_recentTransactions);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showEntryWidget(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: clearListElement,
            icon: Icon(
              Icons.cleaning_services,
              semanticLabel: "Clear all transactions",
            ),
          )
        ],
        centerTitle: true,
        title: Text(
          "Personal Expanses",
          style: TextStyle(
            fontFamily: 'Quicksand',
            shadows: [
              Shadow(
                  blurRadius: 60, color: Colors.white, offset: Offset(10, 10))
            ],
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: txs.isEmpty
          ? Container(
              color: Color.fromARGB(255, 202, 202, 202),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "No transactions yet :(",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        shadows: [
                          Shadow(blurRadius: 100, color: Colors.white)
                        ]),
                  ),
                  Container(
                    height: 600,
                    width: 400,
                    child: Image.asset(
                      "assets/imgs/waiting.png",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              height: 700,
              width: 400,
              // color: Colors.blueGrey,
              color: Theme.of(context).splashColor,
              // in order to avoid the overflow make the main page as listview
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        /// the chart card
                        Charts(_recentTransactions),

                        ///the transactions card
                        UserTransactions(
                          txs: txs,
                          deleteTransaction: deleteTransaction,
                        )
                      ]);
                },
                itemCount: 1,
              ),
            ),
    );
  }
}
