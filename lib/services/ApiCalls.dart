import 'dart:io';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:ze_livreur/models/Evaluation_List.dart';
import 'package:ze_livreur/models/Evaluation_totale.dart';
import 'package:ze_livreur/models/Histo_mensuelle.dart';
import 'package:ze_livreur/models/HistoriqueDetail.dart';
import 'package:ze_livreur/models/Historique_annuel.dart';
import 'package:ze_livreur/models/Livraison_aujourdhui.dart';
import 'package:ze_livreur/models/Livraison_externe.dart';
import 'package:ze_livreur/models/Metric.dart';
import 'package:ze_livreur/models/ParrainageModal.dart';
import 'package:ze_livreur/models/Year.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:ze_livreur/provider/dio.dart';

class ApiCalls {
  String uRL = 'http://192.168.0.109:8000/api';
  String _token;

  Future<void> readtoken() async {
    this._token = await storage.read(key: "token");
  }

  final storage = new FlutterSecureStorage();
  Future<LivraisonExterne> getDerniereliv(int id) async {
    await readtoken();
    print("token : $_token");
    LivraisonExterne _livraisonexterne;
    var response = await http.get(uRL + '/dernierelivraison/' + id.toString(),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer $_token'
        });

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        return null;
      } else {
        _livraisonexterne =
            LivraisonExterne.fromJson(jsonDecode(response.body));
        return _livraisonexterne;
      }
    } else {
      return _livraisonexterne;
    }
  }

  Future<HistoriqueDetail> getlivext(String id) async {
    await readtoken();
    print("token : $_token");
    HistoriqueDetail _livraisonexterne;
    var response = await http.get(uRL + '/LivraisonDetails/' + id.toString(),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer $_token'
        });

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        return null;
      } else {
        _livraisonexterne =
            HistoriqueDetail.fromJson(jsonDecode(response.body));
        return _livraisonexterne;
      }
    } else {
      return _livraisonexterne;
    }
  }

  Future<Livraison_aujourdhui> getlivauj(int id) async {
    await readtoken();
    Livraison_aujourdhui _livraisonauj;
    var response = await http.get(uRL + '/livraisonaujourdui/' + id.toString(),
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
    var response = await http.get(uRL + '/Metric/' + id.toString(), headers: {
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
    var response = await http.get(uRL + '/parrainage/' + id.toString(),
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

  Future<List<HistoriqueAnnuel>> gethistoannuel(int id, int year) async {
    await readtoken();
    List<HistoriqueAnnuel> _histoAnnuel;
    var response = await http.get(
        uRL + '/historiqueannuel/' + id.toString() + "/" + year.toString(),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer $_token'
        });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((job) => new HistoriqueAnnuel.fromJson(job))
          .toList();
    } else {
      return _histoAnnuel;
    }
  }

  Future<List<EvaluationList>> gethistoevaluation(int id) async {
    await readtoken();
    List<EvaluationList> _evaluationList;
    print(id);
    var response = await http.get(uRL + '/histoevaluation/' + id.toString(),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer $_token'
        });

    if (response.statusCode == 200) {
      print("200");
      print("body : " + response.body.toString());
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((job) => new EvaluationList.fromJson(job))
          .toList();
    } else {
      return _evaluationList;
    }
  }

  Future<List<HistoMensuel>> gethistomensuelle(
      int id, int month, int year) async {
    await readtoken();
    List<HistoMensuel> _histomensuel;
    var response = await http.get(
        uRL +
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
      return jsonResponse.map((job) => new HistoMensuel.fromJson(job)).toList();
    } else {
      return _histomensuel;
    }
  }

  Future<EvaluationTotale> getevaluationtotale(int id) async {
    await readtoken();
    EvaluationTotale _eval;
    var response = await http.get(uRL + '/Evaluationtotal/' + id.toString(),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer $_token'
        });
    if (response.statusCode == 200) {
      _eval = EvaluationTotale.fromJson(jsonDecode(response.body));
      return _eval;
    } else {
      return _eval;
    }
  }

  Future<List<Year>> getyears(int id) async {
    await readtoken();
    List<Year> years;
    var response = await http.get(uRL + '/livraisonyears/' + id.toString(),
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

  Future<void> acceptLivraison(Dio.FormData data) async {
    await readtoken();
    try {
      Dio.Response response = await dio().post('/livraison',
          data: data,
          options: Dio.Options(headers: {'Authorization': 'Bearer $_token'}));
      if (response.statusCode == 200) {
        print("ok");
      }
    } on Dio.DioError catch (e) {
      print(e);
      if (e.response.statusCode == 302) print(e);
    }
  }

  Future<void> annulerLivraison(int id) async {
    await readtoken();
    var response = await http.get(uRL + '/Annulerlivraison/' + id.toString(),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer $_token'
        });

    if (response.statusCode == 200) {
      return "Operation reussie";
    }
  }

  Future uploadImage(BuildContext context, _scaffoldkey, File image, int id,
      String token) async {
    final uri = Uri.parse(uRL + '/upload/' + id.toString());
    print('here the token  $token');
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(
          {"Accept": "application/json", "Authorization": 'Bearer $token'});

    var pic = await http.MultipartFile.fromPath("image", image.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      Provider.of<Auth>(context, listen: false)
          .changePhoto(basename(image.path));
      print("photo uploaded");
    } else {
      print(response.statusCode);
      _scaffoldkey.currentState.showSnackBar(SnackBar(
          content: Text("Une erreur s'est produite, réessayer plus tard !")));
    }
  }
}
