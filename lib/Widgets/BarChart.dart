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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /// fitted box to force the content in the available space
        FittedBox(
            child: Text(
          /// rounding the cents up
          "\$${price.toStringAsFixed(0)}",
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16.5,
              color: Colors.black87,
              shadows: [Shadow(blurRadius: 100, color: Colors.black)]),
        )),
        Container(
          height: 80,
          width: 15,

          /// stack to create the barchart
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColorDark, width: 2.0),
                  borderRadius: BorderRadius.circular(10)),
            ),

            /// used only for spacing
            SizedBox(
              height: 4,
            ),

            /// used to make the content relative to the parent
            FractionallySizedBox(
              heightFactor: percentageOfTotalSpending,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    border: Border.all(
                        color: Theme.of(context).primaryColorDark, width: 3.0),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(
              height: 4,
            ),
          ]),
        ),
        Text(
          label,
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
              color: Colors.black,
              shadows: [Shadow(blurRadius: 100)]),
        )
      ],
    );
  }
}
