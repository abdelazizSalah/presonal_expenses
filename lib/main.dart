import 'package:flutter/material.dart';
import './Models/Transaction.dart';
import './Widgets/Chart.dart';
import './Widgets/Inputs.dart';
import './Widgets/userTransactions.dart';

/// the main function which is the entry point to our program
void main() {
  runApp(MainPage());
}

/// Mainpage wigdet which contains the root of the application -> material app
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// theme for the whole program
      theme: ThemeData(
          textTheme: TextTheme(
              titleLarge: TextStyle(
                  fontSize: 20 * MediaQuery.textScaleFactorOf(context))),
          primaryColorDark: Color.fromARGB(255, 72, 122, 148),

          /// the primary color with all its accent values
          splashColor: Colors.blueGrey,
          fontFamily: 'OpenSans'),
      home: PersonalExpanses(),

      /// to remove the debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}

/// the root widget for the stateful widgets
class PersonalExpanses extends StatefulWidget {
  @override
  State<PersonalExpanses> createState() => _PersonalExpansesState();
}

class _PersonalExpansesState extends State<PersonalExpanses> {
  /// our list of transactions
  List<Transaction> txs = [
    Transaction("PlayStation5", "\$", 200, DateTime.now()),
    Transaction("I Pad", "\$", 421.43, DateTime.now()),
    Transaction("Rolex", "\$", 421.43, DateTime.now()),
    Transaction("I Phone", "\$", 421.43, DateTime.now()),
    Transaction("Ice watch", "\$", 421.43, DateTime.now()),
  ];

  /// utility variables used to get the data from the user
  DateTime dateInput = DateTime(2022);
  TextEditingController priceController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  /// utility function used to add new transaction to the user list
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

    /// function which is used to render the build widget to show the changes
    setState(() {
      txs.add(tx);
    });

    /// clear the input fields to be used in the new transactions
    clearInputs();

    /// poping down the model bottom sheet
    Navigator.of(context).pop();
  }

  /// utility function used to delete certain transaction
  void deleteTransaction(Transaction tx) {
    setState(() {
      txs.remove(tx);
    });
  }

  /// utility function used to clear the whole transactions
  void clearListElement() {
    setState(() {
      txs.clear();
    });
  }

  /// utility function used to clear the inputs when the user add new transaction
  void clearInputs() {
    Navigator.of(context).pop();
    setState(() {
      titleController.text = "";
      priceController.text = "";
      dateInput = DateTime(2022);
    });
    _showEntryWidget(context);
  }

  /// utility function used to show the date picker to allow the user choose
  /// new date for his items
  void pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((date) {
      /// if the  user pressed cancel
      if (date == null) return;
      Navigator.of(context).pop();
      _showEntryWidget(context);
      dateInput = date;
    });
  }

  ///utility function used to show the inputs for the user when he press
  ///on the floating adding button
  void _showEntryWidget(BuildContext ctx) {
    ///built in function in flutter used to show a sheet from the bottom
    ///we insert in it our needed widgets which here is inputs widget
    showModalBottomSheet(

        /// usually the conent text of the main widget -> we can use the global
        /// context instead but i have used ctx here for learning diffrent methods
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
      /// get the date now and subtracting 7 days from them to cover one week
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();

    /// to always remove the old transactions
    return newTxs;
  }

  /// I have extracted  the appBar to be able to access
  ///  its properties as height and width and so on
  final appBarWidget = AppBar(
    actions: [
      /// icon button in the appbar to allow the user to clear all the
      /// transactions on one click
      // IconButton(
      //   onPressed: clearListElement,
      //   icon: Icon(
      //     Icons.cleaning_services,
      //     semanticLabel: "Clear all transactions",
      //   ),
      // )
    ],
    centerTitle: true,
    title: Text(
      "Personal Expanses",
      style: TextStyle(
        fontFamily: 'Quicksand',
        shadows: [
          Shadow(blurRadius: 60, color: Colors.white, offset: Offset(10, 10))
        ],
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        /// button floating to allow the user to add new transaction
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _showEntryWidget(context);
          },
        ),

        ///setting its location
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: appBarWidget,

        /// if the body is empty we show No Transaction view else we show the
        /// transactions list and the chart
        body: txs.isEmpty
            ? Container(
                width: MediaQuery.of(context).size.width,
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
                // height: 700,
                width: MediaQuery.of(context).size.width,
                // color: Colors.blueGrey,
                color: Theme.of(context).splashColor,
                // in order to avoid the overflow make the main page as listview
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// the chart card
                      Container(
                          height: (MediaQuery.of(context).size.height -
                                  appBarWidget.preferredSize.height -
                                  MediaQuery.of(context).padding.top -
                                  MediaQuery.of(context).viewPadding.top) *
                              0.27,
                          child: Charts(_recentTransactions)),

                      ///the transactions card
                      Container(
                        height: (MediaQuery.of(context).size.height -
                                appBarWidget.preferredSize.height -
                                MediaQuery.of(context).padding.top -
                                MediaQuery.of(context).viewPadding.top) *
                            0.7,
                        child: UserTransactions(
                          txs: txs,
                          deleteTransaction: deleteTransaction,
                        ),
                      )
                    ])));
  }
}
