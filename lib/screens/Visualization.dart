import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/CircleTrianlgePainter.dart';
import 'package:ip5_selbsteinschaetzung/components/importantPersonTile.dart';
import 'package:ip5_selbsteinschaetzung/components/personDialog.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';


//Screen 1.2
class Visualization extends StatefulWidget{

  const Visualization({
    Key key
  }) : super(key: key);

  _VisualizationState createState() => _VisualizationState();

}

class _VisualizationState extends State<Visualization>{

  int assessmentId;
  int networkId;
  LinkedHashMap<String, int> routeArgs;



  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //get passed arguments
    routeArgs = ModalRoute.of(context).settings.arguments;
    assessmentId = routeArgs["assessmentId"];
    networkId = routeArgs["networkId"];

    print("width: "+MediaQuery.of(context).size.width.toString());

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [

            //background image
            Image.asset(
              "assets/background_image/gradient-grey.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),


            //content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                TopBar(
                  title: "Wer ist mir wichtig?\nMeine Netzwerkkarte",
                  titleNumber: 1,
                  onClose: null,
                  subtitle: "Visualisierung",
                  percent: 0.2,
                  intro: "",
                ),

                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Center(
                        child: CustomPaint(
                          child: Container(
                            height: MediaQuery.of(context).size.width,
                          ),
                          painter: WheelPainter(
                            noAreas: 6,
                            widgetSize: MediaQuery.of(context).size.width-40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),

            //bottom navigation bar
            BottomNavigation(
              showNextButton: true,
              showBackButton: true,
              nextTitle: "Hey, das kann ich bereits!",
              callbackNext: (){
                _next(context, assessmentId, networkId);
              },
              callbackBack: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _next(BuildContext context, int assessmentId, int networkId) {


  }


}