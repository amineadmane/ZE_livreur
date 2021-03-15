import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ze_livreur/components/curved_nav_bar.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/screens/views/ratingscreen.dart';

import '../homescreen.dart';
import 'Historique.dart';
import 'Profile/Parrainage.dart';
import 'financesscreen.dart';
class ContainerScreen extends StatefulWidget {
  @override
  _ContainerScreenState createState() => _ContainerScreenState();
}

var currentTab = [
  Parrainage(),
  HistoriquePage(),
  HomeScreen(),
  Financespage(),
  RatingsPage(),
];

class _ContainerScreenState extends State<ContainerScreen> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    return Scaffold(
        bottomNavigationBar: BottomNavBar(),
      body: currentTab[provider.getpage],
    );
  }
}
