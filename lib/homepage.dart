import 'package:flutter/material.dart';
import 'common_styles.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
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
         top: MediaQuery.of(context).size.height* 0.17,
         left: 10,
         right: 10,
         child: LoginFormWidget(),
       )
     ],
    );
  }
}
class LoginFormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginFormWidgetState();
  }
}

class _LoginFormWidgetState extends State<LoginFormWidget> with SingleTickerProviderStateMixin  {
  AnimationController animationController;
  bool _visiblelogo = false;
  bool _visibleform = false ;
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () { //asynchronous delay
      if (this.mounted) { //checks if widget is still active and not disposed
        setState(() { //tells the widget builder to rebuild again because ui has updated
          _visiblelogo=true; //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
        });
      }
    });
    Future.delayed(const Duration(seconds: 4), () { //asynchronous delay
      if (this.mounted) { //checks if widget is still active and not disposed
        setState(() { //tells the widget builder to rebuild again because ui has updated
          _visibleform=true; //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
        });
      }
    });

  }

  String email;
  String password;
  final _formKey = GlobalKey<FormState>();
  var _userEmailController = TextEditingController(text: "");
  var _userPasswordController = TextEditingController(text: "");
  var _emailFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();
  bool _isPasswordVisible = true;
  bool _autoValidate = false;


  var _index = 0;
  static const _alignment = Alignment.center;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        children: <Widget>[
          _buildLogo(),
          SizedBox(height : MediaQuery.of(context).size.height* 0.05),
          AnimatedOpacity(
            opacity: _visibleform ? 1.0 : 0.0,
            duration: Duration(seconds: 2),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.75),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(
                    children: <Widget>[
                      _buildIntroText(),
                      _buildEmailField(context),
                      SizedBox(height : MediaQuery.of(context).size.height* 0.02),
                      _buildPasswordField(context),
                      SizedBox(height : MediaQuery.of(context).size.height* 0.02),
                      _buildSignUpButton(context),
                      SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                      _buildinscription(),
                    ],
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroText() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 5),
          child: Text("Connexion", style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(4),color: Colors.black , fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
  Widget _buildinscription(){
    return Column(
      children: <Widget>[
        Center(
          child: Text("pas encore inscrit ? ", style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),color: Colors.black),
          ),
        ),
        SizedBox(height : MediaQuery.of(context).size.height* 0.01),
        Center(
          child: Text(" Rejoignez nous ! ",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: Color(0xFFDD6C30) , fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: AnimatedOpacity(
        opacity: _visiblelogo ? 1.0 : 0.0,
        duration: Duration(seconds: 2),
        child: Image.asset(
          "assets/images/Logo-ziouane-blanc.png",
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width*0.8,
        ),
      ),
    );
  }
  String _userNameValidation(String value) {
    if (value.isEmpty) {
      return "Veuillez entrer un mot de passe valide";
    } else {
      return null;
    }
  }

  Widget _buildEmailField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        controller: _userEmailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          email = value;
        },
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
        validator: (value) => _emailValidation(value),
        decoration: CommonStyles.textFormFieldStyle("Adresse mail", ""),
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

  Widget _buildPasswordField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        controller: _userPasswordController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_emailFocusNode);
        },
        onChanged: (value) {
          password = value;
        },
        validator: (value) => _userNameValidation(value),
        obscureText: _isPasswordVisible,
        decoration: InputDecoration(
          labelText: "Mot de passe",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              }),
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
              "Connexion",
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

  void _clearAllFields() {
    setState(() {
      _userEmailController = TextEditingController(text: "");
      _userPasswordController = TextEditingController(text: "");
    });
  }
}
