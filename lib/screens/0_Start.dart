

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/CurvedShape.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

class StartScreen extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //custom curved shape (fills entire screen)
          Positioned(
            top: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              color: Colors.transparent,
              child: CustomPaint(
                painter: CurvedShape(ThemeColors.greenShade1, ThemeColors.greenShade3),
              ),
            ),
          ),

          //assessment titles
          Positioned(
            top: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.25,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Center(
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Kurz Assessment\n",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "Soziale Beziehungen",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),


          //intro texts
          Positioned(
            top: MediaQuery.of(context).size.height*0.25+20,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Kontakte mit anderen Menschen sind für uns alle lebenswichtig.\n\n",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17
                      ),
                    ),
                    TextSpan(
                      text: "Hier kannst Du zunächst aufzeichnen, wer für Dich in Deinem Leben wichtig ist (das nennt sich: eine Netzwerkkarte zeichnen).\n\n",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17
                      ),
                    ),
                    TextSpan(
                      text: " Danach kannst Du herausfinden, was Du bereits sehr gut kannst im Umgang mit anderen Menschen und wo Du selber noch nicht so zufrieden bist mit Dir. \n\n",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17
                      ),
                    ),
                    TextSpan(
                      text: " Und dann startest Du Dein Veränderungsprojekt «Hey, das kann ich!»",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17
                      ),
                    ),
                  ],
                ),

              ),
            ),
          ),


          //start button
          Positioned(
            bottom: 40,
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: Center(
              child: RaisedButton(
                color: ThemeColors.greenShade2,
                padding: EdgeInsets.symmetric(vertical: 11, horizontal: 34),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
                ),
                elevation: 5.0,
                child: Text(
                  "Starten",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.8,
                  ),
                ),
                onPressed: (){},
              ),
            ),
          )


        ],
      ),
    );
  }

}