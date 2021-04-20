import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ze_livreur/components/curved_nav_bar.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:ze_livreur/components/header.dart';
import 'package:ze_livreur/models/ParrainageModal.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:ze_livreur/services/ApiCalls.dart';
// ignore: must_be_immutable

class Parrainage extends StatefulWidget {
  @override
  _ParrainageState createState() => _ParrainageState();
}

class _ParrainageState extends State<Parrainage> {
  Future<void> share() async {
    await FlutterShare.share(
      title: 'Code de referencement',
      text: 'Ziouane Code refereneceent',
      linkUrl: 'https://flutter.dev/',
    );
  }

  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF25E879);
  Color darkgreen = Color(0xFF147406);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);
  Color orangeclair = Color(0xFFEEA86B);
  Color grey2 = Color(0xFF646464);
  bool status = false;

  Future<Parrainagemodel> _parrainage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Auth>(context, listen: false).livreurExt;
    Size size = MediaQuery.of(context).size;
    double screenheight = size.height;
    double screenwidth = size.width;
    return SafeArea(
        child: FutureBuilder(
            future: ApiCalls().getparrainage(provider.idLivExt),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scaffold(
                  backgroundColor: background,
                  body: Column(
                    children: <Widget>[
                      Header(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      RichText(
                        text: TextSpan(
                          text: 'Vous Avez : ',
                          style: TextStyle(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(3.0),
                              color: violet),
                          children: <TextSpan>[
                            TextSpan(
                              text: snapshot.data.points.toString(),
                              style: TextStyle(
                                  fontSize:
                                      ResponsiveFlutter.of(context).fontSize(6),
                                  color: violet,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: ' pts',
                              style: TextStyle(
                                  fontSize:
                                      ResponsiveFlutter.of(context).fontSize(3),
                                  color: violet),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                        "Invitez vos amis pour gagner plus",
                        style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(3),
                            color: violet),
                      ),
                      Text(
                        "de points et de surprises !",
                        style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(3),
                            color: violet),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Container(
                        height: screenheight * 0.3,
                        width: screenwidth * 0.9,
                        child: Image.asset(
                          'assets/images/Header.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: SizedBox(
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text("Votre code est : ",
                                    style: TextStyle(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(3),
                                        color: violet)))),
                      ),
                      Text(
                        snapshot.data.codeParrainage.toString(),
                        style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(6),
                            color: violet,
                            fontWeight: FontWeight.bold),
                      ),
                      Center(
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                            color: orangeclair,
                            child: Text(
                              "Partager",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      ResponsiveFlutter.of(context).fontSize(3),
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: share),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("Erreur");
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
