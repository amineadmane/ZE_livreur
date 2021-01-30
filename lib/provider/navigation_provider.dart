import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {

  int _page = 0;
  int get getpage {
    return _page;
  }
  void changepage(int value)
  {
    _page = value;
    notifyListeners();
  }
}
