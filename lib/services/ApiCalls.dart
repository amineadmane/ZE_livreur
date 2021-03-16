import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ze_livreur/Models/Livraison_externe.dart';
import 'package:ze_livreur/models/Evaluation_List.dart';
import 'package:ze_livreur/models/Evaluation_totale.dart';
import 'package:ze_livreur/models/Histo_mensuelle.dart';
import 'package:ze_livreur/models/Historique_annuel.dart';
import 'package:ze_livreur/models/Livraison_aujourdhui.dart';
import 'package:ze_livreur/models/Metric.dart';
import 'package:ze_livreur/models/ParrainageModal.dart';
import 'package:ze_livreur/models/Year.dart';
import 'package:ze_livreur/provider/dio.dart';

class ApiCalls {
  String URL = 'http://192.168.0.191:8000/api';
  String _token;

  Future<void> readtoken() async {
    this._token = await storage.read(key: "token");
  }

  final storage = new FlutterSecureStorage();
  Future<Livraison_externe> getDerniereliv(int id) async {
    await readtoken();
    print("token : $_token");
    Livraison_externe _livraisonexterne;
    var response = await http.get(URL + '/dernierelivraison/' + id.toString(),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer $_token'
        });

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        return _livraisonexterne;
      } else {
        _livraisonexterne =
            Livraison_externe.fromJson(jsonDecode(response.body));
        return _livraisonexterne;
      }
    } else {
      return _livraisonexterne;
    }
  }

  Future<Livraison_aujourdhui> getlivauj(int id) async {
    await readtoken();
    Livraison_aujourdhui _livraisonauj;
    var response = await http.get(URL + '/livraisonaujourdui/' + id.toString(),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer $_token'
        });

    if (response.statusCode == 200) {
      _livraisonauj = Livraison_aujourdhui.fromJson(jsonDecode(response.body));
      if (_livraisonauj.livraisons == 0) {
        _livraisonauj.prix = "0";
        _livraisonauj.distanceTotale = 0;
      }
      return _livraisonauj;
    } else {
      return _livraisonauj;
    }
  }

  Future<Metric> getmetric(int id) async {
    Metric _metric;
    await readtoken();
    var response = await http.get(URL + '/Metric/' + id.toString(), headers: {
      "Authorization": 'Bearer $_token',
      "Accept": "application/json"
    });

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        _metric = new Metric();
        return _metric;
      } else {
        _metric = Metric.fromJson(jsonDecode(response.body));
        return _metric;
      }
    } else {
      return _metric;
    }
  }

  Future<Parrainagemodel> getparrainage(int id) async {
    await readtoken();
    Parrainagemodel _parring;
    var response = await http.get(URL + '/parrainage/' + id.toString(),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer $_token'
        });
    if (response.statusCode == 200) {
      _parring = Parrainagemodel.fromJson(jsonDecode(response.body));
      return _parring;
    } else {
      return _parring;
    }
  }

  Future<List<Historique_annuel>> gethistoannuel(int id, int year) async {
    await readtoken();
    List<Historique_annuel> _histo_annuel;
    var response = await http.get(
        URL + '/historiqueannuel/' + id.toString() + "/" + year.toString(),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer $_token'
        });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((job) => new Historique_annuel.fromJson(job))
          .toList();
    } else {
      return _histo_annuel;
    }
  }

  Future<List<Evaluation_List>> gethistoevaluation(int id) async {
    await readtoken();
    List<Evaluation_List> _evaluation_list;
    print(id);
    var response = await http.get(URL + '/histoevaluation/' + id.toString(),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer $_token'
        });

    if (response.statusCode == 200) {
      print("200");
      print("body : " + response.body.toString());
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((job) => new Evaluation_List.fromJson(job))
          .toList();
    } else {
      return _evaluation_list;
    }
  }

  Future<List<Histo_mensuel>> gethistomensuelle(
      int id, int month, int year) async {
    await readtoken();
    List<Histo_mensuel> _histomensuel;
    var response = await http.get(
        URL +
            '/histolivraisonmensuelle/' +
            id.toString() +
            "/" +
            month.toString() +
            "/" +
            year.toString(),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer $_token'
        });

    if (response.statusCode == 200) {
      print("mensuel : 200");
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((job) => new Histo_mensuel.fromJson(job))
          .toList();
    } else {
      return _histomensuel;
    }
  }

  Future<Evaluation_totale> getevaluationtotale(int id) async {
    await readtoken();
    Evaluation_totale _eval;
    var response = await http.get(URL + '/Evaluationtotal/' + id.toString(),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer $_token'
        });
    if (response.statusCode == 200) {
      _eval = Evaluation_totale.fromJson(jsonDecode(response.body));
      return _eval;
    } else {
      return _eval;
    }
  }

  Future<List<Year>> getyears(int id) async {
    await readtoken();
    List<Year> years;
    var response = await http.get(URL + '/livraisonyears/' + id.toString(),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer $_token'
        });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Year.fromJson(job)).toList();
    } else {
      return years;
    }
  }
}
