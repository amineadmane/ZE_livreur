import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:ze_livreur/components/Bartchart.dart';
import 'package:ze_livreur/components/curved_nav_bar.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts hide Color , TextStyle;

class FinancesPage extends StatelessWidget {
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF25E879);
  Color darkgreen = Color(0xFF147406);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);
  bool status = false;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double screenheight = size.height;
    double screenwidth = size.width;
    return SafeArea(
        child: Scaffold(
          backgroundColor: background,
          bottomNavigationBar: BottomNavBar(),
          body: Column(
            children:<Widget> [
            Container(
             color: orange,
             height: screenheight * 0.2,
             child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_pin,
                      color: background,
                      size: 45,
                    ),
                    SizedBox(
                      width: screenwidth * 0.3,
                    ),
                    FlutterSwitch(
                        value: status,
                        width: 60,
                        height: 25,
                        valueFontSize: 12.0,
                        toggleSize: screenheight * 0.025,
                        borderRadius: 30.0,
                        padding: 4.0,
                        showOnOff: true,
                        activeText: "ON",
                        inactiveText: "OFF",
                        activeColor: green,
                        inactiveTextColor: violet,
                        inactiveColor: background,
                        onToggle: (val) {

                        })
                  ],
                ),
                Text(
                  "Finances",
                  style: TextStyle(
                    color: background,
                    fontSize: 50,
                    fontFamily: 'Mom cake',
                  ),
                )
              ],
            ),
          ),
              SizedBox(height : MediaQuery.of(context).size.height* 0.02),
            Center(
             child: Text("Evolution des benefices par mois",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.5),color: Colors.black , fontWeight: FontWeight.bold),),
          ),
              Container(
                  height: screenheight*0.4,
                  child: SimpleBarChart(_createSampleData())),
              SizedBox(height : MediaQuery.of(context).size.height* 0.02),
              Center(
                child: Text("statistiques générales",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.5),color: Colors.black , fontWeight: FontWeight.bold),),
              ),
              SizedBox(height : MediaQuery.of(context).size.height* 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: violet),
                        ]),
                    child: Column(
                      children: [
                        Text(
                          "Chiffres d'affaires",
                          style: TextStyle(color: violet, fontSize: ResponsiveFlutter.of(context).fontSize(2)),
                        ),
                        SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                        Text(
                          "10551 DA",
                          style: TextStyle(color: violet, fontSize: ResponsiveFlutter.of(context).fontSize(3) , fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                        Row(
                          children: [
                            Text(
                              "+654 DA",
                              style: TextStyle(color: darkgreen, fontSize: ResponsiveFlutter.of(context).fontSize(3) , fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width : MediaQuery.of(context).size.height* 0.01),
                            Text(
                              "Aujourd'hui",
                              style: TextStyle(color: violet, fontSize: ResponsiveFlutter.of(context).fontSize(2)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: violet),
                        ]),
                    child: Column(
                      children: [
                        Text(
                          "Benefices",
                          style: TextStyle(color: violet, fontSize: ResponsiveFlutter.of(context).fontSize(2)),
                        ),
                        SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                        Text(
                          "5600 DA",
                          style: TextStyle(color: violet, fontSize: ResponsiveFlutter.of(context).fontSize(3) , fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0 , right: 4.0),
                          child: Row(
                            children: [
                              Text(
                                "+400 DA",
                                style: TextStyle(color: darkgreen, fontSize: ResponsiveFlutter.of(context).fontSize(3) , fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width : MediaQuery.of(context).size.height* 0.01),
                              Text(
                                "Aujourd'hui",
                                style: TextStyle(color: violet, fontSize: ResponsiveFlutter.of(context).fontSize(2)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
        ),
      ),
    );
  }
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 45),
      new OrdinalSales('2017', 75),
      new OrdinalSales('2018', 25),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Benefices',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}
