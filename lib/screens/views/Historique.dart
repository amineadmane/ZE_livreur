import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ze_livreur/components/curved_nav_bar.dart';

class HistoriquePage extends StatefulWidget {
  @override
  _HistoriquePageState createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF25E879);
  Color darkgreen = Color(0xFF147406);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);
  Color orangeclair = Color(0xFFEEA86B);
  bool status = false;
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
          children:<Widget> [
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
                  Icon(
                    Icons.person_pin,
                    color: background,
                    size: 45,
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

                      })
                ],
              ),
              Text(
                "Historique",
                style: TextStyle(
                  color: background,
                  fontSize: 50,
                  fontFamily: 'Mom cake',
                ),
              ),
            ],
          ),
        ),
            Flexible(
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
                      const EdgeInsets.only(bottom: 16, right: 16, left: 16 ,top: 16),
                      child: Row(
                        children: [
                          Center(
                            child: SizedBox(
                              child: Container(
                                width: screenwidth * 0.2,
                                height: screenheight *  0.1,
                                decoration: new BoxDecoration(
                                  color: orangeclair,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(child: Text("AOU",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: Colors.white , fontWeight: FontWeight.bold),),),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Nombres de livraisons : ',
                                    style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: violet),
                                    children: <TextSpan>[
                                      TextSpan(text: '14', style : TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: Colors.black , fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                                RichText(
                                  text: TextSpan(
                                    text: 'Distance parcourue : ',
                                    style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: violet),
                                    children: <TextSpan>[
                                      TextSpan(text: '1250km', style : TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: Colors.black , fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.1,
                            child: Align(
                              alignment: Alignment.topRight,
                              child:  Icon(
                                  Icons.arrow_forward_rounded,
                              ),
                            ),
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
                      padding:
                      const EdgeInsets.only(bottom: 16, right: 16, left: 16 ,top: 16),
                      child: Row(
                        children: [
                          Center(
                            child: SizedBox(
                              child: Container(
                                width: screenwidth * 0.2,
                                height: screenheight *  0.1,
                                decoration: new BoxDecoration(
                                  color: orangeclair,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(child: Text("Juil",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: Colors.white , fontWeight: FontWeight.bold),),),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Nombres de livraisons : ',
                                    style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: violet),
                                    children: <TextSpan>[
                                      TextSpan(text: '10', style : TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: Colors.black , fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                                RichText(
                                  text: TextSpan(
                                    text: 'Distance parcourue : ',
                                    style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: violet),
                                    children: <TextSpan>[
                                      TextSpan(text: '870km', style : TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: Colors.black , fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.1,
                            child: Align(
                              alignment: Alignment.topRight,
                              child:  Icon(
                                Icons.arrow_forward_rounded,
                              ),
                            ),
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
                      padding:
                      const EdgeInsets.only(bottom: 16, right: 16, left: 16 ,top: 16),
                      child: Row(
                        children: [
                          Center(
                            child: SizedBox(
                              child: Container(
                                width: screenwidth * 0.2,
                                height: screenheight *  0.1,
                                decoration: new BoxDecoration(
                                  color: orangeclair,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(child: Text("Juin",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: Colors.white , fontWeight: FontWeight.bold),),),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Nombres de livraisons : ',
                                    style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: violet),
                                    children: <TextSpan>[
                                      TextSpan(text: '14', style : TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: Colors.black , fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                                RichText(
                                  text: TextSpan(
                                    text: 'Distance parcourue : ',
                                    style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: violet),
                                    children: <TextSpan>[
                                      TextSpan(text: '1250km', style : TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: Colors.black , fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.1,
                            child: Align(
                              alignment: Alignment.topRight,
                              child:  Icon(
                                Icons.arrow_forward_rounded,
                              ),
                            ),
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
                      padding:
                      const EdgeInsets.only(bottom: 16, right: 16, left: 16 ,top: 16),
                      child: Row(
                        children: [
                          Center(
                            child: SizedBox(
                              child: Container(
                                width: screenwidth * 0.2,
                                height: screenheight *  0.1,
                                decoration: new BoxDecoration(
                                  color: orangeclair,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(child: Text("May",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: Colors.white , fontWeight: FontWeight.bold),),),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Nombres de livraisons : ',
                                    style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: violet),
                                    children: <TextSpan>[
                                      TextSpan(text: '14', style : TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: Colors.black , fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                                RichText(
                                  text: TextSpan(
                                    text: 'Distance parcourue : ',
                                    style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: violet),
                                    children: <TextSpan>[
                                      TextSpan(text: '1250km', style : TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: Colors.black , fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.1,
                            child: Align(
                              alignment: Alignment.topRight,
                              child:  Icon(
                                Icons.arrow_forward_rounded,
                              ),
                            ),
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
                      padding:
                      const EdgeInsets.only(bottom: 16, right: 16, left: 16 ,top: 16),
                      child: Row(
                        children: [
                          Center(
                            child: SizedBox(
                              child: Container(
                                width: screenwidth * 0.2,
                                height: screenheight *  0.1,
                                decoration: new BoxDecoration(
                                  color: orangeclair,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(child: Text("Avr",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: Colors.white , fontWeight: FontWeight.bold),),),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Nombres de livraisons : ',
                                    style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: violet),
                                    children: <TextSpan>[
                                      TextSpan(text: '14', style : TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: Colors.black , fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                                RichText(
                                  text: TextSpan(
                                    text: 'Distance parcourue : ',
                                    style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: violet),
                                    children: <TextSpan>[
                                      TextSpan(text: '1250km', style : TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: Colors.black , fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.1,
                            child: Align(
                              alignment: Alignment.topRight,
                              child:  Icon(
                                Icons.arrow_forward_rounded,
                              ),
                            ),
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
                      padding:
                      const EdgeInsets.only(bottom: 16, right: 16, left: 16 ,top: 16),
                      child: Row(
                        children: [
                          Center(
                            child: SizedBox(
                              child: Container(
                                width: screenwidth * 0.2,
                                height: screenheight *  0.1,
                                decoration: new BoxDecoration(
                                  color: orangeclair,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(child: Text("Mar",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(3),color: Colors.white , fontWeight: FontWeight.bold),),),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Nombres de livraisons : ',
                                    style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: violet),
                                    children: <TextSpan>[
                                      TextSpan(text: '14', style : TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: Colors.black , fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                SizedBox(height : MediaQuery.of(context).size.height* 0.01),
                                RichText(
                                  text: TextSpan(
                                    text: 'Distance parcourue : ',
                                    style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: violet),
                                    children: <TextSpan>[
                                      TextSpan(text: '1250km', style : TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),color: Colors.black , fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.1,
                            child: Align(
                              alignment: Alignment.topRight,
                              child:  Icon(
                                Icons.arrow_forward_rounded,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    )
    );
  }
}
