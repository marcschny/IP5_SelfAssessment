import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/expandableQuestionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';

import 'Part_3_3.dart';

class Part_3_2 extends StatefulWidget {
  const Part_3_2({Key key}) : super(key: key);

  @override
  _Part_3_2State createState() => _Part_3_2State();
}

class _Part_3_2State extends State<Part_3_2> {

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
                      question: "Ein Gespräch anfangen/andere ansprechen",
                      questionNumber: "3.2.1",
                      answered: false,
                      assessmentId: assessmentId,
                    ),

                    ExpandableQuestionCard(
                      question: "In einer mir bekannten Gruppe etwas sagen / eine Idee vorbringen",
                      questionNumber: "3.2.2",
                      answered: false,
                      assessmentId: assessmentId,
                    ),

                    ExpandableQuestionCard(
                      question: "In einer mir unbekannten Gruppe etwas sagen / eine Idee hervorbringen",
                      questionNumber: "3.2.3",
                      answered: false,
                      assessmentId: assessmentId,
                    ),

                    ExpandableQuestionCard(
                      question: "Etwas Lustiges sagen oder machen, andere zum Lachen bringen",
                      questionNumber: "3.2.4",
                      answered: false,
                      assessmentId: assessmentId,
                    ),

                    ExpandableQuestionCard(
                      question: "Jemanden anlächeln / einen Blick zuwerfen",
                      questionNumber: "3.2.5",
                      answered: false,
                      assessmentId: assessmentId,
                    ),

                    ExpandableQuestionCard(
                      question: "Jemanden neugierig machen / Interesse wecken",
                      questionNumber: "3.2.6",
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
                nextTitle: "Themenblock 2",
                callbackBack: () {
                  Navigator.of(context).pop();
                },

                callbackNext: () {
                 //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Part_3_3()));
                 Navigator.of(context).pushNamed("/part_3_3", arguments: assessmentId);
                }

            ),
        ],
        ),
      ),


    );




  }
}
