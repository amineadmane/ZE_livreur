import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/screens/homescreen.dart';
import 'package:ze_livreur/screens/views/Historique/Historique.dart';
import 'package:ze_livreur/screens/views/Inscription_login/login.dart';
import 'package:ze_livreur/screens/views/Parrainage.dart';
import 'package:ze_livreur/screens/views/financesscreen.dart';
import 'package:ze_livreur/screens/views/ratingscreen.dart';
import 'package:ze_livreur/screens/views/infovehicule.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ze_livreur/screens/views/ratingscreen.dart';

import 'components/curved_nav_bar.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Auth())],
      child: ze_livreur()));
}

// ignore: camel_case_types
class ze_livreur extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NavigationProvider>(
        create: (_) => NavigationProvider(), child: Navigation());
  }
}

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

var currentTab = [
  ParrainageScreen(),
  HistoriquePage(),
  HomeScreen(),
  FinancesPage(),
  RatingsPage(),
];

class _NavigationState extends State<Navigation> {
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    readToken();
    super.initState();
  }

  Future<void> readToken() async {
    String token = await storage.read(key: "token");
    await Provider.of<Auth>(context, listen: false).tryToken(token);
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);

    return MaterialApp(
      home: Scaffold(
        body: Consumer<Auth>(
          builder: (context, auth, child) {
            if (!auth.authenticated) {
              return LoginScreen();
            } else {
              return currentTab[provider.getpage];
            }
          },
        ),
      ),
    );
  }
}
