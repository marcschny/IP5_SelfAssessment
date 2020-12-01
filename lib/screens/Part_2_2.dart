import 'dart:collection';

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
                  subtitle: "Das möchte ich gerne besser können",
                  intro: "Wähle die Frage, die Dich am meisten anspricht und beantworte sie anschliessend.",
                  percent: 0.35,
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18, 20, 18, 94),
                    child: Wrap(
                      children: [
                        QuestionCard(
                          questionNumber: "2.2.1",
                          assessmentId: assessmentId,
                        ),

                        QuestionCard(
                          questionNumber: "2.2.2",
                          assessmentId: assessmentId,
                        ),

                        QuestionCard(
                          questionNumber: "2.2.3",
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
              nextTitle: "Jetzt packe ich es an!",
              callbackBack: () {
                Navigator.of(context).pop();
              },
              callbackNext: (){
                Navigator.of(context).pushNamed(
                    "/part_2_3",
                    arguments: <String, int>{
                      "assessmentId": assessmentId,
                      "networkId": networkId
                    }
                );
              }
          ),
        ],
        ),
      ),

    );

  }
}
