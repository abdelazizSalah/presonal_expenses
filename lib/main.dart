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
          fontFamily: 'DancingScript'),
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
    // Transaction("Laptop Acer", "EGP ", 39043.99, DateTime.now()),
    // Transaction("Rolex Watch", "Euro ", 4500, DateTime.now()),
    // Transaction("I Pad", "\$", 421.43, DateTime.now()),
    // Transaction("Laptop Acer", "EGP ", 39043.99, DateTime.now()),
    // Transaction("Rolex Watch", "Euro ", 4500, DateTime.now()),
    // Transaction("I Pad", "\$", 421.43, DateTime.now()),
    // Transaction("Laptop Acer", "EGP ", 39043.99, DateTime.now()),
    // Transaction("Rolex Watch", "Euro ", 4500, DateTime.now()),
    // Transaction("I Pad", "\$", 421.43, DateTime.now()),
    // Transaction("Laptop Acer", "EGP ", 39043.99, DateTime.now()),
    // Transaction("Rolex Watch", "Euro ", 4500, DateTime.now()),
    // Transaction("I Pad", "\$", 421.43, DateTime.now()),
  ];

  String titleInput = "no item";
  String currancyInput = "";
  double priceInput = 0.0;
  DateTime dateInput = DateTime.now();
  TextEditingController priceController = TextEditingController();
  TextEditingController currancyController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  void setTitle(String inp) {
    titleInput = inp;
  }

  void setCurrnacy(String inp) {
    currancyInput = inp;
  }

  void setPrice(String inp) {
    priceInput = double.parse(inp);
  }

  void setDate(String inp) {
    dateInput = DateTime.now();
  }

  void addElement() {
    // input validations
    if (titleInput == "no item" ||
        currancyInput == "" ||
        double.parse(priceController.text) <= 0.0) {
      return;
    }

    Transaction tx = Transaction(titleInput, currancyInput,
        double.parse(priceController.text), dateInput);
    setState(() {
      txs.add(tx);
    });

    Navigator.of(context).pop();
  }

  void clearListElement() {
    setState(() {
      txs.clear();
    });
  }

  // void clearTransactions() {
  //   setState(() {
  //     txs.clear();
  //   });
  // }

  void showEntryWidget(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,

        /// this builder should takes context as a parameter for it but i won't
        /// use it now so we can just accept _ which means that we don't care
        /// about the thing that this function takes
        builder: ((_) {
          return GestureDetector(
            child: Inputs(
                clearElements: clearListElement,
                priceController: priceController,
                setCurrnacy: setCurrnacy,
                addElement: addElement,
                setDate: setDate,
                setPrice: setPrice,
                setTitle: setTitle),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showEntryWidget(context);
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
            shadows: [
              Shadow(
                  blurRadius: 30, color: Colors.white, offset: Offset(10, 10))
            ],
            fontSize: 30,
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
                        color: Colors.white,
                        fontSize: 22.5,
                        shadows: [Shadow(blurRadius: 15, color: Colors.black)]),
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
              height: double.infinity,
              width: double.infinity,
              // color: Colors.blueGrey,
              color: Theme.of(context).splashColor,
              // in order to avoid the overflow make the main page as listview
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(children: [
                    /// the chart card
                    Charts(),

                    /// responsive widget for transactions
                    /// inputs card
                    // height: 625,

                    ///the transactions card
                    UserTransactions(txs: txs)
                  ]);
                },
                itemCount: 1,
              ),
            ),
    );
  }
}
