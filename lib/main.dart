import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/screens/homescreen.dart';
import 'package:ze_livreur/screens/views/ContainerScreen.dart';
import 'package:ze_livreur/screens/views/Historique/Historique.dart';
import 'package:ze_livreur/screens/views/Inscription_login/Inscrit.dart';
import 'package:ze_livreur/screens/views/Inscription_login/login.dart';
import 'package:ze_livreur/screens/views/Notification/navigationscreen.dart';
import 'package:ze_livreur/screens/views/Notification/notificationscreen.dart';
import 'package:ze_livreur/screens/views/Parrainage.dart';
import 'package:ze_livreur/screens/views/financesscreen.dart';
import 'package:ze_livreur/screens/views/ratingscreen.dart';

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
  Financespage(),
  RatingsPage(),
];

class _NavigationState extends State<Navigation> {
  final storage = new FlutterSecureStorage();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    readToken();
    _registerOnFirebase();
    getMessage();
    super.initState();
  }

  Future<void> readToken() async {
    String token = await storage.read(key: "token");
    await Provider.of<Auth>(context, listen: false).tryToken(token);
    print(token);
  }

  _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {},
        onResume: (Map<String, dynamic> message) async {},
        onLaunch: (Map<String, dynamic> message) async {});
  }

  @override
  Widget build(context) {
    var provider = Provider.of<NavigationProvider>(context);

    return MaterialApp(
      home: Scaffold(
        body: Consumer<Auth>(
          builder: (context, auth, child) {
            switch (auth.authenticated) {
              case "loggedin":
                {
                  return ContainerScreen();
                }
                break;
              case "loggedout":
                {
                  return LoginScreen();
                }
                break;
              case "blocked":
                {
                  return Inscrit();
                }
                break;
              case "notified":
                {
                  return NotificationPage();
                }
                break;
              case "delivring":
                {
                  NavigationPage();
                }
                break;
            }
            return null;
          },
        ),
      ),
    );
  }
}
