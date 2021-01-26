import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Color orange = Color(0xFFF28322);
  Color background = Color(0xFFF2F2F2);
  Color violet = Color(0xFF382B8C);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,
      height: 50.0,
      items: <Widget>[
        Icon(
          Icons.person_add_rounded,
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
        setState(() {
          _page = index;
        });
      },
      letIndexChange: (index) => true,
    );
  }
}
