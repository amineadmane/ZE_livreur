import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ze_livreur/models/DirectionDetails.dart';
import 'package:ze_livreur/provider/request_provider.dart';
import 'package:ze_livreur/services/RequestAssistant.dart';

class Maps {
  static Future<DirectionDetails> obtainPlaceDirectionsDetails(
      BuildContext context, String pickup, String dropoff) async {
    String directionURL =
        "https://maps.googleapis.com/maps/api/directions/json?origin=" +
            pickup +
            "&destination=" +
            dropoff +
            "&key=AIzaSyAP7liOJtATNmGMiTihPlUSrW0qWvZiM44";

    DirectionDetails directiondetails = DirectionDetails();

    var res = await RequestAssistant.getRequest(directionURL);
    if (res == "Failed") {
      return null;
    }

    directiondetails.encodedPoints =
        res["routes"][0]["overview_polyline"]["points"];

    directiondetails.distanceText =
        res["routes"][0]["legs"][0]["distance"]["text"];
    directiondetails.distanceValue =
        res["routes"][0]["legs"][0]["distance"]["value"];

    directiondetails.durationText =
        res["routes"][0]["legs"][0]["duration"]["text"];
    directiondetails.durationValue =
        res["routes"][0]["legs"][0]["duration"]["value"];
    var provider = Provider.of<RequestProvider>(context, listen: false);
    print("duration value : " + directiondetails.durationValue.toString());
    provider.changedistance(directiondetails.distanceText);
    provider.changeduration(directiondetails.durationValue);

    return directiondetails;
  }
}
