import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ze_livreur/models/LivreurExt.dart';
import 'package:ze_livreur/provider/dio.dart';

class Auth extends ChangeNotifier {
  final storage = new FlutterSecureStorage();
  String _isloggedIn = "loggedout";
  String get authenticated => _isloggedIn;
  LivreurExt _livreurExt;
  String token;
  LivreurExt get livreurExt => _livreurExt;

  String gettoken()
  {
    print(this.token);
    print("this is tiken : $token");
    return this.token;
  }
  Future<void> login(Map creds) async {
    print(creds);
    try {
      Dio.Response response = await dio().post('/LivreurExt',
          data: creds,
          options: Dio.Options(
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }));
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.data.toString());
        String token = response.data.toString();
        this.tryToken(token);
      }
    } on Dio.DioError catch (e) {
      if (e.response.statusCode == 302) print(e);
    }
  }

  Future<void> tryToken(String token) async {
    if (token == null) {
      return;
    } else {
      try {
        Dio.Response response = await dio().get('/LivreurExt',
            options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
        if (response.statusCode == 200) {
          this._livreurExt = LivreurExt.fromJson(response.data);
          if (this._livreurExt.etat == "bloque") {
            this._isloggedIn = "blocked";
          } else {
            this._isloggedIn = "loggedin";
          }
          this.token = token;
          storeToken(token, _livreurExt.idLivExt.toString());
          print(_livreurExt);
          notifyListeners();
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> storeToken(String token, String livreurExtID) async {
    await this.storage.write(key: "token", value: token);

    await this.storage.write(key: "livreurExtID", value: livreurExtID);
  }

  Future<void> logout() async {
    try {
      Dio.Response response = await dio().get('/LivreurExt/revoke',
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        cleanUp();
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> cleanUp() async {
    this._livreurExt = null;
    this._isloggedIn = "loggedout";
    this.token = null;
    await storage.deleteAll();
  }
}
