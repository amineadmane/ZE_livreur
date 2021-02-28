
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ze_livreur/Models/Livraison_externe.dart';
import 'package:ze_livreur/models/Livraison_aujourdhui.dart';

class ApiCalls {
  String URL = 'http://192.168.0.191:8000/api';
  Future<Livraison_externe> getDerniereliv(int id) async{
    Livraison_externe _livraisonexterne;
    var response = await http.get(URL+'/dernierelivraison/'+id.toString(),
        headers: {
          "Accept" : "application/json"
        });

    if(response.statusCode == 200)
      {
        _livraisonexterne = Livraison_externe.fromJson(jsonDecode(response.body));
        return _livraisonexterne;
      }
    else
      {
        return _livraisonexterne;
      }
  }
  Future<Livraison_aujourdhui> getlivauj(int id) async{
    Livraison_aujourdhui _livraisonauj;
    var response = await http.get(URL+'/livraisonaujourdui/'+id.toString(),
        headers: {
          "Accept" : "application/json"
        });

    if(response.statusCode == 200)
    {
      _livraisonauj = Livraison_aujourdhui.fromJson(jsonDecode(response.body));
      return _livraisonauj;
    }
    else
    {
      return _livraisonauj;
    }
  }
}