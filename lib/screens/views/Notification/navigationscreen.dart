import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ze_livreur/components/common_styles.dart';
import 'package:ze_livreur/screens/views/Notification/notificationscreen.dart';

class NavigationPage extends StatefulWidget {
  Color grey = Color(0xFF424242);
  Color grey2 = Color(0xFF646464);
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF4ED964);
  Color red = Color(0xFFFF3A32);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: NavigationPage().background,
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: ResponsiveFlutter.of(context).scale(10)),
          height: ResponsiveFlutter.of(context).hp(100),
          child: ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    top(context),
                    diveder(context),
                    middle(context),
                    diveder(context),
                    googlemap(context),
                    diveder(context),
                    bottom(context),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

Widget diveder(context) {
  return Container(
    child: Divider(
      color: NavigationPage().grey,
      thickness: 2,
    ),
  );
}

Widget middle(BuildContext context) {
  return Container(
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Container(
        padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(10)),
        height: ResponsiveFlutter.of(context).hp(12),
        decoration: CommonStyles.navigationboxes(),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                  text: "6 ",
                  style: TextStyle(
                      color: NavigationPage().background,
                      fontSize: ResponsiveFlutter.of(context).fontSize(5),
                      fontFamily: "Mom Cake",
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: "min",
                      style: TextStyle(
                          color: NavigationPage().background,
                          fontSize: ResponsiveFlutter.of(context).fontSize(4),
                          fontFamily: "Mom Cake",
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
            Text(
              "restantes",
              style: TextStyle(
                  color: NavigationPage().background,
                  fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                  fontFamily: "Mom Cake",
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(10)),
        height: ResponsiveFlutter.of(context).hp(12),
        decoration: CommonStyles.navigationboxes(),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                  text: "10 ",
                  style: TextStyle(
                      color: NavigationPage().background,
                      fontSize: ResponsiveFlutter.of(context).fontSize(5),
                      fontFamily: "Mom Cake",
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: "km",
                      style: TextStyle(
                          color: NavigationPage().background,
                          fontSize: ResponsiveFlutter.of(context).fontSize(4),
                          fontFamily: "Mom Cake",
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
            Text(
              "restants",
              style: TextStyle(
                  color: NavigationPage().background,
                  fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                  fontFamily: "Mom Cake",
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )
    ]),
  );
}

bottom(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(5)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () => Navigator.pop(context),
                child: Container(
                  width: ResponsiveFlutter.of(context).scale(100),
                  height: ResponsiveFlutter.of(context).scale(50),
                  decoration: BoxDecoration(
                      color: NotificationPage().red,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.remove_circle_outline_outlined,
                    color: NotificationPage().background,
                    size: ResponsiveFlutter.of(context).fontSize(5.5),
                  ),
                )),
            FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: null,
                child: Container(
                  width: ResponsiveFlutter.of(context).scale(100),
                  height: ResponsiveFlutter.of(context).scale(50),
                  decoration: BoxDecoration(
                      color: NotificationPage().green,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: NotificationPage().background,
                    size: ResponsiveFlutter.of(context).fontSize(5.5),
                  ),
                )),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: ResponsiveFlutter.of(context).scale(100),
              child: Text(
                "Annuler",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: NavigationPage().grey,
                  fontFamily: "Mom cake",
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: ResponsiveFlutter.of(context).scale(100),
              child: Text(
                "Commande\nreçue",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: NavigationPage().grey,
                  fontFamily: "Mom cake",
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget top(context) {
  void launchURL() async {
    const url = 'tel:+213771854123';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
          margin: EdgeInsets.all(ResponsiveFlutter.of(context).scale(3)),
          decoration: CommonStyles.navigationboxes(),
          width: ResponsiveFlutter.of(context).wp(73),
          height: ResponsiveFlutter.of(context).hp(12),
          child: ListTile(
            leading: SizedBox(
              width: ResponsiveFlutter.of(context).wp(20),
              child: CircleAvatar(
                backgroundColor: Color(0xFFF2F2F2),
                radius: ResponsiveFlutter.of(context).scale(100),
                child: Image(
                  width: ResponsiveFlutter.of(context).scale(50),
                  image: AssetImage("assets/images/avatar.png"),
                ),
              ),
            ),
            title: Text(
              "ziouane omar eddine",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: NavigationPage().background,
                fontFamily: "Mom cake",
                fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "(+213) 557 081 963",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: NavigationPage().background,
                fontFamily: "Mom cake",
                fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
      FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          launchURL();
        },
        child: Container(
          height: ResponsiveFlutter.of(context).hp(12),
          margin: EdgeInsets.all(ResponsiveFlutter.of(context).scale(3)),
          width: ResponsiveFlutter.of(context).wp(22),
          decoration: CommonStyles.navigationboxes(),
          child: Icon(
            Icons.phone_in_talk_outlined,
            color: NotificationPage().background,
            size: ResponsiveFlutter.of(context).scale(61),
          ),
        ),
      )
    ],
  );
}

Widget googlemap(context) {
  return Container(
    height: ResponsiveFlutter.of(context).hp(50),
    child: GoogleMap(
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
          target: LatLng(36.70879640846684, 3.08479366116213), zoom: 15),
    ),
  );
}
