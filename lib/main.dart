import 'package:flutter/material.dart';
import 'package:ze_livreur/components/curved_nav_bar.dart';

void main() {
  runApp(ze_livreur());
}

// ignore: camel_case_types
class ze_livreur extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        '/': (context) => BottomNavBar(),
      },
    );
  }
}
