import 'package:flutter/material.dart';

class RequestProvider with ChangeNotifier {
  String _nom;
  String _prenom;
  String _pickup;
  String _droppoff;
  String _tel;
  double _prix;
  String _distance;
  int _duration;
  String _rideid;

  String get getrideid {
    return _rideid;
  }

  void changerideid(String rideid) {
    _rideid = rideid;
    notifyListeners();
  }

  String get getnom {
    return _nom;
  }

  String get gettel {
    return _tel;
  }

  String get getprenom {
    return _prenom;
  }

  String get getpickup {
    return _pickup;
  }

  String get getdropoff {
    return _droppoff;
  }

  double get getprix {
    return _prix;
  }

  String get getdistance {
    return _distance;
  }

  int get getduration {
    return _duration;
  }

  void changenom(String nom) {
    _nom = nom;
    notifyListeners();
  }

  void changetel(String tel) {
    _tel = tel;
    notifyListeners();
  }

  void changeprenom(String prenom) {
    _prenom = prenom;
    notifyListeners();
  }

  void changepickup(String pickup) {
    _pickup = pickup;
    notifyListeners();
  }

  void changedropoff(String dropoff) {
    _droppoff = dropoff;
    notifyListeners();
  }

  void changeprix(double prix) {
    _prix = prix;
    notifyListeners();
  }

  void changedistance(String distance) {
    _distance = distance;
    notifyListeners();
  }

  void changeduration(int duration) {
    _duration = duration;
    notifyListeners();
  }
}
