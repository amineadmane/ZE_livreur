import 'package:flutter/material.dart';

class InscriptionProvider with ChangeNotifier {
  String _nom;
  String _eMail;
  String _prenom;
  String _phoneNumber;
  String _idPermis;
  DateTime _expireDate;
  String _matriculeVehicule;
  String _modeleVehicule;
  String _marqueVehicule;
  String _couleurVehicule;
  String _codeParrainage;
  String _password;

  String get nom => _nom;
  String get eMail => _eMail;
  String get prenom => _prenom;
  String get phoneNumber => _phoneNumber;
  String get idPermis => _idPermis;
  DateTime get expireDate => _expireDate;
  String get matriculeVehicule => _matriculeVehicule;
  String get marqueVehicule => _marqueVehicule;
  String get modeleVehicule => _modeleVehicule;
  String get couleurVehicule => _couleurVehicule;
  String get codeParrainage => _codeParrainage;
  String get password => _password;

  void changeNom(String nom) {
    _nom = nom;
    notifyListeners();
  }

  void changeeMail(String eMail) {
    _eMail = eMail;
    notifyListeners();
  }

  void changePrenom(String prenom) {
    _prenom = prenom;
    notifyListeners();
  }

  void changePhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void changeIdPermis(String idPermis) {
    _idPermis = idPermis;
    notifyListeners();
  }

  void changeExpireDate(DateTime expireDate) {
    _expireDate = expireDate;
    notifyListeners();
  }

  void changeCodeParrainage(String codeParrainage) {
    _codeParrainage = codeParrainage;
  }

  void changeMatriculeVehicule(String matriculeVehicule) {
    _matriculeVehicule = matriculeVehicule;
    notifyListeners();
  }

  void changeModeleVehicule(String modeleVehicule) {
    _modeleVehicule = modeleVehicule;
    notifyListeners();
  }

  void changeCouleurVehicule(String couleurVehicule) {
    _couleurVehicule = couleurVehicule;
    notifyListeners();
  }

  void changeMarqueVehicule(String marqueVehicule) {
    _marqueVehicule = marqueVehicule;
    notifyListeners();
  }

  void changePassword(String password) {
    _password = password;
    notifyListeners();
  }
}
