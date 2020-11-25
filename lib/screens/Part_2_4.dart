import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_2_5.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

import 'Part_3_1.dart';

class Part_2_4 extends StatefulWidget {
  const Part_2_4({Key key}) : super(key: key);

  @override
  _Part_2_4State createState() => _Part_2_4State();
}

class _Part_2_4State extends State<Part_2_4> {

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
              children: [
              TopBar(
                  title: "Ich und andere Menschen:  Wie ich bin und werden möchte",
                  titleNumber: 2,
                  onClose: null,
                  subtitle: "Lust auf etwas Neues!",
                  intro: "",
                  percent: 0.45,
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                  child: Wrap(
                    children: [
                      QuestionCard(
                        questionNumber: "2.4.1",
                        question: "Was ganz konkret möchtest Du in den nächsten zwei bis drei Wochen ausprobieren?",
                        answered: false,
                      ),

                      Row(
                        children: [
                        Icon(Icons.info_outline_rounded),
                          Flexible(
                            child: RichText(
                              textAlign: TextAlign.start,
                              softWrap: true,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Wenn Du hier irgendwie nicht weiter kommst, dann könntest Du den Fragekatalog ausfüllen.",
                                    style: ThemeTexts.assessmentQuestion,
                                    ),
                                  ],
                                ),
                              ),
                          ),
                      ],
                      ),

                      RaisedButton(
                        textColor: Colors.black,
                        color: ThemeColors.greenShade4,
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {
                          // Respond to button press
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Part_3_1()));
                        },
                          child: Row(
                            children: <Widget> [
                              Text("Fragekatalog"),
                              Icon(Icons.arrow_right_alt_rounded, size: 20),
                            ],
                      )
                      ),
                    ],
                  ),
              ),
          ],
        ),


              BottomNavigation(
                  showNextButton: true,
                  showBackButton: true,
                  nextTitle: "Name it!",
                  callbackBack: () {
                    Navigator.of(context).pop();
                    },
                  callbackNext: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Part_2_5()));
                  }
              ),
        ],
        ),
      ),

    );

  }
}
