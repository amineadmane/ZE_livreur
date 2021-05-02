import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/screens/views/Inscription_login/confirmedphone.dart';

// ignore: must_be_immutable
class ConfirmSms extends StatefulWidget {
  String phoneNumber;
  ConfirmSms(this.phoneNumber);
  String get _phoneNumber => this.phoneNumber;
  @override
  _ConfirmSmsState createState() => _ConfirmSmsState();
}

class _ConfirmSmsState extends State<ConfirmSms> {
  String _verificationCode;

  @override
  void initState() {
    super.initState();
    _verifyPhone(widget._phoneNumber);
  }

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
          top: MediaQuery.of(context).size.height * 0.2,
          left: 10,
          right: 10,
          child: ConfirmSMSForm(_verificationCode),
        )
      ],
    );
  }

  Future<void> _verifyPhone(String _phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+213$_phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfirmedphoneScreen()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }
}

// ignore: must_be_immutable
class ConfirmSMSForm extends StatefulWidget {
  String _verificationCode;
  ConfirmSMSForm(this._verificationCode);
  @override
  _ConfirmSMSFormState createState() => _ConfirmSMSFormState();
}

class _ConfirmSMSFormState extends State<ConfirmSMSForm> {
  Color background = Color(0xFFF2F2F2);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Color(0xFFF2F2F2),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Color(0xFF382B8C),
    ),
  );

  void _changeRenvoyer(context) {
    Provider.of<NavigationProvider>(context, listen: false)
        .changeRenvoyer(null);
  }

  CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              child: ListView(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  _buildIntroText(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  _buildSMSField(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  _buildsendback(context),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  _buildSignUpButton(context),
                ],
              ),
            ),
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
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.065,
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0)),
              color: Color(0xFF480086),
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
      ),
    );
  }

  Widget _buildIntroText() {
    var provider = Provider.of<NavigationProvider>(context);
    String _phonenumber = provider.phonenumber;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 5),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Vérification par ',
                  style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(4),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'SMS',
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
                  "Veuillez saisir le code de",
                  style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(3),
                      color: Colors.black),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Center(
                child: Text(
                  "vérification envoyé au :",
                  style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(3),
                      color: Colors.black),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Center(
                child: Text(
                  "$_phonenumber",
                  style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(4),
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

  Widget _buildsendback(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    bool _renvoyer = provider.renvoyer;
    String _phonenumber = provider.phonenumber;

    return Column(
      children: <Widget>[
        Center(
          child: Text(
            "Code non reçu ? ",
            style: TextStyle(
                fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                color: Colors.black),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Center(
          child: Container(
            width: ResponsiveFlutter.of(context).wp(60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularCountDownTimer(
                  duration: 10,
                  controller: _controller,
                  width: ResponsiveFlutter.of(context).wp(10),
                  height: ResponsiveFlutter.of(context).wp(10),
                  ringColor: Colors.grey[300],
                  ringGradient: null,
                  fillColor: Color(0xFF480086),
                  fillGradient: null,
                  backgroundColor: violet,
                  backgroundGradient: null,
                  strokeWidth: 20.0,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(
                      fontSize: 15,
                      color: background,
                      fontWeight: FontWeight.bold),
                  textFormat: CountdownTextFormat.S,
                  isReverse: true,
                  isReverseAnimation: true,
                  isTimerTextShown: true,
                  autoStart: true,
                  onComplete: () {
                    _changeRenvoyer(context);
                  },
                ),
                Container(
                  child: !_renvoyer
                      ? FlatButton(
                          child: Text(
                            " Renvoyez ! ",
                            style: TextStyle(
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(3),
                                color: background,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {})
                      : FlatButton(
                          child: Text(
                            " Renvoyez ! ",
                            style: TextStyle(
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(3),
                                color: Color(0xFFDD6C30),
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            _controller.restart();
                            _changeRenvoyer(context);
                            _ConfirmSmsState()._verifyPhone(_phonenumber);
                          }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSMSField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: PinPut(
        fieldsCount: 6,
        textStyle: TextStyle(
            fontSize: ResponsiveFlutter.of(context).fontSize(4.5),
            color: Color(0xFF382B8C)),
        eachFieldWidth: ResponsiveFlutter.of(context).scale(45),
        eachFieldHeight: ResponsiveFlutter.of(context).scale(55),
        focusNode: _pinPutFocusNode,
        controller: _pinPutController,
        submittedFieldDecoration: pinPutDecoration,
        selectedFieldDecoration: pinPutDecoration,
        followingFieldDecoration: pinPutDecoration,
        pinAnimationType: PinAnimationType.fade,
        onSubmit: (pin) async {
          try {
            await FirebaseAuth.instance
                .signInWithCredential(PhoneAuthProvider.credential(
                    verificationId: widget._verificationCode, smsCode: pin))
                .then((value) async {
              if (value.user != null) {
                _changeRenvoyer(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => ConfirmedphoneScreen()));
              }
            });
          } catch (e) {
            FocusScope.of(context).unfocus();
            _scaffoldkey.currentState
                .showSnackBar(SnackBar(content: Text('Code invalide')));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _pinPutController.dispose();
    super.dispose();
  }
}
