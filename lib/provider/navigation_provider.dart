import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  String _title = "Acceuil";
  bool _status;
  bool _isvisible = true;
  int _page = 2;
  String _phonenumber;
  bool _renvoyer = false;
  String _eMail;
  String _nom;
  String _prenom;

  String get eMail => _eMail;
  String get nom => _nom;
  String get prenom => _prenom;
  bool get renvoyer => _renvoyer;

  String get phonenumber {
    return _phonenumber;
  }

  int get getpage {
    return _page;
  }

  bool get getbool {
    return _isvisible;
  }

  bool get getstatus {
    return _status;
  }

  String get gettitle {
    return _title;
  }

  void changeNom(String nom) {
    _nom = nom;
  }

  void changePrenom(String prenom) {
    _prenom = prenom;
  }

  void changeEMail(String eMail) {
    _eMail = eMail;
  }

  void changePhoneNumber(String phonenumber) {
    _phonenumber = phonenumber;
    notifyListeners();
  }

  void changepage(int value) {
    _page = value;
    notifyListeners();
  }

  void changetitle(String title) {
    _title = title;
    notifyListeners();
  }

  void changestatus() {
    _status = !_status;
    notifyListeners();
  }

  void changeRenvoyer(bool renvoyer) {
    if (renvoyer == null) {
      _renvoyer = !_renvoyer;
    } else {
      _renvoyer = renvoyer;
    }
    notifyListeners();
  }

  void changepassstate() {
    _isvisible = !_isvisible;
    notifyListeners();
  }

  void setStatus(bool status) {
    _status = status;
    notifyListeners();
  }
}
