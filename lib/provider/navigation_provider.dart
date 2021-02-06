import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {

  String _title = "Acceuil";
  bool _status = true;
  bool _isvisible = true;
  int _page = 2;
  int get getpage {
    return _page;
  }
  bool get getbool {
    return _isvisible;
  }
  bool get getstatus {
    return _isvisible;
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

  void changepassstate() {
    _isvisible = !_isvisible;
    notifyListeners();
  }
}
