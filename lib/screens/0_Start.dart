

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
          Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CustomPaint(
              painter: CurvedShape(ThemeColors.greenShade1, ThemeColors.greenShade3),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.25,
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


          /*Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            color: Colors.red,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Kontakte mit anderen Menschen sind für uns alle lebenswichtig.",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),

            ),
          ),*/

        ],
      ),
    );
  }

}