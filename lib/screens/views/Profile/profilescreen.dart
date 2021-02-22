import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ze_livreur/screens/views/Profile/passchangescreen.dart';
import 'package:ze_livreur/components/common_styles.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  launchURL() async {
    const url = 'tel:+213771854123';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String route = "/profile";

  String nom;
  String prenom;
  String phone;
  String email;
  var nomController = TextEditingController(text: "");
  var prenomController = TextEditingController(text: "");
  var phoneController = TextEditingController(text: "");
  var emailController = TextEditingController(text: "");
  var _emailFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();
  Color background = Color(0xFFF2F2F2);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appbar(context),
        backgroundColor: background,
        body: ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                avatar(context),
                namefield(context),
                prenomfield(context),
                phonefield(context),
                emailfield(context),
                button(context),
                commandes(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget avatar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
      child: CircleAvatar(
          backgroundColor: Color(0xFF382B8C),
          radius: ResponsiveFlutter.of(context).scale(45),
          child: CircleAvatar(
            radius: ResponsiveFlutter.of(context).scale(43),
            backgroundImage: AssetImage("assets/images/angela.jpg"),
          )),
    );
  }

  Widget namefield(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: CommonStyles.profilecontrainerdeco(),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: nomController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          nom = value;
        },
        decoration: CommonStyles.profileFormFieldStyle(
            context,
            "Nom",
            "",
            Icon(
              Icons.person_outline_rounded,
              color: violet,
            )),
      ),
    );
  }

  Widget prenomfield(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: CommonStyles.profilecontrainerdeco(),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: prenomController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          nom = value;
        },
        decoration: CommonStyles.profileFormFieldStyle(context, "Prénom", "",
            Icon(Icons.person_outline_rounded, color: violet)),
      ),
    );
  }

  Widget emailfield(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: CommonStyles.profilecontrainerdeco(),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          nom = value;
        },
        decoration: CommonStyles.profileFormFieldStyle(context, "E-Mail", "",
            Icon(Icons.alternate_email_rounded, color: violet)),
      ),
    );
  }

  Widget phonefield(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: CommonStyles.profilecontrainerdeco(),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Center(
        child: TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          onChanged: (value) {
            nom = value;
          },
          decoration: CommonStyles.profileFormFieldStyle(context, "Téléphone",
              "", Icon(Icons.phone_outlined, color: violet)),
        ),
      ),
    );
  }

  String _emailValidation(String value) {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if (!emailValid) {
      return "Veuillez entrez une adresse mail valide";
    } else {
      return null;
    }
  }

  Widget button(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(5)),
      width: MediaQuery.of(context).size.width * 0.6,
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

  Widget commandes(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ResponsiveFlutter.of(context).scale(10),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ChangePassPage(),
                  ),
                );
              },
              child: CommonStyles.rows(
                  "Changer le mot de passe", Icons.lock_open_rounded, context)),
          FlatButton(
              onPressed: null,
              child: CommonStyles.rows("Conditions d'utilisation",
                  Icons.rule_folder_outlined, context)),
          FlatButton(
              onPressed: launchURL,
              child: CommonStyles.rows(
                  "Centre d'appel", Icons.phone_in_talk_outlined, context)),
          FlatButton(
              onPressed: null,
              child: CommonStyles.rows("Deconnexion", Icons.logout, context)),
        ],
      ),
    );
  }
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
      "Profile",
      style: TextStyle(
        fontFamily: "Mom cake",
        fontSize: ResponsiveFlutter.of(context).fontSize(4),
        fontWeight: FontWeight.bold,
        color: Color(0xFF382B8C),
      ),
    ),
  );
}
