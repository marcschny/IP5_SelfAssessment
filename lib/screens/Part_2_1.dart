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
              //background image

              TopBar(
                title: "Ich und andere Menschen:  Wie ich bin und werden möchte",
                titleNumber: 2,
                onClose: null,
                subtitle: "Hey, das kann ich bereits!",
                intro: "Hier kannst Du Deine Stärken notieren! Tippe auf eine Frage um deine Antwort zu notieren",
                percent: 0.3,
              ),

              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                        child: Wrap(
                          children: [
                            QuestionCard(
                              questionNumber: "2.1.1",
                            ),

                            QuestionCard(
                              questionNumber: "2.1.2",
                            ),

                            QuestionCard(
                              questionNumber: "2.1.3",
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Part_2_2()));
                }

            ),
        ],
        ),
      ),


    );

  }
}
