import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ze_livreur/screens/views/financesscreen.dart';
import 'package:ze_livreur/screens/views/historyscreen.dart';
import 'package:ze_livreur/screens/views/homepage.dart';
import 'package:ze_livreur/screens/views/linkingscreen.dart';
import 'package:ze_livreur/screens/views/ratingscreen.dart';

class NavigationProvider with ChangeNotifier {
  String currentNavigation = "homepage";

  Widget get getNavigation {
    if (currentNavigation == "homepage") {
      return HomePage();
    } else if (currentNavigation == "finances") {
      return FinancesPage();
    } else if (currentNavigation == "ratings") {
      return RatingsPage();
    } else if (currentNavigation == "history") {
      return HistoryPage();
    } else if (currentNavigation == "linking") {
      return LinkingPage();
    }
  }

  void updateNavigation(String navigation) {
    currentNavigation = navigation;
    notifyListeners();
  }
}
