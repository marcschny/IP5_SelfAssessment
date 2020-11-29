import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/expandableQuestionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';

import 'Part_3_5.dart';

class Part_3_4 extends StatefulWidget {
  const Part_3_4({Key key}) : super(key: key);

  @override
  _Part_3_4State createState() => _Part_3_4State();
}

class _Part_3_4State extends State<Part_3_4> {

  int assessmentId;

  @override
  Widget build(BuildContext context) {

    assessmentId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children:[
            Image.asset(
              //background image
              "assets/background_image/gradient-grey.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),

            Column(
            children: [
              TopBar(
                title: "Ich und andere Menschen:  Wie ich bin und werden möchte",
                titleNumber: 3,
                onClose: null,
                subtitle: "Kommunikation mit Mitmenschen",
                intro: "",
                percent: 0.55,
              ),


            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [

                    ExpandableQuestionCard(
                      question: "Freude über die Beziehung / das Gespräch zeigen",
                      questionNumber: "3.4.1",
                      answered: false,
                      assessmentId: assessmentId,
                    ),

                    ExpandableQuestionCard(
                      question: "Ansprechen, wie es weitergeht",
                      questionNumber: "3.4.2",
                      answered: false,
                      assessmentId: assessmentId,
                    ),

                    ExpandableQuestionCard(
                      question: "Jemandem ein Feedback geben",
                      questionNumber: "3.4.3",
                      answered: false,
                      assessmentId: assessmentId,
                    ),

                    ExpandableQuestionCard(
                      question: "Weitere Fragen formulieren",
                      questionNumber: "3.4.4",
                      answered: false,
                      assessmentId: assessmentId,
                    ),

                    ExpandableQuestionCard(
                      question: "Um ein weiteres Gespräch bitten",
                      questionNumber: "3.4.5",
                      answered: false,
                      assessmentId: assessmentId,
                    ),

                    ExpandableQuestionCard(
                      question: "Weitere Gesprächsmöglichkeiten ansprechen",
                      questionNumber: "3.4.6",
                      answered: false,
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
                nextTitle: "Auswertung",
                callbackBack: () {
                  Navigator.of(context).pop();
                },

                callbackNext: () {
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Part_3_5()));
                  Navigator.of(context).pushNamed("/part_3_5", arguments: assessmentId);
                }

            ),
        ],
        ),
      ),


    );




  }
}
