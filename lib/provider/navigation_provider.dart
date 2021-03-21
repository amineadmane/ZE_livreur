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

  int _month = 0;
  int _year = 0;
  String _search = "";
  int get getpage {
    return _page;
  }

  int get getmonth {
    return _month;
  }

  String get getsearch {
    return _search;
  }

  int get getyear {
    return _year;
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
  }

  void changesearch(String search) {
    _search = search;
    notifyListeners();
  }

  void changepassstate() {
    _isvisible = !_isvisible;
    notifyListeners();
  }

  void setStatus(bool status) {
    _status = status;
  }

  void changemonth(int month) {
    _month = month;
    notifyListeners();
  }

  void changeyear(int year) {
    _year = year;
    notifyListeners();
  }
}
