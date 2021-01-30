import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/screens/homescreen.dart';
import 'package:ze_livreur/screens/views/historyscreen.dart';
import 'package:ze_livreur/screens/views/login.dart';
import 'package:ze_livreur/screens/views/confirmedphone.dart';
void main() {
  runApp(ze_livreur());
}

// ignore: camel_case_types
class ze_livreur extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<NavigationProvider>(
      create:(_) =>  NavigationProvider(),
        child: Navigation());
  }
}

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  var currentTab = [
    HomeScreen(),
    HistoryPage(),
  ];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    return MaterialApp(
      home: Scaffold(
        body: currentTab[provider.getpage],
      ),
    );
  }
}
