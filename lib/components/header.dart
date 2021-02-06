import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';

class Header extends StatelessWidget {
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF25E879);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);
  bool _status ;
  String _title ;
  void _changestatus(BuildContext context) {
    Provider.of<NavigationProvider>(context, listen: false).changestatus();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    _status = provider.getstatus;
    _title = provider.gettitle;
    Size size = MediaQuery.of(context).size;
    double screenheight = size.height;
    double screenwidth = size.width;
    return Container(
      color: orange,
      height: screenheight * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.person_pin,
                color: background,
                size: 45,
              ),
              SizedBox(
                width: screenwidth * 0.3,
              ),
              FlutterSwitch(
                  value: _status,
                  width: 60,
                  height: 25,
                  valueFontSize: 12.0,
                  toggleSize: screenheight * 0.025,
                  borderRadius: 30.0,
                  padding: 4.0,
                  showOnOff: true,
                  activeText: "ON",
                  inactiveText: "OFF",
                  activeColor: green,
                  inactiveTextColor: violet,
                  inactiveColor: background,
                  onToggle: (val) {
                    _changestatus(context);
                  })
            ],
          ),
          Text(
            "$_title",
            style: TextStyle(
              color: background,
              fontSize: 50,
              fontFamily: 'Mom cake',
            ),
          )
        ],
      ),
    );
  }
}
