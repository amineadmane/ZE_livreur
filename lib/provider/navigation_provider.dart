import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  String _title = "Acceuil";
  bool _status = true;
  bool _isvisible = true;
  int _page = 2;
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

  void changesearch(String search) {
    _search = search;
    notifyListeners();
  }

  void changepassstate() {
    _isvisible = !_isvisible;
    notifyListeners();
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
