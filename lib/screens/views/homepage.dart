import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:ze_livreur/components/header.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';

import 'Historiquedetails.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF25E879);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);
  bool _status ;

  void _changestatus(BuildContext context) {
    Provider.of<NavigationProvider>(context, listen: false).changestatus();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    _status = provider.getstatus;
    Size size = MediaQuery.of(context).size;
    double screenheight = size.height;
    double screenwidth = size.width;
    return Column(
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
                  padding:
                      const EdgeInsets.only(bottom: 16, right: 16, left: 16),
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
                            padding: EdgeInsets.all(0),
                            icon: Icon(
                              Icons.arrow_forward_rounded,
                              color: Color(0xFFF28322),
                            ),
                            onPressed: null,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "6:30 AM",
                            style: TextStyle(
                                color: violet,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "500 DA",
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
                            initialRating: 3,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            ignoreGestures: true,
                            itemCount: 5,
                            ratingWidget: RatingWidget(
                              full: Image(
                                  color: orange,
                                  image: AssetImage('assets/images/heart.png')),
                              half: Image(
                                  color: orange,
                                  image: AssetImage(
                                      'assets/images/heart_half.png')),
                              empty: Image(
                                  color: orange,
                                  image: AssetImage(
                                      'assets/images/heart_border.png')),
                            ),
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
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
                                color: violet,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "7",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                          color: violet),
                                    ),
                                    Text(
                                      "2.5",
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
                                  "Heures collectées",
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
                              color: violet,
                              icon: Icon(
                                Icons.arrow_forward_rounded,
                                color: violet,
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
                                                text: "1850 ",
                                                style: TextStyle(
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.bold,
                                                    color: violet),
                                                children: [
                                                  TextSpan(
                                                    text: "DA",
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
                                                text: "3500 ",
                                                style: TextStyle(
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.bold,
                                                    color: violet),
                                                children: [
                                                  TextSpan(
                                                    text: "DA",
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
    );
  }
}
