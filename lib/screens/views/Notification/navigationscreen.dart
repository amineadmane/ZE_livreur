import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ze_livreur/components/common_styles.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:ze_livreur/screens/views/Notification/notificationscreen.dart';
import 'package:location/location.dart';
import 'package:ze_livreur/services/ApiCalls.dart';
import 'package:ze_livreur/services/maps.dart';
import 'package:ze_livreur/models/DirectionDetails.dart';
import 'package:ze_livreur/provider/request_provider.dart';
import 'package:provider/provider.dart';

class NavigationPage extends StatefulWidget {
  Color grey = Color(0xFF424242);
  Color grey2 = Color(0xFF646464);
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF4ED964);
  Color red = Color(0xFFFF3A32);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  Position currentposition;
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onMapCreated(GoogleMapController _cntlr) async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _controller = _cntlr;
    _locationData = await _location.getLocation();
    LatLng latlngposition =
        LatLng(_locationData.latitude, _locationData.longitude);
    CameraPosition cameraposition =
        new CameraPosition(target: latlngposition, zoom: 14);
    _controller.animateCamera(CameraUpdate.newCameraPosition(cameraposition));
    await createpolyline(_cntlr);
  }

  Future<void> createpolyline(GoogleMapController _cntlr) async {
    var provider = Provider.of<RequestProvider>(context, listen: false);

    DirectionDetails directionDetails = await Maps.obtainPlaceDirectionsDetails(
        context, provider.getpickup, provider.getdropoff);
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =
        polylinePoints.decodePolyline(directionDetails.encodedPoints);
    print(decodedPolyLinePointsResult.first.toString());
    pLineCoordinates.clear();
    if (decodedPolyLinePointsResult.isNotEmpty) {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }
    polylineSet.clear();
    setState(() {
      Polyline polyline = Polyline(
          color: Colors.green,
          polylineId: PolylineId("PolylineID"),
          jointType: JointType.round,
          points: pLineCoordinates,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true);
      polylineSet.add(polyline);
    });

    this.adjustcamera(_cntlr);

    Marker pickUpLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: pLineCoordinates.first,
        markerId: MarkerId("PickUpID"));

    Marker dropOffLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: pLineCoordinates.last,
        markerId: MarkerId("DropOffID"));

    setState(() {
      markersSet.add(pickUpLocMarker);
      markersSet.add(dropOffLocMarker);
    });

    Circle pickUpLocCircle = Circle(
      fillColor: Colors.blueAccent,
      center: pLineCoordinates.first,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: CircleId("PickUpID"),
    );

    Circle dropoffLocCircle = Circle(
      fillColor: Colors.deepPurple,
      center: pLineCoordinates.last,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.deepPurple,
      circleId: CircleId("DropOffID"),
    );

    setState(() {
      circlesSet.add(pickUpLocCircle);
      circlesSet.add(dropoffLocCircle);
    });

    return circlesSet;
  }

  void adjustcamera(GoogleMapController _cntlr) {
    LatLngBounds latLngBoundst;
    if (pLineCoordinates.first.latitude > pLineCoordinates.last.latitude &&
        pLineCoordinates.first.longitude > pLineCoordinates.last.longitude) {
      latLngBoundst = LatLngBounds(
          southwest: pLineCoordinates.last, northeast: pLineCoordinates.first);
    } else if (pLineCoordinates.first.longitude >
        pLineCoordinates.last.longitude) {
      latLngBoundst = LatLngBounds(
          southwest: LatLng(
              pLineCoordinates.first.latitude, pLineCoordinates.last.longitude),
          northeast: LatLng(pLineCoordinates.last.latitude,
              pLineCoordinates.first.longitude));
    } else if (pLineCoordinates.first.latitude >
        pLineCoordinates.last.latitude) {
      latLngBoundst = LatLngBounds(
          southwest: LatLng(
              pLineCoordinates.last.latitude, pLineCoordinates.first.longitude),
          northeast: LatLng(pLineCoordinates.first.latitude,
              pLineCoordinates.last.longitude));
    } else {
      latLngBoundst = LatLngBounds(
          southwest: pLineCoordinates.first, northeast: pLineCoordinates.last);
    }
    _controller = _cntlr;
    _controller.animateCamera(CameraUpdate.newLatLngBounds(latLngBoundst, 70));
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RequestProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      backgroundColor: NavigationPage().background,
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: ResponsiveFlutter.of(context).scale(10)),
        height: ResponsiveFlutter.of(context).hp(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            top(context, provider.getnom, provider.getprenom, provider.gettel),
            diveder(context),
            middle(context, provider.getdistance, provider.getduration),
            diveder(context),
            googlemap(context),
            diveder(context),
            bottom(context),
          ],
        ),
      ),
    ));
  }

  Widget googlemap(context) {
    return Container(
      height: ResponsiveFlutter.of(context).hp(50),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(target: _initialcameraposition),
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        polylines: polylineSet,
        markers: markersSet,
        circles: circlesSet,
      ),
    );
  }
}

Widget diveder(context) {
  return Container(
    child: Divider(
      color: NavigationPage().grey,
      thickness: 2,
    ),
  );
}

Widget middle(BuildContext context, String distance, int duration) {
  return Container(
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Container(
        padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(10)),
        height: ResponsiveFlutter.of(context).hp(12),
        decoration: CommonStyles.navigationboxes(),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                  text: convertduration(duration),
                  style: TextStyle(
                      color: NavigationPage().background,
                      fontSize: ResponsiveFlutter.of(context).fontSize(5),
                      fontFamily: "Mom Cake",
                      fontWeight: FontWeight.bold),
                  children: []),
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(10)),
        height: ResponsiveFlutter.of(context).hp(12),
        decoration: CommonStyles.navigationboxes(),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                  text: distance + " ",
                  style: TextStyle(
                      color: NavigationPage().background,
                      fontSize: ResponsiveFlutter.of(context).fontSize(5),
                      fontFamily: "Mom Cake",
                      fontWeight: FontWeight.bold),
                  children: []),
            ),
          ],
        ),
      )
    ]),
  );
}

bottom(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(5)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () async {
                  var provider = Provider.of<Auth>(context, listen: false);
                  await ApiCalls()
                      .AnnulerLivraison(provider.livreurExt.idLivExt);
                  Provider.of<Auth>(context, listen: false)
                      .changeauth("loggedin");
                },
                child: Container(
                  width: ResponsiveFlutter.of(context).scale(100),
                  height: ResponsiveFlutter.of(context).scale(50),
                  decoration: BoxDecoration(
                      color: NotificationPage().red,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.remove_circle_outline_outlined,
                    color: NotificationPage().background,
                    size: ResponsiveFlutter.of(context).fontSize(5.5),
                  ),
                )),
            FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: null,
                child: Container(
                  width: ResponsiveFlutter.of(context).scale(100),
                  height: ResponsiveFlutter.of(context).scale(50),
                  decoration: BoxDecoration(
                      color: NotificationPage().green,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: NotificationPage().background,
                    size: ResponsiveFlutter.of(context).fontSize(5.5),
                  ),
                )),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: ResponsiveFlutter.of(context).scale(100),
              child: Text(
                "Annuler",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: NavigationPage().grey,
                  fontFamily: "Mom cake",
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: ResponsiveFlutter.of(context).scale(100),
              child: Text(
                "Commande reçue",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: NavigationPage().grey,
                  fontFamily: "Mom cake",
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget top(context, String nom, String prenom, String tel) {
  void launchURL() async {
    var url = 'tel:' + tel;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
          margin: EdgeInsets.all(ResponsiveFlutter.of(context).scale(3)),
          decoration: CommonStyles.navigationboxes(),
          width: ResponsiveFlutter.of(context).wp(73),
          height: ResponsiveFlutter.of(context).hp(12),
          child: ListTile(
            leading: SizedBox(
              width: ResponsiveFlutter.of(context).wp(20),
              child: CircleAvatar(
                backgroundColor: Color(0xFFF2F2F2),
                radius: ResponsiveFlutter.of(context).scale(100),
                child: Image(
                  width: ResponsiveFlutter.of(context).scale(50),
                  image: AssetImage("assets/images/avatar.png"),
                ),
              ),
            ),
            title: Text(
              nom + " " + prenom,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: NavigationPage().background,
                fontFamily: "Mom cake",
                fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              tel,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: NavigationPage().background,
                fontFamily: "Mom cake",
                fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
      FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          launchURL();
        },
        child: Container(
          height: ResponsiveFlutter.of(context).hp(12),
          margin: EdgeInsets.all(ResponsiveFlutter.of(context).scale(3)),
          width: ResponsiveFlutter.of(context).wp(22),
          decoration: CommonStyles.navigationboxes(),
          child: Icon(
            Icons.phone_in_talk_outlined,
            color: NotificationPage().background,
            size: ResponsiveFlutter.of(context).scale(61),
          ),
        ),
      )
    ],
  );
}

String convertduration(int seconds) {
  var duration = seconds;
  var hours = (seconds / 3600).toStringAsFixed(0);
  duration = duration % 3600;
  var minutes = (duration / 60).toStringAsFixed(0);
  String durationtext = hours.toString() + "h" + minutes.toString() + "min";
  return durationtext;
}

format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
