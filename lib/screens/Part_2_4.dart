import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';


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
        children:[ Column(
          children: [
            //background image
            /*   Image.asset(
            "assets/background_image/gradient-grey.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),*/
            TopBar(
                title: "Ich und andere Menschen:  Wie ich bin und werden möchte",
                titleNumber: 2,
                onClose: null,
                subtitle: "Lust auf etwas Neues!",
                intro: ""
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
                      onPressed: () {
                        // Respond to button press
                      },
                        child: Row(
                          children: <Widget> [
                            Text("Fragekatalog"),
                            Icon(Icons.arrow_right_alt_rounded, size: 30),
                          ],
                      //shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                    )
                    ),
                  ],
                ),

            ),

          ],
        ),
      ],
        ),
      ),

      bottomNavigationBar: BottomNavigation(
          showNextButton: true,
          showBackButton: true,
          nextTitle: "Name it!",
          callbackBack: () {
            Navigator.of(context).pop();
          },
          callbackNext: (){
            null;
           // Navigator.of(context).push(MaterialPageRoute(builder: (context) => NetworkCard_Screen()));
          }
      ),

    );

  }
}
