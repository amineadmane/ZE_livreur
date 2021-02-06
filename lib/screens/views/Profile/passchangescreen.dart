import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/components/common_styles.dart';

class ChangePassPage extends StatelessWidget {
  var passwordController = TextEditingController(text: "");
  var passwordConfController = TextEditingController(text: "");
  String password;
  Color background = Color(0xFFF2F2F2);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);

  @override
  Widget build(BuildContext context) {
    bool _isvisible = Provider.of<NavigationProvider>(context).getbool;
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SafeArea(
      child: Scaffold(
        appBar: appbar(context),
        backgroundColor: background,
        body: ListView(shrinkWrap: true, children: [
          Column(
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              passwordfield(context, _isvisible),
              passworconfdfield(context, _isvisible),
              text(context),
              button(context),
            ],
          )
        ]),
      ),
    );
  }

  Widget appbar(context) {
    Color violet = Color(0xFF382B8C);
    Color background = Color(0xFFF2F2F2);
    return AppBar(
      backgroundColor: background,
      shadowColor: null,
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: violet),
          onPressed: () => Navigator.pop(context)),
      title: Text(
        "Mot de passe",
        style: TextStyle(
          fontFamily: "Mom cake",
          fontSize: ResponsiveFlutter.of(context).fontSize(4),
          fontWeight: FontWeight.bold,
          color: Color(0xFF382B8C),
        ),
      ),
    );
  }

  Widget passwordfield(BuildContext context, bool _isvisible) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: CommonStyles.profilecontrainerdeco(),
      height: MediaQuery.of(context).size.height * 0.11,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        obscureText: _isvisible,
        controller: passwordController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          password = value;
        },
        decoration: CommonStyles().passFormFieldStyle(
            context,
            "Mot de passe",
            "",
            Icon(
              Icons.lock_outline_rounded,
              color: violet,
            ),
            _isvisible),
      ),
    );
  }

  Widget passworconfdfield(context, _isvisible) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: CommonStyles.profilecontrainerdeco(),
      height: MediaQuery.of(context).size.height * 0.11,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        obscureText: _isvisible,
        controller: passwordConfController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          password = value;
        },
        decoration: CommonStyles().passFormFieldStyle(
            context,
            "Confirmer le mot de passe",
            "",
            Icon(
              Icons.lock_outline_rounded,
              color: violet,
            ),
            _isvisible),
      ),
    );
  }

  Widget button(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(5)),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        color: orange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: FlatButton(
          onPressed: null,
          child: Text(
            "Sauvegarder",
            style: TextStyle(
                fontFamily: "Mom cake",
                fontWeight: FontWeight.w600,
                fontSize: ResponsiveFlutter.of(context).fontSize(4),
                color: background),
          )),
    );
  }

  Widget text(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Text(
        "Veuillez introduire un mot de passe avec plus de 8 caractères",
        style: TextStyle(
            color: violet,
            fontFamily: "Mom cake",
            fontSize: ResponsiveFlutter.of(context).fontSize(3)),
      ),
    );
  }
}
