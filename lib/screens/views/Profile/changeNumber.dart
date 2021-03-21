import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/screens/views/Profile/profilescreen.dart';

class ChangeNumberScreen extends StatefulWidget {
  String phoneNumber;
  ChangeNumberScreen(@required this.phoneNumber);

  @override
  _ChangeNumberScreenState createState() => _ChangeNumberScreenState();
}

class _ChangeNumberScreenState extends State<ChangeNumberScreen> {
  Color background = Color(0xFFF2F2F2);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);
  Color grey = Color(0xFFBDBDBD);

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Color(0xFFF2F2F2),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Color(0xFF382B8C),
    ),
  );

  CountDownController _controller = CountDownController();

  bool _renvoyer;

  @override
  void initState() {
    super.initState();
    _verifyPhone(widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        _changeRenvoyer(context, false);
        _moveToSignInScreen(context);
      },
      child: Scaffold(
        key: _scaffoldkey,
        backgroundColor: background,
        appBar: appbar(context),
        body: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveFlutter.of(context).scale(15),
                    vertical: ResponsiveFlutter.of(context).scale(20)),
                child: Text(
                  'Veuillez introduire le code que vous avez reçu',
                  style: TextStyle(
                      color: violet,
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.3)),
                ),
              ),
              smsPin(),
              renvoyerSMS(),
            ],
          ),
        ),
      ),
    );
  }

  void _changeRenvoyer(BuildContext context, bool renvoyer) {
    if (renvoyer == null) {
      Provider.of<NavigationProvider>(context, listen: false)
          .changeRenvoyer(null);
    } else {
      Provider.of<NavigationProvider>(context, listen: false)
          .changeRenvoyer(renvoyer);
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
          onPressed: () {
            _changeRenvoyer(context, false);
            Navigator.pop(context);
          }),
      title: Text(
        "Verification",
        style: TextStyle(
          fontFamily: "Mom cake",
          fontSize: ResponsiveFlutter.of(context).fontSize(4),
          fontWeight: FontWeight.bold,
          color: Color(0xFF382B8C),
        ),
      ),
    );
  }

  Widget smsPin() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveFlutter.of(context).scale(15),
          vertical: ResponsiveFlutter.of(context).scale(20)),
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
                    verificationId: _verificationCode, smsCode: pin))
                .then((value) async {
              if (value.user != null) {
                _changeRenvoyer(context, false);
                Map data = {
                  "nom": Provider.of<NavigationProvider>(context, listen: false)
                      .nom,
                  "prenom":
                      Provider.of<NavigationProvider>(context, listen: false)
                          .prenom,
                  "phone_number": widget.phoneNumber,
                  "e_mail":
                      Provider.of<NavigationProvider>(context, listen: false)
                          .eMail,
                };
                await Provider.of<Auth>(context, listen: false)
                    .changeLivreurInfo(context, data, _scaffoldkey);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
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

  Widget renvoyerSMS() {
    var provider = Provider.of<NavigationProvider>(context);
    _renvoyer = provider.renvoyer;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveFlutter.of(context).scale(15),
          vertical: ResponsiveFlutter.of(context).scale(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircularCountDownTimer(
            duration: 75,
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
                fontSize: 15, color: background, fontWeight: FontWeight.bold),
            textFormat: CountdownTextFormat.S,
            isReverse: true,
            isReverseAnimation: true,
            isTimerTextShown: true,
            autoStart: true,
            onComplete: () {
              _changeRenvoyer(context, null);
            },
          ),
          Container(
            child: !_renvoyer
                ? FlatButton(
                    child: Text(
                      " Renvoyez ! ",
                      style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(3),
                          color: grey,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {})
                : FlatButton(
                    child: Text(
                      "Renvoyez !",
                      style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(3),
                          color: Color(0xFFDD6C30),
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      _changeRenvoyer(context, null);
                      _controller.restart();
                      _verifyPhone(widget.phoneNumber);
                    }),
          ),
        ],
      ),
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
              _changeRenvoyer(context, false);
              Map<String, dynamic> data = {
                "nom":
                    Provider.of<NavigationProvider>(context, listen: false).nom,
                "prenom":
                    Provider.of<NavigationProvider>(context, listen: false)
                        .prenom,
                "phone_number": widget.phoneNumber,
                "e_mail":
                    Provider.of<NavigationProvider>(context, listen: false)
                        .eMail,
              };
              Provider.of<Auth>(context, listen: false)
                  .changeLivreurInfo(context, data, _scaffoldkey);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
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
        timeout: Duration(seconds: 60));
  }

  void _moveToSignInScreen(BuildContext context) => Navigator.pop(context);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pinPutController.dispose();
  }
}
