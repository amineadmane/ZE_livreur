import 'package:flutter/material.dart';
import 'common_styles.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InfoVehiculeScreen extends StatefulWidget {
  @override
  _InfoVehiculeScreenState createState() => _InfoVehiculeScreenState();
}

class _InfoVehiculeScreenState extends State<InfoVehiculeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/Delivery.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height* 0.25,
          left: 10,
          right: 10,
          child: InfovehiculeWidget(),
        )
      ],
    );
  }
}

class InfovehiculeWidget extends StatefulWidget {
  @override
  _InfovehiculeWidgetState createState() => _InfovehiculeWidgetState();
}

class _InfovehiculeWidgetState extends State<InfovehiculeWidget> {
  TextEditingController _textEditingController = TextEditingController();
  bool checkedValue = false;
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.64,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.75),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              _buildIntroText(),
              _buildmatriculefield(),
              SizedBox(height : MediaQuery.of(context).size.height* 0.01),
              _buildmarquefield(),
              SizedBox(height : MediaQuery.of(context).size.height* 0.01),
              _buildmodelefield(),
              SizedBox(height : MediaQuery.of(context).size.height* 0.01),
              _builbuttonbar(context),
            ],
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
                  style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(4),color: Colors.black , fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(text: ' Confirmé', style : TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(4),color: Color(0xFFDD6C30) , fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height : MediaQuery.of(context).size.height* 0.03),
              Center(
                child: Text("Veuillez Introduire les informations", style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.5),color: Colors.black ),),
              ),
              SizedBox(height : MediaQuery.of(context).size.height* 0.01),
              Center(
                child: Text("de votre vehicule", style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.5),color: Colors.black ),),
              ),
              SizedBox(height : MediaQuery.of(context).size.height* 0.02),
              Center(
                child: Text("Informations Vehicule", style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: Colors.black , fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildmatriculefield()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Matricule",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: Icon(Icons.confirmation_number,color: Colors.black,size: 30,),
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
  Widget _buildmarquefield()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Marque",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: Icon(Icons.business,color: Colors.black,size: 30,),
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
  Widget _buildmodelefield()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: "Modele voiture",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: Icon(Icons.directions_car_sharp,color: Colors.black,size: 30,),
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
        padding: EdgeInsets.symmetric(horizontal: 15.0 , vertical: 10.0),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width* 0.35,
              height: MediaQuery.of(context).size.height* 0.065,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                  color: Color(0xFF480086),
                  child: Text(
                    "Retour",
                    style: TextStyle(
                        color:  Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  onPressed : (){
                  }
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width* 0.35,
              height: MediaQuery.of(context).size.height* 0.065,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                  color: Color(0xFF480086),
                  child: Text(
                    "Terminer",
                    style: TextStyle(
                        color:  Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  onPressed : (){
                  }
              ),
            ),
          ],
        )
    );
  }

}


