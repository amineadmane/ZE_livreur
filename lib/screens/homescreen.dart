import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:ze_livreur/Models/Livraison_externe.dart';
import 'package:ze_livreur/components/curved_nav_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ze_livreur/components/header.dart';
import 'package:ze_livreur/models/Livraison_aujourdhui.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:ze_livreur/screens/views/Notification/notificationscreen.dart';
import 'package:ze_livreur/services/ApiCalls.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static String route = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF25E879);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);
  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Auth>(context,listen: false).livreurExt;
    Size size = MediaQuery.of(context).size;
    double screenheight = size.height;
    double screenwidth = size.width;
    return SafeArea(
      child: FutureBuilder(
        future: Future.wait([ApiCalls().getDerniereliv(provider.idLivExt), ApiCalls().getlivauj(provider.idLivExt)]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: background,
              body: Column(
                children: [
                  Header(),
                  Expanded(
                    child: ListView(
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: screenheight * 0.015,
                        ),
                        Container(
                          width: screenwidth * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(color: violet),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 16, right: 16, left: 16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Dernière livraison",
                                      style: TextStyle(color: violet, fontSize: 15),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_rounded,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                NotificationPage(),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                snapshot.data[0] == null ? "pas encore" : DateFormat("dd-MM HH:mm").format(DateTime.parse(snapshot.data[0].createdAt)),
                                      style: TextStyle(
                                          color: violet,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        snapshot.data[0] == null ? "0" : snapshot.data[0].prix.toString(),
                                      style: TextStyle(
                                          color: orange,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RatingBar(
                                      itemSize: 20,
                                      initialRating: snapshot.data[0].note.toDouble(),
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      ignoreGestures: true,
                                      itemCount: 5,
                                      ratingWidget: RatingWidget(
                                        full: Image(
                                            color: orange,
                                            image: AssetImage(
                                                'assets/images/heart.png')),
                                        half: Image(
                                            color: orange,
                                            image: AssetImage(
                                                'assets/images/heart_half.png')),
                                        empty: Image(
                                            color: orange,
                                            image: AssetImage(
                                                'assets/images/heart_border.png')),
                                      ),
                                      itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                      onRatingUpdate: (rating) {},
                                    ),
                                    Text(
                                      "Revenu estimé",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenheight * 0.015,
                        ),
                        Container(
                            width: screenwidth * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(color: violet),
                                ]),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 12, right: 16, left: 16),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Livraison d'aujourd'hui",
                                        style: TextStyle(color: violet, fontSize: 15),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_rounded,
                                        ),
                                        onPressed: null,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: screenwidth * 0.2,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data[1].livraisons==null ? "0":snapshot.data[1].livraisons.toString(),
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w500,
                                                    color: violet),
                                              ),
                                              Text(
                                                snapshot.data[1].distanceTotale == null ? "0" : snapshot.data[1].distanceTotale.toString(),
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w500,
                                                    color: violet),
                                              ),
                                              Text(
                                                "3.8",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w500,
                                                    color: violet),
                                              ),
                                            ],
                                          )),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Livraisons",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w400,
                                                color: orange),
                                          ),
                                          Text(
                                            "Distance parcourus",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w400,
                                                color: orange),
                                          ),
                                          Text(
                                            "Évaluation moyenne",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w400,
                                                color: orange),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ]))),
                        SizedBox(
                          height: screenheight * 0.015,
                        ),
                        Container(
                            width: screenwidth * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(color: violet),
                                ]),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10, right: 16, left: 16),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Finances d'aujourd'hui",
                                        style: TextStyle(color: violet, fontSize: 15),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_rounded,
                                        ),
                                        onPressed: null,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: screenwidth * 0.4,
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                    height: screenheight * 0.07,
                                                    child: RichText(
                                                      text: TextSpan(
                                                          text: (snapshot.data[1].prix) == null ? "0" : (double.parse(snapshot.data[1].prix)*0.8).toStringAsFixed(1),
                                                          style: TextStyle(
                                                              fontSize: 35,
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: violet),
                                                          children: [
                                                            TextSpan(
                                                              text: " DA",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  color: violet),
                                                            ),
                                                          ]),
                                                    )),
                                                SizedBox(
                                                    height: screenheight * 0.07,
                                                    child: RichText(
                                                      text: TextSpan(
                                                          text: snapshot.data[1].prix==null ? "0" : snapshot.data[1].prix.toString(),
                                                          style: TextStyle(
                                                              fontSize: 35,
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: violet),
                                                          children: [
                                                            TextSpan(
                                                              text: " DA",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  color: violet),
                                                            ),
                                                          ]),
                                                    )),
                                              ])),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: screenheight * 0.07,
                                            child: Text(
                                              "Revenu net\nestimé",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                  color: orange),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenheight * 0.07,
                                            child: Text(
                                              "Chiffre d'affaire\ncollecté",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                  color: orange),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ])))
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Text("Erreur");
          }

          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
