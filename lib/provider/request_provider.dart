import 'package:flutter/material.dart';

class RequestProvider with ChangeNotifier {
  int _idClient;
  String _nom;
  String _pickup;
  String _droppoff;
  String _tel;
  double _prix;
  double _prixPromo;
  double _valeur;
  double _distance;
  String _dest;
  String _telDest;
  double _duration;
  double _poids;
  String _dimensions;
  String _fragilite;
  String _rideid;
  String _localityPickUp;
  String _localityDropOff;
  String _wilayaDest;
  String _wilayaExp;
  int _interWilaya;
  int _seconds;

  int get interWilaya => _interWilaya;
  String get wilayaDest => _wilayaDest;
  String get wilayaExp => _wilayaExp;
  String get localityPickUp => _localityPickUp;
  String get localityDropOff => _localityDropOff;
  String get fragilite => _fragilite;
  String get dimensions => _dimensions;
  double get poids => _poids;
  String get telDest => _telDest;
  String get dest => _dest;
  double get valeur => _valeur;
  double get prixPromo => _prixPromo;
  int get idClient => _idClient;
  int get seconds => _seconds;

  String get getrideid {
    return _rideid;
  }

  String get getnom {
    return _nom;
  }

  String get gettel {
    return _tel;
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

  double get getdistance {
    return _distance;
  }

  double get getduration {
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

  void changedistance(double distance) {
    _distance = distance;
    notifyListeners();
  }

  void changeduration(double duration) {
    _duration = duration;
    notifyListeners();
  }

  void changerideid(String rideid) {
    _rideid = rideid;
    notifyListeners();
  }

  void changePrixPromo(double prixPromo) {
    _prixPromo = prixPromo;
    notifyListeners();
  }

  void changeDest(String dest) {
    _dest = dest;
    notifyListeners();
  }

  void changeValeur(double valeur) {
    _valeur = valeur;
    notifyListeners();
  }

  void changeTelDest(String telDest) {
    _telDest = telDest;
    notifyListeners();
  }

  void changeIdClient(int idClient) {
    _idClient = idClient;
    notifyListeners();
  }

  void changePoids(double poids) {
    _poids = poids;
    notifyListeners();
  }

  void changeFragilite(String fragilite) {
    _fragilite = fragilite;
    notifyListeners();
  }

  void changeDimensions(String dimensions) {
    _dimensions = dimensions;
    notifyListeners();
  }

  void changeLocalityPickUp(String localityPickUp) {
    _localityPickUp = localityPickUp;
    notifyListeners();
  }

  void changeLocalityDropOff(String localityDropOff) {
    _localityDropOff = localityDropOff;
    notifyListeners();
  }

  void changeInterWilaya(int interWilaya) {
    _interWilaya = interWilaya;
    notifyListeners();
  }

  void changeWilayaDest(String wilayaDest) {
    _wilayaDest = wilayaDest;
    notifyListeners();
  }

  void changeWilayaExp(String wilayaExp) {
    _wilayaExp = wilayaExp;
    notifyListeners();
  }

  void changeSeconds(int seconds) {
    _seconds = seconds;
    notifyListeners();
  }
}
