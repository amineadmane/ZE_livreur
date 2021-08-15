import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:ze_livreur/globalvariabels.dart';
import 'package:ze_livreur/provider/InscriptionProvider.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/provider/request_provider.dart';
import 'package:ze_livreur/screens/views/ContainerScreen.dart';
import 'package:ze_livreur/screens/views/Inscription_login/Inscrit.dart';
import 'package:ze_livreur/screens/views/Inscription_login/login.dart';
import 'package:ze_livreur/screens/views/Notification/navigationscreen.dart';
import 'package:ze_livreur/screens/views/Notification/notificationscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  fcmtoken = await FirebaseMessaging.instance.getToken();
  print("fcmtoken = " + fcmtoken.toString());

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Auth>(create: (_) => Auth()),
    ChangeNotifierProvider(create: (context) => RequestProvider()),
    ChangeNotifierProvider<InscriptionProvider>(
        create: (_) => InscriptionProvider())
  ], child: ze_livreur()));
}

// ignore: camel_case_types
class ze_livreur extends StatelessWidget {
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
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    readToken();
    _registerOnFirebase();
    getMessage();
    super.initState();
  }

  Future<void> readToken() async {
    String token = await storage.read(key: "token");
    await Provider.of<Auth>(context, listen: false).tryToken(context, token);
    print("token : $token");
  }

  _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken();
  }

  void onFinish() {
    if (Provider.of<Auth>(context).authenticated == "notified")
      Provider.of<Auth>(this.context, listen: false)
          .changeAuthenticated("loggedin");
  }

  void getMessage() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage messageRemoted) {
        Map<String, dynamic> message = messageRemoted.data;
        var provider = Provider.of<RequestProvider>(context, listen: false);
        var userprovider = Provider.of<Auth>(context, listen: false);

        if (userprovider.authenticated != "notified" &&
            userprovider.authenticated != "delivring") {
          provider.changeIdClient(int.tryParse(message['id_client']));
          provider.changePrixPromo(double.tryParse(message['prixavecpromo']));
          provider.changeValeur(double.tryParse(message['valeur']));
          provider.changedistance(double.tryParse(message['distance']));
          provider.changeTelDest(message['teldest']);
          provider.changePoids(double.tryParse(message['poids']));
          provider.changeDimensions(message['dimensions']);
          provider.changeFragilite(message['fragilite']);
          provider.changenom(message['nom']);
          provider.changepickup(message['pickup']);
          provider.changedropoff(message['dropoff']);
          provider.changetel(message['tel']);
          provider.changerideid(message['rideid']);
          provider.changeprix(double.tryParse(message['prix']));
          provider.changeduration(double.tryParse(message['duration']));
          provider.changeLocalityDropOff(message['localitydest']);
          provider.changeLocalityPickUp(message['localityexp']);
          provider.changeWilayaExp(message['wilayaexp']);
          provider.changeWilayaDest(message['wilayadest']);
          provider.changeInterWilaya(int.tryParse(message['interwilaya']));
          print("inter wilya : " + message['interwilaya']);
          Provider.of<RequestProvider>(context, listen: false)
              .changeSeconds(15);

          Provider.of<Auth>(context, listen: false).changeauth("notified");
        }
      },
      onDone: () {
        print("sdsdsd");
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage messageRemoted) {
      Map<String, dynamic> message = messageRemoted.data;
      var userprovider = Provider.of<Auth>(context, listen: false);
      if (userprovider.livreurExt.etat == "online") {}
      var provider = Provider.of<RequestProvider>(context, listen: false);

      if (userprovider.authenticated != "notified" &&
          userprovider.authenticated != "delivring") {
        provider.changeIdClient(int.tryParse(message['id_client']));
        provider.changePrixPromo(double.tryParse(message['prixavecpromo']));
        provider.changeValeur(double.tryParse(message['valeur']));
        provider.changedistance(double.tryParse(message['distance']));
        provider.changeTelDest(message['teldest']);
        provider.changePoids(double.tryParse(message['poids']));
        provider.changeDimensions(message['dimensions']);
        provider.changeFragilite(message['fragilite']);
        provider.changenom(message['nom']);
        provider.changepickup(message['pickup']);
        provider.changedropoff(message['dropoff']);
        provider.changetel(message['tel']);
        provider.changerideid(message['rideid']);
        provider.changeprix(double.tryParse(message['prix']));
        provider.changeLocalityDropOff(message['localitydest']);
        provider.changeLocalityPickUp(message['localityexp']);
        provider.changeduration(double.tryParse(message['duration']));

        Provider.of<RequestProvider>(context, listen: false)
            .changeSeconds(_NavigationState().start);

        if (start != 0)
          Provider.of<Auth>(context, listen: false).changeauth("notified");
      }
    });
  }

  Timer timer;
  int start;
  void startTimer() {
    start = 15;
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
        } else {
          start--;
          print("remaining : $start");
        }
      },
    );
  }

  @override
  Widget build(context) {
    getMessage();
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

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message");
  _NavigationState().startTimer();
}
