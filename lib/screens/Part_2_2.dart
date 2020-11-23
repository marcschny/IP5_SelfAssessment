import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';

import 'Part_2_3.dart';

class Part_2_2 extends StatefulWidget {
  const Part_2_2({Key key}) : super(key: key);

  @override
  _Part_2_2State createState() => _Part_2_2State();
}

class _Part_2_2State extends State<Part_2_2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                subtitle: "Das möchte ich gerne besser können",
                intro: "Wähle die Frage aus, welche Dich am meisten anspricht  und beantworte sie anschliessend."
            ),

            Padding(
              padding: const EdgeInsets.all(20),
                child: Wrap(
                  children: [
                    QuestionCard(
                      questionNumber: "2.2.1",
                      question: "Was fällt Dir manchmal schwer im Umgang mit anderen Menschen?",
                      answered: false,
                    ),

                    QuestionCard(
                      questionNumber: "2.2.2",
                      question: "Wenn Du morgen früh aufwachst und im Umgang mit anderen so bist, wie Du es gerne hättest: "
                          "Wie wärst Du dann? Wie würdest Du Dich dann verhalten? ",
                      answered: false,
                    ),

                    QuestionCard(
                      questionNumber: "2.2.3",
                      question: "Wenn Du daran denkst, was für eine Person Du gerne wärst: Wie könnte das Motto dieser Person lauten?",
                      answered: false,
                    ),

                  ],
              ),
            ),


          ],
        ),
      ),

      bottomNavigationBar: BottomNavigation(
          showNextButton: true,
          showBackButton: true,
          nextTitle: "Jetzt packe ich es an!",
          callbackBack: () {
            Navigator.of(context).pop();
          },
          callbackNext: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Part_2_3()));
          }
      ),

    );

  }
}
