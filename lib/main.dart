import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/provider/request_provider.dart';
import 'package:ze_livreur/screens/homescreen.dart';
import 'package:ze_livreur/screens/views/ContainerScreen.dart';
import 'package:ze_livreur/screens/views/Historique/Historique.dart';
import 'package:ze_livreur/screens/views/Inscription_login/Inscrit.dart';
import 'package:ze_livreur/screens/views/Inscription_login/login.dart';
import 'package:ze_livreur/screens/views/Notification/navigationscreen.dart';
import 'package:ze_livreur/screens/views/Notification/notificationscreen.dart';
import 'package:ze_livreur/screens/views/Profile/Parrainage.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => Auth()),
    ChangeNotifierProvider(create: (context) => RequestProvider())
  ], child: ze_livreur()));
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
    print("token : $token");
  }

  _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      var provider = Provider.of<RequestProvider>(context, listen: false);
      var userprovider = Provider.of<Auth>(context, listen: false);
      print(userprovider.livreurExt.idLivExt);
      if (userprovider.livreurExt.etat == "online" &&
          userprovider.authenticated != "notified" &&
          userprovider.authenticated != "delivring") {
        print("yes");
        provider.changenom(message['data']['nom']);
        provider.changeprenom(message['data']['prenom']);
        provider.changepickup(message['data']['pickup']);
        provider.changedropoff(message['data']['dropoff']);
        provider.changetel(message['data']['tel']);
        provider.changeprix(double.parse(message['data']['prix']));
        Provider.of<Auth>(context, listen: false).changeauth("notified");
      }
    }, onResume: (Map<String, dynamic> message) async {
      var userprovider = Provider.of<Auth>(context, listen: false);
      if (userprovider.livreurExt.etat == "online") {}
      print("Notified");
      var provider = Provider.of<RequestProvider>(context, listen: false);
      print("yes");
      provider.changenom(message['data']['nom']);
      provider.changeprenom(message['data']['prenom']);
      provider.changepickup(message['data']['pickup']);
      provider.changedropoff(message['data']['dropoff']);
      provider.changetel(message['data']['tel']);
      provider.changeprix(double.parse(message['data']['prix']));
      Provider.of<Auth>(context, listen: false).changeauth("notified");
    }, onLaunch: (Map<String, dynamic> message) async {
      print("launche");
    });
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
                  return NavigationPage();
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
