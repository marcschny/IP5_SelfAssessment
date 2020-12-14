import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_3_2.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

import 'Part_2_4.dart';

class Part_3_1 extends StatefulWidget {

  final int assessmentId;
  final int visualizationId;

  const Part_3_1({
    Key key,
    this.assessmentId,
    this.visualizationId
  }) : super(key: key);

  @override
  _Part_3_1State createState() => _Part_3_1State();
}

class _Part_3_1State extends State<Part_3_1> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children:[
          Image.asset(
          "assets/background_image/gradient-grey.png",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TopBar(
                  title: "Ich und andere Menschen:  Wie ich bin und werden möchte",
                  titleNumber: 3,
                  onClose: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context) => Part_2_4()));},
                  subtitle: "Fragebogen",
                  intro: "Auf den folgenden Screens erhälst Du jeweils  Fragen zu drei Themenblöcken, "
                  "welche Dir helfen  werden nach Abschluss des Fragebogens ein  mögliches Ziel für Dein Veränderungsprojekt zu finden. \n"
                  "Beantworte so viele Fragen wie möglich: \n\n"
                  "Wenn Dir etwas unwichtig ist oder dies andere  Menschen gar nicht machen,"
                  " kannst du die Frage  auslassen.Wenn Dir jedoch etwas wichtig ist oder Du es an anderen magst, kannst Du Deine "
                  "Beurteilung dazu abgeben.",
                  percent: 0.55,
                  ),


                  Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: RaisedButton(
                  color: ThemeColors.greenShade2,
                  padding: EdgeInsets.symmetric(vertical: 11, horizontal: 34),
                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(40)
                ),
                elevation: 5.0,
                child: Text(
                  "Los geht’s",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.8,
                  ),
                ),
                onPressed: (){
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Part_3_2()));
                  _next(context, widget.assessmentId, widget.visualizationId);
                },

              ),
              ),
            ],
          ),


        ],
        ),
      ),

    );

  }


  void _next(BuildContext context, int assessmentId, int visualizationId){
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Part_3_2(assessmentId: assessmentId, visualizationId: visualizationId);
        },
        transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return Align(
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }

}
