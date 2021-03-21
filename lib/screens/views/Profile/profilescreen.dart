import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/screens/views/Inscription_login/login.dart';
import 'package:ze_livreur/screens/views/Profile/changeNumber.dart';
import 'package:ze_livreur/screens/views/Profile/passchangescreen.dart';
import 'package:ze_livreur/components/common_styles.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void dispose() {
    _nomController.dispose();
    _emailController.dispose();
    _prenomController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  launchURL() async {
    const url = 'tel:+213771854123';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    final myProvider = Provider.of<Auth>(context, listen: false).livreurExt;

    super.initState();
    _nomController = TextEditingController(text: myProvider.nom);
    _prenomController = TextEditingController(text: myProvider.prenom);
    _emailController = TextEditingController(text: myProvider.eMail);
    _phoneController = TextEditingController(text: myProvider.phoneNumber);
  }

  bool changed = false;

  TextEditingController _nomController;
  TextEditingController _prenomController;
  TextEditingController _phoneController;
  TextEditingController _emailController;
  String _nom;
  String _prenom;
  String _phone;
  String _email;

  final _formKey = GlobalKey<FormState>();

  Color background = Color(0xFFF2F2F2);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Auth>(context, listen: false).livreurExt;
    _nom = provider.nom;
    _prenom = provider.prenom;
    _email = provider.eMail;
    _phone = provider.phoneNumber;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey,
        appBar: appbar(context),
        backgroundColor: background,
        body: ListView(
          shrinkWrap: true,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  avatar(context),
                  namefield(context, provider.nom),
                  prenomfield(context, provider.prenom),
                  phonefield(context, provider.phoneNumber),
                  emailfield(context, provider.eMail),
                  button(context),
                  commandes(context),
                ],
              ),
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

  Widget namefield(BuildContext context, String nom) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(10),
      decoration: CommonStyles.profilecontrainerdeco(),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: _nomController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          _nom = value;
          if (_nom != nom)
            changed = true;
          else
            changed = false;
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

  Widget prenomfield(BuildContext context, String prenom) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      decoration: CommonStyles.profilecontrainerdeco(),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: _prenomController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          _prenom = value;
          if (_prenom != prenom)
            changed = true;
          else
            changed = false;
        },
        decoration: CommonStyles.profileFormFieldStyle(context, "Prénom", "",
            Icon(Icons.person_outline_rounded, color: violet)),
      ),
    );
  }

  Widget emailfield(BuildContext context, String eMail) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      decoration: CommonStyles.profilecontrainerdeco(),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          _email = value;
          if (_email != eMail)
            changed = true;
          else
            changed = false;
        },
        decoration: CommonStyles.profileFormFieldStyle(context, "E-Mail", "",
            Icon(Icons.alternate_email_rounded, color: violet)),
      ),
    );
  }

  Widget phonefield(BuildContext context, String phoneNumber) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      decoration: CommonStyles.profilecontrainerdeco(),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Center(
        child: TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          validator: (value) => _emailValidation(value),
          onChanged: (value) {
            _phone = value;
            if (_phone != phoneNumber)
              changed = true;
            else
              changed = false;
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
          onPressed: () {
            if (this.changed) {
              if (_phone !=
                  Provider.of<Auth>(context, listen: false)
                      .livreurExt
                      .phoneNumber) {
                Provider.of<NavigationProvider>(context, listen: false)
                    .changeNom(_nomController.text);
                Provider.of<NavigationProvider>(context, listen: false)
                    .changePrenom(_prenomController.text);
                Provider.of<NavigationProvider>(context, listen: false)
                    .changeEMail(_emailController.text);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            ChangeNumberScreen(_phoneController.text)));
              } else {
                Map<String, dynamic> data = {
                  "nom": _nomController.text.toString(),
                  "prenom": _prenomController.text.toString(),
                  "e_mail": _emailController.text.toString(),
                  "phone_number": _phoneController.text.toString(),
                };
                Provider.of<Auth>(context, listen: false)
                    .changeLivreurInfo(context, data, _scaffoldkey);
              }
            } else {
              return null;
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
              onPressed: () async {
                await Provider.of<Auth>(context, listen: false).logout();
                if (Provider.of<Auth>(context, listen: false).authenticated ==
                    "loggedout") {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              },
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
