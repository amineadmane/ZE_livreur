import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/screens/views/Profile/profilescreen.dart';
import '../globalvariabels.dart';

// ignore: must_be_immutable
class Header extends StatelessWidget {
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF25E879);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);
  bool _status;
  String _title;

  void GoOnline(BuildContext context) {
    var provideridlivext =
        Provider.of<Auth>(context, listen: false).livreurExt.idLivExt;
    DatabaseReference tokenRef = FirebaseDatabase.instance
        .reference()
        .child('drivers/${provideridlivext}');
    tokenRef.set({'token': fcmtoken});
    Geofire.setLocation(provideridlivext.toString(), currentPosition.latitude,
        currentPosition.longitude);
  }

  void GoOffline(BuildContext context) {
    var provideridlivext =
        Provider.of<Auth>(context, listen: false).livreurExt.idLivExt;
    Geofire.removeLocation(provideridlivext.toString());
  }

  var locationoptions = LocationOptions(
      accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 4);

  void getLocationUpdates(BuildContext context) {
    var provideridlivext =
        Provider.of<Auth>(context, listen: false).livreurExt.idLivExt;
    bool isAvailable =
        Provider.of<NavigationProvider>(context, listen: false).getstatus;
    homeTabPositionStream = Geolocator()
        .getPositionStream(locationoptions)
        .listen((Position position) {
      currentPosition = position;
      if (isAvailable) {
        Geofire.setLocation(
            provideridlivext.toString(), position.latitude, position.longitude);
      }
    });
  }

  Future<void> getcurrentlocation() async {
    currentPosition = await Geolocator().getCurrentPosition();
    print(currentPosition.toString());
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    _status = provider.getstatus;
    _title = provider.gettitle;
    Size size = MediaQuery.of(context).size;
    double screenheight = size.height;
    double screenwidth = size.width;
    return Container(
      color: orange,
      height: screenheight * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ProfilePage(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.person_pin,
                  color: background,
                  size: 45,
                ),
              ),
              SizedBox(
                width: screenwidth * 0.3,
              ),
              FlutterSwitch(
                  value: _status,
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
                  onToggle: (val) async {
                    Map dispo;
                    if (val) {
                      dispo = {"etat": "online"};
                      if (currentPosition == null) {
                        await getcurrentlocation();
                      }
                      GoOnline(context);
                      getLocationUpdates(context);
                    } else {
                      dispo = {"etat": "offline"};
                      GoOffline(context);
                    }
                    Provider.of<Auth>(context, listen: false)
                        .changeDispo(context, dispo);
                  })
            ],
          ),
          Text(
            "$_title",
            style: TextStyle(
              color: background,
              fontSize: 50,
              fontFamily: 'Mom cake',
            ),
          )
        ],
      ),
    );
  }
}
