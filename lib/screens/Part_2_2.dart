import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/resources/SlideUpFadeIn.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_2_3.dart';


class Part_2_2 extends StatefulWidget {

  final int assessmentId;
  final int networkId;

  const Part_2_2({
    Key key,
    this.assessmentId,
    this.networkId
  }) : super(key: key);

  @override
  _Part_2_2State createState() => _Part_2_2State();
}

class _Part_2_2State extends State<Part_2_2>{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                  subtitle: "Das möchte ich gerne besser können",
                  intro: "Wähle die Frage, die Dich am meisten anspricht und beantworte sie anschliessend.",
                  percent: 0.35,
              ),

              Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(18, 20, 18, 94),
                      child: Wrap(
                        children: [
                          SlideUpFadeIn(
                            0.5,
                            QuestionCard(
                              questionNumber: "2.2.1",
                              assessmentId: widget.assessmentId,
                            ),
                          ),
                          SlideUpFadeIn(
                            1,
                            QuestionCard(
                              questionNumber: "2.2.2",
                              assessmentId: widget.assessmentId,
                            ),
                          ),
                          SlideUpFadeIn(
                            1.5,
                            QuestionCard(
                              questionNumber: "2.2.3",
                              assessmentId: widget.assessmentId,
                            ),
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
                _next(context, widget.assessmentId, widget.networkId);
              }
          ),
        ],
        ),
      ),

    );

  }


  void _next(BuildContext context, int assessmentId, int networkId){
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Part_2_3(assessmentId: assessmentId, networkId: networkId);
        },
        transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return Align(
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }

}
