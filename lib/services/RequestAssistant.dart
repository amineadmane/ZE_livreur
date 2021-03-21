import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestAssistant {
  static Future<dynamic> getRequest(String url) async {
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        String jSonData = response.body;
        var decodeData = jsonDecode(jSonData);
        return decodeData;
      } else {
        return "Failed , No Response";
      }
    } catch (exp) {
      return "Failed";
    }
  }
}
