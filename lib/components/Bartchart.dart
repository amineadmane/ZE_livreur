import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      AnimatedPositioned(
        // use top,bottom,left and right property to set the location and Transform.rotate to rotate the widget if needed
        child: Text(
          "",
          style: TextStyle(
              fontSize: ResponsiveFlutter.of(context).fontSize(2),
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        duration: Duration(seconds: 2),
      ),
      new charts.BarChart(
        seriesList,
        animate: true,
        animationDuration: Duration(seconds: 3),
      ),
    ]);
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;
  OrdinalSales(this.year, this.sales);
}
