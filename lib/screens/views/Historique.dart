import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ze_livreur/components/header.dart';
import 'package:ze_livreur/models/Historique_annuel.dart';
import 'package:ze_livreur/models/Year.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/services/ApiCalls.dart';
import 'package:provider/provider.dart';

import 'Historique/Historiquedetails.dart';

class HistoriquePage extends StatefulWidget {
  @override
  _HistoriquePageState createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage>
    with TickerProviderStateMixin {
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF25E879);
  Color darkgreen = Color(0xFF147406);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);
  Color orangeclair = Color(0xFFEEA86B);
  bool status = false;
  Future<List<Historique_annuel>> _histo_annuel;

  final int _startingTabCount = 4;

  List<Tab> _tabs = List<Tab>();
  List<Widget> _generalWidgets = List<Widget>();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Tab> getTabs(List<Year> list) {
    _tabs.clear();
    int i = 0;
    while (i < list.length) {
      _tabs.add(getTab(list.elementAt(i).year));
      i++;
    }
    return _tabs;
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this);
  }

  Tab getTab(int widgetNumber) {
    return Tab(
      text: "$widgetNumber",
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenheight = size.height;
    double screenwidth = size.width;
    var provider = Provider.of<Auth>(context, listen: false).livreurExt;
    var providernav = Provider.of<NavigationProvider>(context, listen: false);
    String getmonth(int month) {
      if (month == 1) return "Jan";
      if (month == 2) return "Fev";
      if (month == 3) return "Mar";
      if (month == 4) return "Avr";
      if (month == 5) return "May";
      if (month == 6) return "Juin";
      if (month == 7) return "Jui";
      if (month == 8) return "Aou";
      if (month == 9) return "Sep";
      if (month == 10) return "Oct";
      if (month == 11) return "Nov";
      if (month == 12) return "Dec";
    }

    Widget getWidget(int i) {
      return FutureBuilder(
          future: ApiCalls().gethistoannuel(provider.idLivExt, i),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: screenwidth * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: violet),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16, right: 16, left: 16, top: 16),
                        child: Row(
                          children: [
                            Center(
                              child: SizedBox(
                                child: Container(
                                  width: screenwidth * 0.2,
                                  height: screenheight * 0.1,
                                  decoration: new BoxDecoration(
                                    color: orangeclair,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      getmonth(snapshot.data[index].mois),
                                      style: TextStyle(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(3),
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Nombres de livraisons : ',
                                      style: TextStyle(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2.0),
                                          color: violet),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: snapshot
                                              .data[index].nbLivraisons
                                              .toString(),
                                          style: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2.0),
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Distance parcourue : ',
                                      style: TextStyle(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2.0),
                                          color: violet),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: snapshot
                                              .data[index].distanceTotale
                                              .toString(),
                                          style: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2.0),
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenheight * 0.1,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      providernav.changemonth(snapshot.data[index].mois);
                      print("year : " + i.toString());
                      providernav.changeyear(i);
                      Navigator.push(
                          (context),
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HistoriquePagescreen()));
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("Erreur");
            }
            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          });
    }

    List<Widget> getWidgets(List<Year> list) {
      _generalWidgets.clear();
      for (int i = 0; i < _tabs.length; i++) {
        _generalWidgets.add(getWidget(list.elementAt(i).year));
      }
      return _generalWidgets;
    }

    return SafeArea(
      child: FutureBuilder(
          future: ApiCalls().getyears(provider.idLivExt),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _tabs = getTabs(snapshot.data);
              _tabController = getTabController();
              return Scaffold(
                backgroundColor: background,
                body: Column(
                  children: <Widget>[
                    Header(),
                    Flexible(
                      child: Scaffold(
                        body: DefaultTabController(
                          length: 3,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Material(
                                  color: background,
                                  child: TabBar(
                                      labelColor: orange,
                                      indicatorColor: orange,
                                      unselectedLabelColor: Colors.black,
                                      labelStyle: TextStyle(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(3),
                                          fontWeight: FontWeight
                                              .bold), //For Selected tab
                                      unselectedLabelStyle: TextStyle(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(1.57),
                                          fontWeight: FontWeight.bold),
                                      tabs: _tabs,
                                      controller: _tabController),
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: _tabController,
                                  children: getWidgets(snapshot.data),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Text("Erreur");
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
