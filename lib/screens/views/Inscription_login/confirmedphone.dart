import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ze_livreur/provider/InscriptionProvider.dart';
import 'package:ze_livreur/screens/views/Inscription_login/infovehicule.dart';

class ConfirmedphoneScreen extends StatefulWidget {
  @override
  _ConfirmedphoneScreenState createState() => _ConfirmedphoneScreenState();
}

class _ConfirmedphoneScreenState extends State<ConfirmedphoneScreen> {
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
            top: MediaQuery.of(context).size.height * 0.2,
            left: 10,
            right: 10,
            child: ConfirmedphoneWidget(),
          )
        ],
      ),
    );
  }
}

class ConfirmedphoneWidget extends StatefulWidget {
  @override
  _ConfirmedphoneWidgetState createState() => _ConfirmedphoneWidgetState();
}

class _ConfirmedphoneWidgetState extends State<ConfirmedphoneWidget> {
  void _changeCodeParrainage(BuildContext context, String _codeParrainage) {
    Provider.of<InscriptionProvider>(context, listen: false)
        .changeCodeParrainage(_codeParrainage);
  }

  void _changeExpireDate(BuildContext context, DateTime expireDate) {
    Provider.of<InscriptionProvider>(context, listen: false)
        .changeExpireDate(expireDate);
  }

  void _changeIdPermis(BuildContext context, String _idPermis) {
    Provider.of<InscriptionProvider>(context, listen: false)
        .changeIdPermis(_idPermis);
  }

  DateTime _selectedDate;
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _idPermisController = TextEditingController();

  bool checkedValue = false;
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();

  Color background = Color(0xFFF2F2F2);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);

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
          backgroundColor: Colors.transparent,
          body: ListView(
            children: <Widget>[
              _buildIntroText(),
              _buildreferencement(),
              _buildpermisconduire(),
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
                  "Veuillez continuer votre procedure",
                  style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                      color: Colors.black),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Center(
                child: Text(
                  "d'inscription",
                  style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                      color: Colors.black),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Center(
                child: Text(
                  "Referencement",
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

  Widget _buildreferencement() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Column(
        children: [
          CheckboxListTile(
            title:
                Text("Avez vous rejoint Ziouane Express sous referencement ?"),
            value: checkedValue,
            onChanged: (newValue) {
              setState(() {
                checkedValue = newValue;
              });
            },
          ),
          TextFormField(
            controller: _codeController,
            onChanged: (value) => _codeController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              enabled: checkedValue,
              labelText: checkedValue ? "Code de referencement" : "",
              labelStyle: TextStyle(color: Colors.black),
              alignLabelWithHint: true,
              contentPadding: EdgeInsets.symmetric(vertical: 5),
              prefixIcon: Icon(
                Icons.vpn_key,
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
        ],
      ),
    );
  }

  Widget _buildpermisconduire() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Numéro de Permis de conduire",
                  style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(3),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value.length == 0) {
                    return "Veuillez entrez une valeur";
                  } else {
                    return null;
                  }
                },
                controller: _idPermisController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Numero de permis de conduire",
                  labelStyle: TextStyle(color: Colors.black),
                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  prefixIcon: Icon(
                    Icons.article_sharp,
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Center(
                child: TextFormField(
                  validator: (value) {
                    if (value.length == 0) {
                      return "Veuillez entrez une date valide ";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Date d'expiration",
                    labelStyle: TextStyle(color: Colors.black),
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    suffixIcon: Icon(
                      Icons.calendar_today,
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
                  focusNode: AlwaysDisabledFocusNode(),
                  readOnly: true,
                  controller: _textEditingController,
                  onTap: () {
                    _selectDate(context);
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        useRootNavigator: false,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xFFDD6C30),
                onPrimary: Colors.white,
                surface: Color(0xFF480086),
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });
    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));

      _changeExpireDate(context, newSelectedDate);
    }
  }

  Widget _builbuttonbar(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: double.infinity,
        child: ButtonBar(
            children: [
              RaisedButton(
                  onPressed: () => Navigator.pop(context),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                  color: violet,
                  child: Text(
                    "Retour",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _changeCodeParrainage(context, _codeController.text);
                    _changeIdPermis(context, _idPermisController.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InfoVehiculeScreen(),
                        ));
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                color: violet,
                child: Text(
                  "Suivant",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
            alignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max));
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _codeController.dispose();
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
