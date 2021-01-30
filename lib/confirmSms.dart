import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'common_styles.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:flutter/services.dart';
class ConfirmSms extends StatefulWidget {
  @override
  _ConfirmSmsState createState() => _ConfirmSmsState();
}

class _ConfirmSmsState extends State<ConfirmSms> {
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
          top: MediaQuery.of(context).size.height* 0.3,
          left: 10,
          right: 10,
          child: ConfirmSMSForm(),
        )
      ],
    );
  }
}

class ConfirmSMSForm extends StatefulWidget {
  @override
  _ConfirmSMSFormState createState() => _ConfirmSMSFormState();
}

class _ConfirmSMSFormState extends State<ConfirmSMSForm> {

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.75),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              SizedBox(height : MediaQuery.of(context).size.height* 0.01),
              _buildIntroText(),
              SizedBox(height : MediaQuery.of(context).size.height* 0.01),
              _buildSMSField(),
              SizedBox(height : MediaQuery.of(context).size.height* 0.02),
              _buildsendback(),
              SizedBox(height : MediaQuery.of(context).size.height* 0.03),
              _buildSignUpButton(context),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildSignUpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                "Retour",
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
                  text: 'Verification par ',
                  style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(4),color: Colors.black , fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(text: 'SMS', style : TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(4),color: Color(0xFFDD6C30) , fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height : MediaQuery.of(context).size.height* 0.03),
              Center(
                child: Text("Veuillez saisir le code de", style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: Colors.black ),),
              ),
              SizedBox(height : MediaQuery.of(context).size.height* 0.01),
              Center(
                child: Text("verification envoye au ", style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: Colors.black ),),
              ),
              SizedBox(height : MediaQuery.of(context).size.height* 0.01),
              Center(
                child: Text("0561403441", style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(4),color: Colors.black, fontWeight: FontWeight.bold ),),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildsendback(){
    return Column(
      children: <Widget>[
        Center(
          child: Text("Code non recu ? ", style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.5),color: Colors.black),
          ),
        ),
        SizedBox(height : MediaQuery.of(context).size.height* 0.01),
        Center(
          child: Text(" Renvoyez ! ",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: Color(0xFFDD6C30) , fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
  Widget _buildSMSField()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.height* 0.07,
            decoration: new BoxDecoration(
                color: Colors.white,
            ),
            child: TextFormField(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: Color(0xFFDD6C30) , fontWeight: FontWeight.bold,),
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
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
          ),
          SizedBox(width : MediaQuery.of(context).size.width* 0.08),
          Container(
            width: MediaQuery.of(context).size.height* 0.07,
            decoration: new BoxDecoration(
              color: Colors.white,
            ),
            child: TextFormField(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: Color(0xFFDD6C30) , fontWeight: FontWeight.bold,),
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
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
          ),
          SizedBox(width : MediaQuery.of(context).size.width* 0.08),
          Container(
            width: MediaQuery.of(context).size.height* 0.07,
            decoration: new BoxDecoration(
              color: Colors.white,
            ),
            child: TextFormField(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: Color(0xFFDD6C30) , fontWeight: FontWeight.bold,),
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
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
          ),
          SizedBox(width : MediaQuery.of(context).size.width* 0.08),
          Container(
            width: MediaQuery.of(context).size.height* 0.07,
            decoration: new BoxDecoration(
              color: Colors.white,
            ),
            child: TextFormField(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: Color(0xFFDD6C30) , fontWeight: FontWeight.bold,),
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
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
          ),
        ],
      ),
    );
  }
}




