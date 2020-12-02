import 'dart:collection';

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
  int networkId;
  LinkedHashMap<String, int> routeArgs;

  @override
  Widget build(BuildContext context) {

    //get passed arguments
    routeArgs = ModalRoute.of(context).settings.arguments;
    assessmentId = routeArgs["assessmentId"];
    networkId = routeArgs["networkId"];

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
                padding: EdgeInsets.fromLTRB(20, 10, 20, 94),
                child: ListView(
                  children: [

                    ExpandableQuestionCard(
                      questionNumber: "3.4.1",
                      assessmentId: assessmentId,
                    ),

                    ExpandableQuestionCard(
                      questionNumber: "3.4.2",
                      assessmentId: assessmentId,
                    ),

                    ExpandableQuestionCard(
                      questionNumber: "3.4.3",
                      assessmentId: assessmentId,
                    ),

                    ExpandableQuestionCard(
                      questionNumber: "3.4.4",
                      assessmentId: assessmentId,
                    ),

                    ExpandableQuestionCard(
                      questionNumber: "3.4.5",
                      assessmentId: assessmentId,
                    ),

                    ExpandableQuestionCard(
                      questionNumber: "3.4.6",
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Part_3_5(assessmentId: assessmentId, networkId: networkId)));
                }

            ),
        ],
        ),
      ),


    );




  }
}
