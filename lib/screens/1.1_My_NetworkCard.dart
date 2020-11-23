import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/CheckBoxComponent.dart';
import 'package:ip5_selbsteinschaetzung/components/CurvedShape.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

class NetworkCard_Screen extends StatefulWidget {
  const NetworkCard_Screen({Key key}) : super(key: key);

  @override
  _NetworkCard_ScreenState createState() => _NetworkCard_ScreenState();
}

class _NetworkCard_ScreenState extends State<NetworkCard_Screen> {
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //background image
          Image.asset(
            "assets/background_image/gradient-grey.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),

          //custom curved shape (fills entire screen)
          Positioned(
            top: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              color: Colors.transparent,
              child: CustomPaint(
                painter: CurvedShape(
                    ThemeColors.greenShade1, ThemeColors.greenShade3),
              ),
            ),
          ),

          //assessment top titles
          Positioned(
            top: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
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
                          style: ThemeTexts.startAssessmentTitle),
                      TextSpan(
                          text: "Soziale Beziehungen",
                          style: ThemeTexts.startAssessmentSubtitle),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 300,
            left: 0,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: CheckBoxComponent(
                checkboxTitle: "Familie",
              ),
            ),
          ),

        ],
      ),
    );
  }
}
