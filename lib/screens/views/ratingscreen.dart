import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ze_livreur/components/curved_nav_bar.dart';
import 'package:ze_livreur/screens/views/Profile/profilescreen.dart';

class RatingsPage extends StatefulWidget {
  @override
  _RatingsPageState createState() => _RatingsPageState();
}

class _RatingsPageState extends State<RatingsPage> {
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF25E879);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);
  Color grey = Color(0xFF424242);

  bool status = false;

  List<String> chauffeurs = [
    "Ziouane mehdi",
    "Boutouili djilali",
    "Yessad Samy",
    "Mekaoui mehdi",
    "Azzouz baha eddine",
    "Chemsou Maameri"
  ];
  List<double> notes = [4.5, 3.5, 5, 3, 2.5, 1];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenheight = size.height;
    double screenwidth = size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        bottomNavigationBar: BottomNavBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: orange,
              height: screenheight * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ProfilePage(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.person_pin,
                          color: background,
                          size: 45,
                        ),
                      ),
                      SizedBox(
                        width: screenwidth * 0.3,
                      ),
                      FlutterSwitch(
                          value: status,
                          width: 60,
                          height: 25,
                          valueFontSize: 12.0,
                          toggleSize: screenheight * 0.025,
                          borderRadius: 30.0,
                          padding: 4.0,
                          showOnOff: true,
                          activeText: "ON",
                          inactiveText: "OFF",
                          activeColor: green,
                          inactiveTextColor: violet,
                          inactiveColor: background,
                          onToggle: (val) {
                            setState(() {
                              status = val;
                            });
                          })
                    ],
                  ),
                  Text(
                    "evaluations",
                    style: TextStyle(
                      color: background,
                      fontSize: 50,
                      fontFamily: 'Mom cake',
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: ResponsiveFlutter.of(context).scale(16)),
                      child: Center(
                        child: Text(
                          "3.5",
                          style: TextStyle(
                              color: violet,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(7),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(child: ratingbar(context)),
                    ),
                    Container(
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: notes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return box(
                                context, chauffeurs[index], notes[index]);
                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ratingbar(context) {
    return RatingBar(
      itemSize: ResponsiveFlutter.of(context).fontSize(4.5),
      initialRating: 3.5,
      direction: Axis.horizontal,
      allowHalfRating: true,
      ignoreGestures: true,
      itemCount: 5,
      ratingWidget: RatingWidget(
        full:
            Image(color: orange, image: AssetImage('assets/images/heart.png')),
        half: Image(
            color: orange, image: AssetImage('assets/images/heart_half.png')),
        empty: Image(
            color: orange, image: AssetImage('assets/images/heart_border.png')),
      ),
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      onRatingUpdate: (rating) {},
    );
  }

  Widget box(BuildContext context, String chauffeur, double note) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: ResponsiveFlutter.of(context).scale(8),
            vertical: ResponsiveFlutter.of(context).scale(8)),
        padding: EdgeInsets.symmetric(
            vertical: ResponsiveFlutter.of(context).scale(5)),
        decoration: BoxDecoration(
            color: Colors.white, border: Border.all(color: grey, width: 2)),
        child: ListTile(
          leading: Container(
            width: ResponsiveFlutter.of(context).wp(15),
            child: CircleAvatar(
              radius: ResponsiveFlutter.of(context).scale(42),
              backgroundColor: grey,
              child: CircleAvatar(
                radius: ResponsiveFlutter.of(context).scale(25),
                backgroundColor: Color(0xFFF2F2F2),
                child: Image(
                  width: ResponsiveFlutter.of(context).scale(40),
                  image: AssetImage("assets/images/avatar.png"),
                ),
              ),
            ),
          ),
          title: Text(
            chauffeur,
            style: TextStyle(
              color: violet,
              fontFamily: "Mom cake",
              fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "Très professionnel de votre part, Merci",
              style: TextStyle(
                color: violet,
                fontSize: ResponsiveFlutter.of(context).fontSize(2),
              ),
            ),
          ),
          trailing: Text(
            note.toString(),
            style: TextStyle(
                color: orange,
                fontSize: ResponsiveFlutter.of(context).fontSize(5),
                fontWeight: FontWeight.bold),
          ),
        ));
  }
}
