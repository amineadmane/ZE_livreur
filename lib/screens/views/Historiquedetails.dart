import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HistoriquePagescreen extends StatefulWidget {
  @override
  _HistoriquePagescreenState createState() => _HistoriquePagescreenState();
}

class _HistoriquePagescreenState extends State<HistoriquePagescreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenheight = size.height;
    double screenwidth = size.width;

    Color background = Color(0xFFF2F2F2);
    Color green = Color(0xFF25E879);
    Color darkgreen = Color(0xFF147406);
    Color orange = Color(0xFFF28322);
    Color violet = Color(0xFF382B8C);
    Color orangeclair = Color(0xFFEEA86B);
    bool status = false;
    return SafeArea(
        child: Stack(
          children: <Widget>[
            Container(     // Background
              child: Center(
                child: Text("Aout", style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
                    color: Colors.white),),),
              color: orangeclair,
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width,
            ),

            Container(),   // Required some widget in between to float AppBar

            Positioned(    // To take AppBar Size only
              top: MediaQuery.of(context).size.height * 0.09,
              left: MediaQuery.of(context).size.width*0.1,
              right: MediaQuery.of(context).size.width*0.1,
              child: AppBar(
                backgroundColor: Colors.white,
                leading: Icon(Icons.arrow_back, color: orangeclair,),
                primary: false,
                title: TextField(
                    decoration: InputDecoration(
                        hintText: "Rechercher",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey))),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search, color: orangeclair), onPressed: () {},),
                ],
              ),
            ),
            ListView(
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 16, right: 16, left: 16 , top:  MediaQuery.of(context).size.height * 0.175),
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
                    padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16 ,top: 16),
                    child: Column(
                      children: [
                        SizedBox(
                          child: Align(
                            alignment: Alignment.topRight,
                            child:  Text("11/06/2021",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.5),color: Colors.black , fontWeight: FontWeight.bold),),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: background,
                              backgroundImage:
                              AssetImage('assets/images/Avatar.png'),
                              radius: 30,
                            ),
                            SizedBox(
                              width: screenwidth * 0.1,
                            ),
                            Text("Ziouane Omar",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3.0),color: violet , fontWeight: FontWeight.bold),),
                          ],
                        ),
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
                      ],
                    ),
                  ),
                )
              ],
              ),
          ],
        ),
    );
  }
}
