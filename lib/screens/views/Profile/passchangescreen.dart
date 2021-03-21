import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/components/common_styles.dart';

class ChangePassPage extends StatefulWidget {
  @override
  _ChangePassPageState createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  var passwordController = TextEditingController(text: "");
  var passwordConfController = TextEditingController(text: "");
  String password;
  Color background = Color(0xFFF2F2F2);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool _isvisible = Provider.of<NavigationProvider>(context).getbool;
    var size = MediaQuery.of(context).size;
    var height = size.height;
    return SafeArea(
      child: Scaffold(
        appBar: appbar(context),
        backgroundColor: background,
        body: ListView(shrinkWrap: true, children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                passwordfield(context, _isvisible),
                passworconfdfield(context, _isvisible),
                text(context),
                button(context),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget appbar(context) {
    Color violet = Color(0xFF382B8C);
    Color background = Color(0xFFF2F2F2);
    return AppBar(
      elevation: 0,
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
        validator: (value) {
          if (value.length < 8 || value.isEmpty) {
            return "Mot de passe moin de 8 caracteres";
          }
          return null;
        },
        decoration: CommonStyles().passFormFieldStyle(
          context,
          "Mot de passe",
          "",
          Icon(
            Icons.lock_outline_rounded,
            color: violet,
          ),
        ),
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
        validator: (value) {
          if (value.length < 8 || value.isEmpty) {
            return "Mot de passe moin de 8 caracteres";
          }
          if (value != passwordController.text) {
            return "Mots de passe non identique";
          }
          return null;
        },
        decoration: CommonStyles().passFormFieldStyle(
          context,
          "Confirmer le mot de passe",
          "",
          Icon(
            Icons.lock_outline_rounded,
            color: violet,
          ),
        ),
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
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Map password = {"password": passwordController.text};
              Provider.of<Auth>(context, listen: false)
                  .changePassword(context, password);
              passwordConfController.clear();
              passwordController.clear();
            }
          },
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

  @override
  void dispose() {
    super.dispose();
    passwordConfController.dispose();
    passwordController.dispose();
  }
}
