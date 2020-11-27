import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/expandableQuestionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';

import 'Part_3_4.dart';

class Part_3_3 extends StatefulWidget {
  const Part_3_3({Key key}) : super(key: key);

  @override
  _Part_3_3State createState() => _Part_3_3State();
}

class _Part_3_3State extends State<Part_3_3> {

  @override
  Widget build(BuildContext context) {
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
                title: "Ich und andere Menschen:  Wie ich bin und werden möchte II",
                titleNumber: 3,
                onClose: null,
                subtitle: "Fragebogen Themenblock 2",
                intro: "",
                percent: 0.55,
              ),


            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [

                    ExpandableQuestionCard(
                      question: "Jemanden nach dem Befinden fragen",
                      questionNumber: "3.3.1",
                      answered: false,
                    ),

                    ExpandableQuestionCard(
                      question: "Jemandem etwas Freundliches sagen/ein Kompliment machen",
                      questionNumber: "3.3.2",
                      answered: false,
                    ),

                    ExpandableQuestionCard(
                      question: "Gut zuhören",
                      questionNumber: "3.3.3",
                      answered: false,
                    ),

                    ExpandableQuestionCard(
                      question: "Jemandem etwas Wichtiges anvertrauen",
                      questionNumber: "3.3.4",
                      answered: false,
                    ),

                    ExpandableQuestionCard(
                      question: "Gemeinsam lachen",
                      questionNumber: "3.3.5",
                      answered: false,
                    ),

                    ExpandableQuestionCard(
                      question: "Auf eine Frage/ein Anliegen eingehen",
                      questionNumber: "3.3.6",
                      answered: false,
                    ),

                    ExpandableQuestionCard(
                      question: "Eigene Irritationen/Schwierigkeiten ansprechen",
                      questionNumber: "3.3.7",
                      answered: false,
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
                nextTitle: "Themenblock 3",
                callbackBack: () {
                  Navigator.of(context).pop();
                },

                callbackNext: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Part_3_4()));
                }

            ),
        ],
        ),
      ),


    );




  }
}
