import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:ze_livreur/provider/request_provider.dart';
import 'package:ze_livreur/services/ApiCalls.dart';
import 'package:ze_livreur/services/maps.dart';

// ignore: must_be_immutable
class NotificationPage extends StatelessWidget {
  Color grey = Color(0xFF424242);
  Color grey2 = Color(0xFF646464);
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF4ED964);
  Color red = Color(0xFFFF3A32);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RequestProvider>(context, listen: false);
    print(provider.getpickup);
    return SafeArea(
      child: FutureBuilder(
          future: Maps.obtainPlaceDirectionsDetails(
              context, provider.getpickup, provider.getdropoff),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                backgroundColor: grey,
                body: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        offretext(context),
                        notiftext(context),
                        avatar(context, provider.getnom, provider.getprenom),
                        cout(
                            context,
                            (snapshot.data.distanceValue * 0.01)
                                .toStringAsFixed(0)),
                        destination(
                            context, provider.getpickup, provider.getdropoff),
                        buttons(context)
                      ],
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Text("Erreur");
            }
            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

Widget offretext(context) {
  return Container(
      margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
      child: Text(
        "offre\nde livraison",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: NotificationPage().background,
          fontFamily: "Mom cake",
          fontSize: ResponsiveFlutter.of(context).fontSize(7),
          fontWeight: FontWeight.bold,
        ),
      ));
}

Widget notiftext(context) {
  return Container(
      margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
      width: ResponsiveFlutter.of(context).wp(80),
      child: Text(
        "Vous avez une nouvelle offre de livraison, ne ratez pas l'opportunité !",
        style: TextStyle(
          color: NotificationPage().background,
          fontSize: ResponsiveFlutter.of(context).fontSize(2.3),
          fontWeight: FontWeight.w400,
        ),
      ));
}

Widget avatar(context, String nom, String prenom) {
  return Container(
    margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
    child: Column(
      children: [
        CircleAvatar(
          backgroundColor: NotificationPage().background,
          radius: ResponsiveFlutter.of(context).scale(50),
          child: Image(
            width: ResponsiveFlutter.of(context).scale(80),
            image: AssetImage("assets/images/avatar.png"),
          ),
        ),
        Text(
          nom + " " + prenom,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: NotificationPage().background,
            fontFamily: "Mom cake",
            fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget cout(context, String prix) {
  return Container(
    margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
    width: ResponsiveFlutter.of(context).wp(80),
    height: ResponsiveFlutter.of(context).hp(20),
    padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(10)),
    decoration: BoxDecoration(
      color: NotificationPage().background,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cout de livraison",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: NotificationPage().grey2,
            fontFamily: "Mom cake",
            fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          prix + " DA",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Mom cake",
            fontSize: ResponsiveFlutter.of(context).fontSize(7),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget destination(context, String pickup, String dropoff) {
  Size size = MediaQuery.of(context).size;
  double screenheight = size.height;
  double screenwidth = size.width;
  return Container(
    margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
    width: ResponsiveFlutter.of(context).wp(80),
    padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(10)),
    decoration: BoxDecoration(
      color: NotificationPage().background,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        SizedBox(
          width: ResponsiveFlutter.of(context).wp(15),
          child: Column(
            children: [
              CircleAvatar(
                radius: ResponsiveFlutter.of(context).scale(10),
                backgroundColor: NotificationPage().orange,
                child: CircleAvatar(
                  backgroundColor: NotificationPage().background,
                  radius: ResponsiveFlutter.of(context).scale(7),
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(2)),
                height: ResponsiveFlutter.of(context).hp(5),
                child: VerticalDivider(
                  thickness: 3,
                  color: NotificationPage().grey2,
                  indent: 3,
                  endIndent: 3,
                ),
              ),
              CircleAvatar(
                radius: ResponsiveFlutter.of(context).scale(10),
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  backgroundColor: NotificationPage().background,
                  radius: ResponsiveFlutter.of(context).scale(7),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenwidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "Kouba",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Mom cake",
                          fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                    Text(
                      "à 5min",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: NotificationPage().grey2,
                        fontFamily: "Mom cake",
                        fontSize: ResponsiveFlutter.of(context).fontSize(2),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    pickup,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: NotificationPage().grey2,
                      fontFamily: "Mom cake",
                      fontSize: ResponsiveFlutter.of(context).fontSize(2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                  child: Divider(
                thickness: 2,
                color: NotificationPage().grey2,
                endIndent: ResponsiveFlutter.of(context).scale(15),
              )),
              Text(
                "Djasr Kasentina",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Mom cake",
                  fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                dropoff,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: NotificationPage().grey2,
                  fontFamily: "Mom cake",
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buttons(context) {
  return Container(
    margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FlatButton(
            onPressed: () {
              Provider.of<Auth>(context, listen: false).changeauth("loggedin");
            },
            child: Container(
              width: ResponsiveFlutter.of(context).scale(100),
              height: ResponsiveFlutter.of(context).scale(50),
              decoration: BoxDecoration(
                  color: NotificationPage().red,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.remove_circle_outline_outlined,
                color: NotificationPage().background,
                size: ResponsiveFlutter.of(context).fontSize(5.5),
              ),
            )),
        FlatButton(
            onPressed: () async {
              var provider =
                  Provider.of<RequestProvider>(context, listen: false);
              var provideruser = Provider.of<Auth>(context, listen: false);

              FormData formdata = new FormData.fromMap({
                'id_client': 27,
                'id_colis': 1,
                'id_livreur': provideruser.livreurExt.idLivExt,
                'nomclient': provider.getnom + " " + provider.getprenom,
                'telephone': provider.gettel,
                'wilaya': 16,
                'commune': 1,
                'codePostal': "16330",
                'ditance_parcourous': 410.0,
                'note': 5,
                'commentaire': "Commentaire",
                'adresse': "adresse",
                'prix': provider.getprix,
              });
              await ApiCalls().AcceptLivraison(formdata);
              Provider.of<Auth>(context, listen: false).changeauth("delivring");
            },
            child: Container(
              width: ResponsiveFlutter.of(context).scale(100),
              height: ResponsiveFlutter.of(context).scale(50),
              decoration: BoxDecoration(
                  color: NotificationPage().green,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.check_circle_outline_outlined,
                color: NotificationPage().background,
                size: ResponsiveFlutter.of(context).fontSize(5.5),
              ),
            ))
      ],
    ),
  );
}
