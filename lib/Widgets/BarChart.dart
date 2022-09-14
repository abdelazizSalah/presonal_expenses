/**
 * Widget used to create a bar chart and to show the total amonut spent on 
 * each different day
 * 
 * @author Abdelaziz Salah 
 */
import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final String label;
  final double price;
  final double percentageOfTotalSpending;

  const BarChart({
    required this.label,
    required this.price,
    required this.percentageOfTotalSpending,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constranis) {
      return Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// fitted box to force the content in the available space
          FittedBox(
              child: Container(
            height: constranis.maxHeight * 0.15,
            child: Text(
              /// rounding the cents up
              "\$${price.toStringAsFixed(0)}",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16.5,
                  color: Colors.black87,
                  shadows: [Shadow(blurRadius: 100, color: Colors.black)]),
            ),
          )),
          Container(
            height: constranis.maxHeight * 0.65,
            width: 12,
            // width: constranis.maxWidth * ,

            /// stack to create the barchart
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    border: Border.all(
                        color: Theme.of(context).primaryColorDark, width: 3.0),
                    borderRadius: BorderRadius.circular(10)),
              ),

              /// used only for spacing
              SizedBox(
                height: constranis.maxHeight * 0.05,
              ),

              /// used to make the content relative to the parent
              FractionallySizedBox(
                heightFactor: 1 - percentageOfTotalSpending,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).splashColor,
                      border: Border.all(
                          color: Theme.of(context).primaryColorDark,
                          width: 4.0),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: constranis.maxHeight * 0.05,
              ),
            ]),
          ),
          Container(
            height: constranis.maxHeight * 0.10,
            child: FittedBox(
              child: Text(
                label,
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14,
                    color: Colors.black,
                    shadows: [Shadow(blurRadius: 100)]),
              ),
            ),
          )
        ],
      );
      ;
    });
  }
}
