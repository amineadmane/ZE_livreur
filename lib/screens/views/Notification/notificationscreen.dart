import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ze_livreur/provider/auth.dart';
import 'package:ze_livreur/provider/request_provider.dart';
import 'package:ze_livreur/services/ApiCalls.dart';
import 'package:ze_livreur/services/maps.dart';
import 'package:custom_timer/custom_timer.dart';

import '../../../globalvariabels.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final Color grey = Color(0xFF424242);
  final Color grey2 = Color(0xFF646464);
  final Color background = Color(0xFFF2F2F2);
  final Color green = Color(0xFF4ED964);
  final Color red = Color(0xFFFF3A32);
  final Color orange = Color(0xFFF28322);
  final Color violet = Color(0xFF382B8C);

  final CustomTimerController _controller = new CustomTimerController();
  var provider;
  var provideruser;

  void onFinish() {
    Provider.of<Auth>(this.context, listen: false)
        .changeAuthenticated("loggedin");
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<RequestProvider>(context, listen: false);
    provideruser = Provider.of<Auth>(context, listen: false);
    return SafeArea(
      child: FutureBuilder(
          future: Maps.obtainPlaceDirectionsDetails(
              context, provider.getpickup, provider.getdropoff),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                backgroundColor: grey,
                body: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: ResponsiveFlutter.of(context).scale(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      offretext(),
                      avatar(context, provider.getnom),
                      cout(context, (provider.getprix).toStringAsFixed(0)),
                      destination(
                        context,
                        provider.getpickup,
                        provider.getdropoff,
                        provider.getduration.toStringAsFixed(0),
                      ),
                      countDown(context, provider.seconds),
                      buttons(context),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Text(snapshot.error.toString());
            }
            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget offretext() {
    return Container(
        child: Text(
      "offre\nde livraison",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: background,
        fontFamily: "Mom cake",
        fontSize: ResponsiveFlutter.of(this.context).fontSize(7),
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
          textAlign: TextAlign.center,
          style: TextStyle(
            color: background,
            fontSize: ResponsiveFlutter.of(context).fontSize(2.3),
            fontWeight: FontWeight.w400,
          ),
        ));
  }

  Widget avatar(context, String nom) {
    return Container(
      margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: background,
            radius: ResponsiveFlutter.of(context).scale(50),
            child: Image(
              width: ResponsiveFlutter.of(context).scale(80),
              image: AssetImage("assets/images/avatar.png"),
            ),
          ),
          Text(
            nom,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: background,
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
      padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(10)),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cout de livraison",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: grey2,
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

  Widget destination(context, String pickup, String dropoff, String duration) {
    Size size = MediaQuery.of(context).size;
    double screenwidth = size.width;
    return Container(
      margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
      width: ResponsiveFlutter.of(context).wp(80),
      padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(10)),
      decoration: BoxDecoration(
        color: background,
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
                  backgroundColor: orange,
                  child: CircleAvatar(
                    backgroundColor: background,
                    radius: ResponsiveFlutter.of(context).scale(7),
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  height: ResponsiveFlutter.of(context).hp(5),
                  child: VerticalDivider(
                    thickness: 3,
                    color: grey2,
                    indent: 3,
                    endIndent: 3,
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
              ],
            ),
          ),
          Container(
            width: screenwidth * 0.58,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        provider.localityPickUp,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Mom cake",
                          fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: Text(
                            duration + " min",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: grey2,
                              fontFamily: "Mom cake",
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    pickup,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: grey2,
                      fontFamily: "Mom cake",
                      fontSize: ResponsiveFlutter.of(context).fontSize(2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    child: Divider(
                  thickness: 2,
                  color: grey2,
                  endIndent: ResponsiveFlutter.of(context).scale(15),
                )),
                Text(
                  provider.localityDropOff,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Mom cake",
                    fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    dropoff,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: grey2,
                      fontFamily: "Mom cake",
                      fontSize: ResponsiveFlutter.of(context).fontSize(2),
                      fontWeight: FontWeight.bold,
                    ),
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
                Provider.of<Auth>(context, listen: false)
                    .changeauth("loggedin");
              },
              child: Container(
                width: ResponsiveFlutter.of(context).scale(100),
                height: ResponsiveFlutter.of(context).scale(50),
                decoration: BoxDecoration(
                    color: red, borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  Icons.remove_circle_outline_outlined,
                  color: background,
                  size: ResponsiveFlutter.of(context).fontSize(5.5),
                ),
              )),
          FlatButton(
              onPressed: () async {
                acceptTrip(context);
                print('before accept');
                print('distance 3 :' + provider.getdistance.toString());
                FormData formdata = new FormData.fromMap({
                  'id_client': provider.idClient,
                  'id_livreur': provideruser.livreurExt.idLivExt,
                  'nomclient': provider.getnom,
                  'telephone': provider.gettel,
                  'ditance_parcourous': provider.getdistance,
                  'adresse': provider.getpickup,
                  'adresse_drop_off': provider.getdropoff,
                  'prix': provider.getprix,
                  'prix_promo': provider.prixPromo,
                  'locality_pick': provider.localityPickUp,
                  'locality_drop': provider.localityDropOff,
                  //colis
                  "valeur": provider.valeur,
                  "poids": provider.poids,
                  "fragilite": provider.fragilite,
                  "dimensions": provider.dimensions,
                });
                await ApiCalls().acceptLivraison(formdata);
                Provider.of<Auth>(context, listen: false)
                    .changeauth("delivring");
              },
              child: Container(
                width: ResponsiveFlutter.of(context).scale(100),
                height: ResponsiveFlutter.of(context).scale(50),
                decoration: BoxDecoration(
                    color: green, borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  Icons.check_circle_outline_outlined,
                  color: background,
                  size: ResponsiveFlutter.of(context).fontSize(5.5),
                ),
              ))
        ],
      ),
    );
  }

  Widget countDown(BuildContext context, int seconds) {
    return CustomTimer(
      controller: _controller,
      from: Duration(seconds: seconds),
      to: Duration(hours: 0),
      onBuildAction: CustomTimerAction.auto_start,
      onFinish: onFinish,
      builder: (CustomTimerRemainingTime remaining) {
        return Text(
          "${remaining.minutes}:${remaining.seconds}",
          style: TextStyle(
              color: background,
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveFlutter.of(context).fontSize(3.5)),
        );
      },
    );
  }

  void acceptTrip(BuildContext context) {
    String rideID = provider.getrideid;
    rideRef =
        FirebaseDatabase.instance.reference().child('rideRequest/$rideID');
    rideRef.child('status').set('accepted');
    rideRef.child('driver_name').set(
        provideruser.livreurExt.nom + " " + provideruser.livreurExt.prenom);
    rideRef.child('car_details').set(
        '${provideruser.livreurExt.couleurVehicule} - ${provideruser.livreurExt.modeleVehicule}');
    rideRef.child('driver_phone').set(provideruser.livreurExt.phoneNumber);
    rideRef.child('driver_id').set(provideruser.livreurExt.idLivExt);

    DatabaseReference historyRef = FirebaseDatabase.instance
        .reference()
        .child('drivers/${provideruser.livreurExt.idLivExt}/history/$rideID');
    historyRef.set(true);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
