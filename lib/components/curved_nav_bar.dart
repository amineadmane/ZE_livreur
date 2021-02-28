import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';

class BottomNavBar extends StatelessWidget {
  void _changepage(BuildContext context, int value) {
    Provider.of<NavigationProvider>(context, listen: false).changepage(value);
  }

  void _changetitle(BuildContext context, String title) {
    Provider.of<NavigationProvider>(context, listen: false).changetitle(title);
  }

  final GlobalKey _bottomNavigationKey = GlobalKey();
  final Color orange = Color(0xFFF28322);
  final Color background = Color(0xFFF2F2F2);
  final Color violet = Color(0xFF382B8C);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 2,
      height: 50.0,
      items: <Widget>[
        Icon(
          Icons.group_add_rounded,
          size: 30,
          color: background,
        ),
        Icon(Icons.history_rounded, size: 30, color: background),
        Icon(Icons.home_rounded, size: 30, color: background),
        Icon(Icons.monetization_on_rounded, size: 30, color: background),
        Icon(Icons.star_rate_rounded, size: 30, color: background),
      ],
      color: orange,
      buttonBackgroundColor: violet,
      backgroundColor: background,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 500),
      onTap: (index) {
        _changepage(context, index);
        switch (index) {
          case 0:
            {
              _changetitle(context, "Parrainage");
            }
            break;

          case 1:
            {
              _changetitle(context, "Historique");
            }
            break;

          case 2:
            {
              _changetitle(context, "Acceuil");
            }
            break;

          case 3:
            {
              _changetitle(context, "Finances");
            }
            break;
          case 4:
            {
              _changetitle(context, "Rating");
            }
            break;
        }
      },
      letIndexChange: (index) => true,
    );
  }
}
