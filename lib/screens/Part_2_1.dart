import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';

import 'Part_2_2.dart';

class Part_2_1 extends StatefulWidget {
  const Part_2_1({Key key}) : super(key: key);

  @override
  _Part_2_1State createState() => _Part_2_1State();
}

class _Part_2_1State extends State<Part_2_1> {

  int assessmentId;


  @override
  Widget build(BuildContext context) {

    assessmentId = ModalRoute.of(context).settings.arguments;

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
              //background image

              TopBar(
                title: "Ich und andere Menschen:  Wie ich bin und werden möchte",
                titleNumber: 2,
                onClose: null,
                subtitle: "Hey, das kann ich bereits!",
                intro: "Wähle die Frage, die Dich am meisten anspricht und beantworte sie anschliessend.",
                percent: 0.3,
              ),

              Expanded(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(18, 20, 18, 94),
                        child: Wrap(
                          children: [
                            QuestionCard(
                              questionNumber: "2.1.1",
                              assessmentId: assessmentId,
                            ),

                            QuestionCard(
                              questionNumber: "2.1.2",
                              assessmentId: assessmentId,
                            ),

                            QuestionCard(
                              questionNumber: "2.1.3",
                              assessmentId: assessmentId,
                            ),
                          ],
                        ),
                      ),
              ),
                ],
            ),

            BottomNavigation(
                showNextButton: true,
                showBackButton: true,
                nextTitle: "Das möchte ich  gerne besser können",
                callbackBack: () {
                  Navigator.of(context).pop();
                },

                callbackNext: () {
                  Navigator.of(context).pushNamed("/part_2_2", arguments: assessmentId);
                }

            ),
          ],
        ),
      ),
    );

  }
}
