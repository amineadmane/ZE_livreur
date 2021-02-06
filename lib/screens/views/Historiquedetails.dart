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
    Color grey2 = Color(0xFF646464);
    bool status = false;
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: <Widget>[
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
                                AssetImage('assets/images/avatar.png'),
                                radius: 30,
                              ),
                              SizedBox(
                                width: screenwidth * 0.1,
                              ),
                              Flexible(child: Text("Boutouili Djillali" ,maxLines: 2,softWrap: true,overflow: TextOverflow.fade,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: violet , fontWeight: FontWeight.bold),)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "beni Messous",
                                style: TextStyle(color: Colors.black, fontSize: ResponsiveFlutter.of(context).fontSize(2.2) , fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: screenwidth * 0.02,
                              ),
                              CircleAvatar(
                                radius: ResponsiveFlutter.of(context).scale(10),
                                backgroundColor: orange,
                                child: CircleAvatar(
                                  backgroundColor: background,
                                  radius: ResponsiveFlutter.of(context).scale(7),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(2)),
                                  width: ResponsiveFlutter.of(context).wp(25),
                                  child: Divider(
                                    thickness: 3,
                                    color: grey2,
                                    indent: 3,
                                    endIndent: 3,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: ResponsiveFlutter.of(context).scale(10),
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  backgroundColor: background,
                                  radius: ResponsiveFlutter.of(context).scale(7),
                                ),
                              ),
                              SizedBox(
                                width: screenwidth * 0.02,
                              ),
                              Text(
                                "Bab ezzouar",
                                style: TextStyle(color: Colors.black, fontSize: ResponsiveFlutter.of(context).fontSize(2.2) , fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Center(
                            child: Divider(
                              thickness: 2,
                              color: orange,
                              indent: screenwidth*0.2,
                              endIndent: screenwidth*0.2,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "1560 DA",
                                style: TextStyle(color: Colors.black, fontSize: ResponsiveFlutter.of(context).fontSize(3.5) , fontWeight: FontWeight.bold),
                              ),
                              RatingBar(
                                itemSize: 17,
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
                      padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16 ,top: 16),
                      child: Column(
                        children: [
                          SizedBox(
                            child: Align(
                              alignment: Alignment.topRight,
                              child:  Text("01/06/2021",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.5),color: Colors.black , fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: background,
                                backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                                radius: 30,
                              ),
                              SizedBox(
                                width: screenwidth * 0.1,
                              ),
                              Flexible(child: Text("Admane Mohammed Amine" ,maxLines: 2,softWrap: true,overflow: TextOverflow.fade,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: violet , fontWeight: FontWeight.bold),)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Hydra",
                                style: TextStyle(color: Colors.black, fontSize: ResponsiveFlutter.of(context).fontSize(2.2) , fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: screenwidth * 0.02,
                              ),
                              CircleAvatar(
                                radius: ResponsiveFlutter.of(context).scale(10),
                                backgroundColor: orange,
                                child: CircleAvatar(
                                  backgroundColor: background,
                                  radius: ResponsiveFlutter.of(context).scale(7),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(2)),
                                  width: ResponsiveFlutter.of(context).wp(25),
                                  child: Divider(
                                    thickness: 3,
                                    color: grey2,
                                    indent: 3,
                                    endIndent: 3,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: ResponsiveFlutter.of(context).scale(10),
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  backgroundColor: background,
                                  radius: ResponsiveFlutter.of(context).scale(7),
                                ),
                              ),
                              SizedBox(
                                width: screenwidth * 0.02,
                              ),
                              Text(
                                "Kouba",
                                style: TextStyle(color: Colors.black, fontSize: ResponsiveFlutter.of(context).fontSize(2.2) , fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Center(
                            child: Divider(
                              thickness: 2,
                              color: orange,
                              indent: screenwidth*0.2,
                              endIndent: screenwidth*0.2,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "750 DA",
                                style: TextStyle(color: Colors.black, fontSize: ResponsiveFlutter.of(context).fontSize(3.5) , fontWeight: FontWeight.bold),
                              ),
                              RatingBar(
                                itemSize: 17,
                                initialRating: 4.5,
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
                                AssetImage('assets/images/avatar.png'),
                                radius: 30,
                              ),
                              SizedBox(
                                width: screenwidth * 0.1,
                              ),
                              Flexible(child: Text("Bouchafa demis" ,maxLines: 2,softWrap: true,overflow: TextOverflow.fade,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: violet , fontWeight: FontWeight.bold),)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Alger Centre",
                                style: TextStyle(color: Colors.black, fontSize: ResponsiveFlutter.of(context).fontSize(2.2) , fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: screenwidth * 0.02,
                              ),
                              CircleAvatar(
                                radius: ResponsiveFlutter.of(context).scale(10),
                                backgroundColor: orange,
                                child: CircleAvatar(
                                  backgroundColor: background,
                                  radius: ResponsiveFlutter.of(context).scale(7),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(2)),
                                  width: ResponsiveFlutter.of(context).wp(25),
                                  child: Divider(
                                    thickness: 3,
                                    color: grey2,
                                    indent: 3,
                                    endIndent: 3,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: ResponsiveFlutter.of(context).scale(10),
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  backgroundColor: background,
                                  radius: ResponsiveFlutter.of(context).scale(7),
                                ),
                              ),
                              SizedBox(
                                width: screenwidth * 0.02,
                              ),
                              Text(
                                "El Biar",
                                style: TextStyle(color: Colors.black, fontSize: ResponsiveFlutter.of(context).fontSize(2.2) , fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Center(
                            child: Divider(
                              thickness: 2,
                              color: orange,
                              indent: screenwidth*0.2,
                              endIndent: screenwidth*0.2,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "1000 DA",
                                style: TextStyle(color: Colors.black, fontSize: ResponsiveFlutter.of(context).fontSize(3.5) , fontWeight: FontWeight.bold),
                              ),
                              RatingBar(
                                itemSize: 17,
                                initialRating: 1.5,
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
                      padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16 ,top: 16),
                      child: Column(
                        children: [
                          SizedBox(
                            child: Align(
                              alignment: Alignment.topRight,
                              child:  Text("01/06/2021",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.5),color: Colors.black , fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: background,
                                backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                                radius: 30,
                              ),
                              SizedBox(
                                width: screenwidth * 0.1,
                              ),
                              Flexible(child: Text("Admane Mohammed Amine" ,maxLines: 2,softWrap: true,overflow: TextOverflow.fade,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: violet , fontWeight: FontWeight.bold),)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Hydra",
                                style: TextStyle(color: Colors.black, fontSize: ResponsiveFlutter.of(context).fontSize(2.2) , fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: screenwidth * 0.02,
                              ),
                              CircleAvatar(
                                radius: ResponsiveFlutter.of(context).scale(10),
                                backgroundColor: orange,
                                child: CircleAvatar(
                                  backgroundColor: background,
                                  radius: ResponsiveFlutter.of(context).scale(7),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(2)),
                                  width: ResponsiveFlutter.of(context).wp(25),
                                  child: Divider(
                                    thickness: 3,
                                    color: grey2,
                                    indent: 3,
                                    endIndent: 3,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: ResponsiveFlutter.of(context).scale(10),
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  backgroundColor: background,
                                  radius: ResponsiveFlutter.of(context).scale(7),
                                ),
                              ),
                              SizedBox(
                                width: screenwidth * 0.02,
                              ),
                              Text(
                                "Kouba",
                                style: TextStyle(color: Colors.black, fontSize: ResponsiveFlutter.of(context).fontSize(2.2) , fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Center(
                            child: Divider(
                              thickness: 2,
                              color: orange,
                              indent: screenwidth*0.2,
                              endIndent: screenwidth*0.2,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "750 DA",
                                style: TextStyle(color: Colors.black, fontSize: ResponsiveFlutter.of(context).fontSize(3.5) , fontWeight: FontWeight.bold),
                              ),
                              RatingBar(
                                itemSize: 17,
                                initialRating: 4.5,
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
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
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
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios_rounded, color: orangeclair),
                    onPressed: () => Navigator.pop(context)),
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
            ],
          ),
      ),
    );
  }
}
