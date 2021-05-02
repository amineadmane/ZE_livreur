import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final CameraPosition googlePlex = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);

String mapKey = 'AIzaSyCGDOgE33dc-6UHtIAptXSAVZRogFvV8Hs';

StreamSubscription<Position> homeTabPositionStream;

StreamSubscription<Position> ridePositionStream;

var currentPosition;

DatabaseReference rideRef;
var fcmtoken;
