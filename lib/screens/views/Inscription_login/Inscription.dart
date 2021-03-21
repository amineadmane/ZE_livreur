import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ze_livreur/provider/InscriptionProvider.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:ze_livreur/screens/views/Inscription_login/confirmSms.dart';
import 'package:ze_livreur/screens/views/Inscription_login/login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
            top: MediaQuery.of(context).size.height * 0.125,
            left: 10,
            right: 10,
            child: RegisterFormWidget(),
          )
        ],
      ),
    );
  }
}

class RegisterFormWidget extends StatefulWidget {
  @override
  _RegisterFormWidgetState createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  void _changephonenuber(BuildContext context, String phonenumber) {
    Provider.of<NavigationProvider>(context, listen: false)
        .changePhoneNumber(phonenumber);
  }

  void _changeLivreurExt(BuildContext context, String nom, String prenom,
      String eMail, String phoneNumber, String password) {
    Provider.of<InscriptionProvider>(context, listen: false).changeNom(nom);
    Provider.of<InscriptionProvider>(context, listen: false)
        .changePrenom(prenom);
    Provider.of<InscriptionProvider>(context, listen: false).changeeMail(eMail);
    Provider.of<InscriptionProvider>(context, listen: false)
        .changePhoneNumber(phoneNumber);
    Provider.of<InscriptionProvider>(context, listen: false)
        .changePassword(password);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _prenomameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  String email;
  String password;
  bool _isPasswordVisible = true;
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  var _emailController = TextEditingController(text: "test@test.com");
  var _nameController = TextEditingController(text: "test");
  var _prenomameController = TextEditingController(text: "test");
  var _numberController = TextEditingController(text: "0557081936");
  TextEditingController _passwordController =
      TextEditingController(text: "password");

  @override
  Widget build(context) {
    final node = FocusScope.of(context);

    return Container(
      child: ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Form(
              key: _formKey,
              autovalidateMode: _autoValidate,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.78,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: ListView(children: [
                    Column(
                      children: <Widget>[
                        _buildIntroText(),
                        _buildnamefield(context, node),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        _buildprenomfield(context, node),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        _buildtelfield(context, node),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        _buildemailfield(context, node),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        _buildPasswordField(context, node),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        _buildSignUpButton(context),
                        _buildconnexion(),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          ]),
    );
  }

  Widget _buildnamefield(context, node) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        controller: _nameController,
        onEditingComplete: () => node.nextFocus(),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.words,
        validator: (value) => _nameValidation(value),
        decoration: InputDecoration(
          labelText: "Nom",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: Icon(
            Icons.person,
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

  Widget _buildprenomfield(context, node) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        controller: _prenomameController,
        onEditingComplete: () => node.nextFocus(),
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        validator: (value) => _nameValidation(value),
        decoration: InputDecoration(
          labelText: "Prenom",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: Icon(
            Icons.accessibility_new,
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

  Widget _buildtelfield(context, node) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        controller: _numberController,
        onChanged: (value) => _numberController,
        onEditingComplete: () => node.nextFocus(),
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        validator: (value) => validateMobile(value),
        decoration: InputDecoration(
          labelText: "Numero de telephone",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: Icon(
            Icons.phone,
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

  Widget _buildemailfield(context, node) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        controller: _emailController,
        onEditingComplete: () => node.nextFocus(),
        keyboardType: TextInputType.emailAddress,
        onFieldSubmitted: (_) {
          node.unfocus();
        },
        validator: (value) => _emailValidation(value),
        decoration: InputDecoration(
          labelText: "Adresse E-mail",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: Icon(
            Icons.mail,
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

  Widget _buildSignUpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
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
                "Inscription",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _changephonenuber(context, _numberController.text);
                  _changeLivreurExt(
                      context,
                      _nameController.text,
                      _prenomameController.text,
                      _emailController.text,
                      _numberController.text,
                      _passwordController.text);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ConfirmSms(_numberController.text)));
                }
              }),
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
                  style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(4),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Livreur',
                      style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(4),
                          color: Color(0xFFDD6C30),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text(
                "en quelques cliques!",
                style: TextStyle(
                    fontSize: ResponsiveFlutter.of(context).fontSize(4),
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildconnexion() {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            "Deja inscrit ? ",
            style: TextStyle(
                fontSize: ResponsiveFlutter.of(context).fontSize(2),
                color: Colors.black),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        TextButton(
            child: Center(
              child: Text(
                " Connectez vous !",
                style: TextStyle(
                    fontSize: ResponsiveFlutter.of(context).fontSize(3),
                    color: Color(0xFFDD6C30),
                    fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()),
              );
            }),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context, node) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        controller: _passwordController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (_) {
          node.unfocus();
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

  String _emailValidation(String value) {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if (!emailValid) {
      return "Veuillez entrez une adresse mail valide";
    } else {
      return null;
    }
  }

  String _userNameValidation(String value) {
    if (value.isEmpty || value.length < 8) {
      return "Veuillez entrer un mot de passe valide";
    } else {
      return null;
    }
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Veuillez entrer votre numéro de téléphone';
    } else if (!regExp.hasMatch(value)) {
      return 'Veuillez entrer un numéro de téléphone valide';
    }
    return null;
  }

  String _nameValidation(String value) {
    bool nameValid = RegExp('[a-zA-Z]').hasMatch(value);
    if (value.length == 0) {
      return "Veuillez entrez votre nom";
    } else if (!nameValid) {
      return "Veuillez entrez un nom valide";
    } else {
      return null;
    }
  }
}
