import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:ze_livreur/components/Bartchart.dart';
import 'package:ze_livreur/components/curved_nav_bar.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts hide Color , TextStyle;
import 'package:ze_livreur/components/header.dart';
import 'package:ze_livreur/models/Metric.dart';
import 'package:ze_livreur/services/ApiCalls.dart';

class Financespage extends StatefulWidget {
  @override
  _FinancespageState createState() => _FinancespageState();
}

class _FinancespageState extends State<Financespage> {
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF25E879);
  Color darkgreen = Color(0xFF147406);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);
  bool status = false;
  Future<Metric> _metric;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _metric = ApiCalls().getmetric(2);
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double screenheight = size.height;
    double screenwidth = size.width;
    return SafeArea(
      child: FutureBuilder(
        future: _metric,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return  Scaffold(
              backgroundColor: background,
              body: Column(
                children:<Widget> [
                  Header(),
                  SizedBox(height : MediaQuery.of(context).size.height* 0.02),
                  Center(
                    child: Text("Evolution des benefices par mois",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.5),color: Colors.black , fontWeight: FontWeight.bold),),
                  ),
                  Container(
                      height: screenheight*0.4,
                      child: SimpleBarChart(_createSampleData(snapshot.data))),
                  SizedBox(height : MediaQuery.of(context).size.height* 0.02),
                  Center(
                    child: Text("statistiques mensuels",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.5),color: Colors.black , fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height : MediaQuery.of(context).size.height* 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child : Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(color: violet),
                              ]),
                          child: Column(
                            children: [
                              SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                              Text(
                                "Chiffres d'affaires",
                                style: TextStyle(color: violet, fontSize: ResponsiveFlutter.of(context).fontSize(2)),
                              ),
                              SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                              Text(
                                snapshot.data.cAMensuel.toString(),
                                style: TextStyle(color: violet, fontSize: ResponsiveFlutter.of(context).fontSize(3) , fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "+" + snapshot.data.cAToday.toString(),
                                    style: TextStyle(color: darkgreen, fontSize: ResponsiveFlutter.of(context).fontSize(2.5) , fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width : MediaQuery.of(context).size.height* 0.01),
                                  Text(
                                    "Auj",
                                    style: TextStyle(color: violet, fontSize: ResponsiveFlutter.of(context).fontSize(2)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(color: violet),
                                ]),
                            child: Column(
                              children: [
                                SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                                Text(
                                  "Benefices",
                                  style: TextStyle(color: violet, fontSize: ResponsiveFlutter.of(context).fontSize(2)),
                                ),
                                SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                                Text(
                                  snapshot.data.benificeMensuel.toString(),
                                  style: TextStyle(color: violet, fontSize: ResponsiveFlutter.of(context).fontSize(3) , fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "+" +snapshot.data.benificeToday.toString(),
                                        style: TextStyle(color: darkgreen, fontSize: ResponsiveFlutter.of(context).fontSize(2.5) , fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width : MediaQuery.of(context).size.height* 0.01),
                                      Text(
                                        "Auj",
                                        style: TextStyle(color: violet, fontSize: ResponsiveFlutter.of(context).fontSize(2)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }else if (snapshot.hasError) {
            return Text("Erreur");
          }
          return Center(child: CircularProgressIndicator());
        }
      ),
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData(Metric metric) {
    int getpreviousmonth(int month,int id){
      int _month = month;
      _month = _month-id;
      if(_month <= 0)
        {
          _month = _month + 12;
        }
      return _month;
    }
    var now = new DateTime.now();
    var current_mon = now.month;
    print(current_mon);
    var currentmonth = DateTime.now().month;
    String getmonth(int month)
    {
      if(month == 1) return "Jan";
      if(month == 2) return "Fev";
      if(month == 3) return "Mar";
      if(month == 4) return "Avr";
      if(month == 5) return "May";
      if(month == 6) return "Juin";
      if(month == 7) return "Jui";
      if(month == 8) return "Aou";
      if(month == 9) return "Sep";
      if(month == 10) return "Oct";
      if(month == 11) return "Nov";
      if(month == 12) return "Dec";

    }
    final data = [
      new OrdinalSales(getmonth(getpreviousmonth(currentmonth,5)), metric.benificeMois5),
      new OrdinalSales(getmonth(getpreviousmonth(currentmonth,4)), metric.benificeMois4),
      new OrdinalSales(getmonth(getpreviousmonth(currentmonth,3)), metric.benificeMois3),
      new OrdinalSales(getmonth(getpreviousmonth(currentmonth,2)), metric.benificeMois2),
      new OrdinalSales(getmonth(getpreviousmonth(currentmonth,1)), metric.benificeMois1),
      new OrdinalSales(getmonth(getpreviousmonth(currentmonth,0)), metric.benificeMensuel)
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Benefices',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.month,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

}
