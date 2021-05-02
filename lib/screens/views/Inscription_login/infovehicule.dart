import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:flutter/services.dart';
import 'package:ze_livreur/provider/InscriptionProvider.dart';
import 'package:ze_livreur/provider/auth.dart';

class InfoVehiculeScreen extends StatefulWidget {
  @override
  _InfoVehiculeScreenState createState() => _InfoVehiculeScreenState();
}

class _InfoVehiculeScreenState extends State<InfoVehiculeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/Delivery.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: 10,
            right: 10,
            child: InfovehiculeWidget(),
          )
        ],
      ),
    );
  }
}

class InfovehiculeWidget extends StatefulWidget {
  @override
  _InfovehiculeWidgetState createState() => _InfovehiculeWidgetState();
}

class _InfovehiculeWidgetState extends State<InfovehiculeWidget> {
  bool checkedValue = false;
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  TextEditingController _matriculeController =
      TextEditingController(text: "102365214");
  TextEditingController _marqueController =
      TextEditingController(text: "Peugeot");
  TextEditingController _modeleController = TextEditingController(text: "206");
  TextEditingController _couleurController =
      TextEditingController(text: "noir");

  Color background = Color(0xFFF2F2F2);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.reference();

  void registerUser(
      String email, String password, String phone, String fullname) async {
    final user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;

    if (user != null) {
      Map userMap = {
        'fullname': fullname,
        'email': email,
        'phone': phone,
      };

      databaseRef.child('/drivers').push().set(userMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.75),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Scaffold(
          key: _scaffoldkey,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildIntroText(),
                _buildmatriculefield(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                _buildmarquefield(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                _buildmodelefield(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                _buildcouleurfield(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                _builbuttonbar(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntroText() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 5),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Telephone',
                  style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(4),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' Confirmé',
                      style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(4),
                          color: Color(0xFFDD6C30),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Center(
                child: Text(
                  "Veuillez Introduire les informations",
                  style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                      color: Colors.black),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Center(
                child: Text(
                  "de votre vehicule",
                  style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                      color: Colors.black),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Center(
                child: Text(
                  "Informations Vehicule",
                  style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(3),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildmatriculefield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        controller: _matriculeController,
        onChanged: (value) => _matriculeController,
        validator: (value) => validation(value, 1),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Matricule",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: Icon(
            Icons.confirmation_number,
            color: Colors.black,
            size: 30,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildmarquefield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        onChanged: (value) => _marqueController,
        controller: _marqueController,
        validator: (value) => validation(value, 2),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Marque",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: Icon(
            Icons.business,
            color: Colors.black,
            size: 30,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildmodelefield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        controller: _modeleController,
        onChanged: (value) => _modeleController,
        validator: (value) => validation(value, 3),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Modele voiture",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: Icon(
            Icons.directions_car_sharp,
            color: Colors.black,
            size: 30,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildcouleurfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        controller: _couleurController,
        onChanged: (value) => _couleurController,
        validator: (value) => validation(value, 4),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Couleur de voiture",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: Icon(
            Icons.color_lens_outlined,
            color: Colors.black,
            size: 30,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _builbuttonbar(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.065,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                  color: violet,
                  child: Text(
                    "Retour",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.065,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                  color: violet,
                  child: Text(
                    "Terminer",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    var provider = Provider.of<InscriptionProvider>(context,
                        listen: false);
                    Map livreurExt = {
                      'nom': Provider.of<InscriptionProvider>(context,
                              listen: false)
                          .nom,
                      'e_mail': Provider.of<InscriptionProvider>(context,
                              listen: false)
                          .eMail,
                      'prenom': Provider.of<InscriptionProvider>(context,
                              listen: false)
                          .prenom,
                      'phone_number': Provider.of<InscriptionProvider>(context,
                              listen: false)
                          .phoneNumber,
                      'id_permis': Provider.of<InscriptionProvider>(context,
                              listen: false)
                          .idPermis,
                      'password': Provider.of<InscriptionProvider>(context,
                              listen: false)
                          .password,
                      'expire_date': Provider.of<InscriptionProvider>(context,
                              listen: false)
                          .expireDate
                          .toString(),
                      'etat': 'bloque',
                      'matricule_vehicule': _matriculeController.text,
                      'modele_vehicule':
                          _marqueController.text + ' ' + _modeleController.text,
                      'couleur_vehicule': _couleurController.text,
                      'note': 0,
                      'points': 0,
                      'code_parrainage': Provider.of<InscriptionProvider>(
                              context,
                              listen: false)
                          .codeParrainage
                    };
                    if (_formKey.currentState.validate()) {
                      registerUser(provider.eMail, provider.password,
                          provider.phoneNumber, provider.nom + provider.prenom);
                      Provider.of<Auth>(context, listen: false)
                          .inscription(context, livreurExt, _scaffoldkey);
                    }
                  }),
            ),
          ],
        ));
  }

  String validation(String value, int cpt) {
    if (value.length == null) {
      switch (cpt) {
        case 1:
          return "Veuillez entrez un marticule valide";
          break;
        case 2:
          return "Veuillez entrez une marque valide";
          break;
        case 3:
          return "Veuillez entrez un modèle valide";
          break;
        case 4:
          return "Veuillez entrez une couleur valide";
          break;
      }
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    _marqueController.dispose();
    _matriculeController.dispose();
    _modeleController.dispose();
    _couleurController.dispose();
  }
}
