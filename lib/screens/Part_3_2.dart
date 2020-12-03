import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/expandableQuestionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';

import 'Part_3_3.dart';



class Part_3_2 extends StatefulWidget {

  final int assessmentId;
  final int networkId;

  const Part_3_2({
    Key key,
    this.assessmentId,
    this.networkId
  }) : super(key: key);

  @override
  _Part_3_2State createState() => _Part_3_2State();
}

class _Part_3_2State extends State<Part_3_2> with SingleTickerProviderStateMixin{

  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    Timer(Duration(milliseconds: 800), (){
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }


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
                title: "Ich und andere Menschen:  Wie ich bin und werden möchte",
                titleNumber: 3,
                onClose: null,
                subtitle: "Kommunikation mit Mitmenschen",
                intro: "",
                percent: 0.55,
              ),


            Expanded(
              child: FadeTransition(
                opacity: _animationController,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 94),
                  child: ListView(
                    children: [

                      ExpandableQuestionCard(
                        questionNumber: "3.2.1",
                        assessmentId: widget.assessmentId,
                      ),

                      ExpandableQuestionCard(
                        questionNumber: "3.2.2",
                        assessmentId: widget.assessmentId,
                      ),

                      ExpandableQuestionCard(
                        questionNumber: "3.2.3",
                        assessmentId: widget.assessmentId,
                      ),

                      ExpandableQuestionCard(
                        questionNumber: "3.2.4",
                        assessmentId: widget.assessmentId,
                      ),

                      ExpandableQuestionCard(
                        questionNumber: "3.2.5",
                        assessmentId: widget.assessmentId,
                      ),

                      ExpandableQuestionCard(
                        questionNumber: "3.2.6",
                        assessmentId: widget.assessmentId,
                      ),

                  ],
                  ),
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
          return Part_3_3(assessmentId: assessmentId, networkId: networkId);
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
