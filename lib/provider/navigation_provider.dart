import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  bool _isvisible = true;
  int _page = 0;
  int get getpage {
    return _page;
  }

  bool get getbool {
    return _isvisible;
  }

  void changepage(int value) {
    _page = value;
    notifyListeners();
  }

  void changepassstate() {
    _isvisible = !_isvisible;
    notifyListeners();
  }
}
