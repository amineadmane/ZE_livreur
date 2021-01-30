import 'package:flutter/material.dart';
import 'common_styles.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
          top: MediaQuery.of(context).size.height* 0.2,
          left: 10,
          right: 10,
          child: RegisterFormWidget(),
        )
      ],
    );
  }
}
class RegisterFormWidget extends StatefulWidget {
  @override
  _RegisterFormWidgetState createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();
  var _userEmailController = TextEditingController(text: "");
  var _emailFocusNode = FocusNode();
  bool _autoValidate = false;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.75),
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: <Widget>[
                  _buildIntroText(),

                  _buildnamefield(),
                  SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                  _buildprenomfield(),
                  SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                  _buildtelfield(),
                  SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                  _buildemailfield(),
                  SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                  _buildSignUpButton(context),
                  _buildconnexion(),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildnamefield()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Nom",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: Icon(Icons.person,color: Colors.black,size: 30,),
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
  Widget _buildprenomfield()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Prenom",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: Icon(Icons.accessibility_new,color: Colors.black,size: 30,),
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
  Widget _buildtelfield()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: "Numero de telephone",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: Icon(Icons.phone,color: Colors.black,size: 30,),
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
  Widget _buildemailfield()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Adresse E-mail",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: Icon(Icons.mail,color: Colors.black,size: 30,),
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

  Widget _buildSignUpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: double.infinity,
        child: SizedBox(
          width: MediaQuery.of(context).size.width* 0.3,
          height: MediaQuery.of(context).size.height* 0.065,
          child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
              color: Color(0xFF480086),
              child: Text(
                "Inscription",
                style: TextStyle(
                    color:  Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              onPressed : (){
              }
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
                  text: 'Devenez ',
                  style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(4),color: Colors.black , fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(text: 'Livreur', style : TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(4),color: Color(0xFFDD6C30) , fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Text("en quelques cliques!", style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(4),color: Colors.black , fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildconnexion(){
    return Column(
      children: <Widget>[
        Center(
          child: Text("Deja inscrit ? ", style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),color: Colors.black),
          ),
        ),
        SizedBox(height : MediaQuery.of(context).size.height* 0.01),
        Center(
          child: Text(" Connectez vous ! ",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: Color(0xFFDD6C30) , fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}


