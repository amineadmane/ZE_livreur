import 'dart:convert';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:ze_livreur/globalvariabels.dart';
import 'package:ze_livreur/models/LivreurExt.dart';
import 'package:ze_livreur/provider/dio.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/screens/views/Inscription_login/Inscrit.dart';

class Auth extends ChangeNotifier {
  final storage = new FlutterSecureStorage();
  String _isloggedIn = "loggedout";
  String get authenticated => _isloggedIn;
  LivreurExt _livreurExt;
  String token;
  String get _token => token;
  LivreurExt get livreurExt => _livreurExt;

  String get getauth {
    return authenticated;
  }

  void changeauth(String auth) {
    _isloggedIn = auth;
    notifyListeners();
  }

  String gettoken() {
    return this.token;
  }

  Future<void> login(BuildContext context, Map creds) async {
    print(creds);
    try {
      Dio.Response response = await dio().post('/LivreurExt',
          data: creds,
          options: Dio.Options(
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }));
      if (response.statusCode == 200) {
        String token = response.data.toString();
        this.tryToken(context, token);
      }
    } on Dio.DioError catch (e) {
      if (e.response.statusCode == 302) print(e);
    }
  }

  Future<void> tryToken(BuildContext context, String token) async {
    if (token == null) {
      return;
    } else {
      try {
        Dio.Response response = await dio().get('/LivreurExt',
            options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
        if (response.statusCode == 200) {
          print(response.data.toString());
          this._livreurExt = LivreurExt.fromJson(response.data);
          if (this._livreurExt.etat == "bloque") {
            this._isloggedIn = "blocked";
          } else {
            this._isloggedIn = "loggedin";
          }
          this.token = token;
          if (_livreurExt.etat == "online") {
            Provider.of<NavigationProvider>(context, listen: false)
                .setStatus(true);
          } else {
            Provider.of<NavigationProvider>(context, listen: false)
                .setStatus(false);
          }
          storeToken(token, _livreurExt.idLivExt.toString());
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

  Future<void> inscription(BuildContext context, Map livreurExt,
      GlobalKey<ScaffoldState> _key) async {
    try {
      Dio.Response response = await dio().post('/Livreur',
          data: livreurExt,
          options: Dio.Options(
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }));
      if (response.statusCode == 200) {
        print("200");
        if (response.data.toString() == "inscrpition reussite") {
          _isloggedIn = "blocked";
          notifyListeners();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Inscrit()));
        } else {
          return _key.currentState.showSnackBar(SnackBar(
              content:
                  Text("Adresse mail ou numéro de téléphone deja utilisés")));
        }
      }
    } on Dio.DioError catch (e) {
      if (e.response.statusCode == 302) print(e);
    }
  }

  changeDispo(
    BuildContext context,
    Map data,
  ) async {
    try {
      int id = this._livreurExt.idLivExt;
      Dio.Response response = await dio().post('/Dispo/$id.toString()',
          data: data,
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        Provider.of<NavigationProvider>(context, listen: false).changestatus();
      } else {
        return await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Un probleme est survenue !'),
            content: Text(
                'Un probleme est survenue, Veuillez réesseyer plus tard !'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pop(); // dismisses only the dialog and returns nothing
                },
                child: new Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {}
  }

  changePassword(BuildContext context, Map password) async {
    int id = _livreurExt.idLivExt;
    Dio.Response response = await dio().post('/Password/$id',
        data: password,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          contentType: "application/json",
        ));
    if (response.statusCode == 200) {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Opération reussite !'),
          content: Text('Votre mot de passe a été changé avec succés'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pop(); // dismisses only the dialog and returns nothing
              },
              child: new Text('OK'),
            ),
          ],
        ),
      );
    } else {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Erreur !'),
          content: Text(
              'Une erreur s\'est produite, veuillez réessayer plus tard !'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pop(); // dismisses only the dialog and returns nothing
              },
              child: new Text('Retour'),
            ),
          ],
        ),
      );
    }
  }

  changeLivreurInfo(
      BuildContext context, Map data, GlobalKey<ScaffoldState> _key) async {
    int id = _livreurExt.idLivExt;

    Dio.Response response = await dio().patch(Uri.encodeFull('/livreur/$id/'),
        data: jsonEncode(data),
        options: Dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
          contentType: "application/json",
        ));
    print(response.data.toString());
    if (response.statusCode == 200) {
      if (response.data.toString() == "Operation reussite") {
        _livreurExt.phoneNumber = data['phone_number'];
        _livreurExt.eMail = data['e_mail'];
        _livreurExt.nom = data['nom'];
        _livreurExt.prenom = data['prenom'];
        notifyListeners();
        await showDialog(
          context: context,
          builder: (_) => new AlertDialog(
            title: new Text('Opération Terminé !'),
            content: Text('Vos informations ont été changé avec succés '),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pop(); // dismisses only the dialog and returns nothing
                },
                child: new Text('OK'),
              ),
            ],
          ),
        );
      } else {
        return _key.currentState.showSnackBar(SnackBar(
            content:
                Text("Adresse mail ou numéro de téléphone deja utilisés")));
      }
    } else {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Erreur !'),
          content: Text(
              'Une erreur s\'est produite, veuillez réessayer plus tard !'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pop(); // dismisses only the dialog and returns nothing
              },
              child: new Text('Retour'),
            ),
          ],
        ),
      );
    }
  }

  changeAuthenticated(String authenticated) {
    _isloggedIn = authenticated;
    notifyListeners();
  }
}
