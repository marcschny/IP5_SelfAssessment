import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/surveyBox.dart';
import 'package:ip5_selbsteinschaetzung/components/surveyBoxFilled.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/resources/SlideUpFadeIn.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_2_5.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_3_1.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';



class Part_2_4 extends StatefulWidget {

  final List<String> evaluation;
  final int assessmentId;
  final int networkId;

  const Part_2_4({Key key, this.assessmentId, this.evaluation, this.networkId}) : super(key: key);

  @override
  _Part_2_4State createState() => _Part_2_4State();
}

class _Part_2_4State extends State<Part_2_4> with SingleTickerProviderStateMixin{

  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    Timer(Duration(milliseconds: 500), (){
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
              "assets/background_image/gradient-grey.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              TopBar(
                  title: "Ich und andere Menschen:  Wie ich bin und werden möchte",
                  titleNumber: 2,
                  onClose: null,
                  subtitle: "Lust auf etwas Neues!",
                  intro: "",
                  percent: 0.45,
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 94),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SlideUpFadeIn(
                          0.5,
                          QuestionCard(
                            questionNumber: "2.4.1",
                            assessmentId: widget.assessmentId,
                          ),
                        ),

                        SizedBox(height: 24),

                        widget.evaluation == null ?
                            SlideUpFadeIn(
                             2.5, Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: Icon(
                                      Icons.info_outline_rounded,
                                      size: 25,
                                      color: Colors.black26,
                                    )
                                ),
                                SizedBox(width: 10),

                                Expanded(
                                  child: Text(
                                    "Wenn Du hier irgendwie nicht weiter kommst, dann könntest Du den Fragekatalog ausfüllen.",
                                    style: ThemeTexts.assessmentQuestion.copyWith(color: Colors.black26),
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                    overflow: TextOverflow.clip,

                                  ),
                                ),

                              ],
                            )
                            )
                         : Container(),


                            widget.evaluation == null ?
                            SlideUpFadeIn(
                              2.5,
                              Padding(
                              padding: EdgeInsets.only(left: 34, top: 3),
                              child: RaisedButton(
                                color: ThemeColors.greenShade4,
                                elevation: 0,
                                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                onPressed: () {
                                  _goToQuestionnaire(context, widget.assessmentId, widget.networkId);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget> [
                                      Text(
                                        "Fragekatalog",
                                        style: ThemeTexts.assessmentText.copyWith(fontSize: 18),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                          Icons.arrow_forward,
                                          size: 20
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            )
                             : Container(),

                                SizedBox(height: 10),

                            widget.evaluation == null ? Container() : _evaluationQuestionnaire(),

                          ],

                        ),

                ),

              ),

                  SizedBox(height: 20),

              ],
            ),


            BottomNavigation(
               showNextButton: true,
               showBackButton: true,
               nextTitle: "Name it!",
               callbackBack: () {
                 Navigator.of(context).pop();
                 },
               callbackNext: (){
                 _next(context, widget.assessmentId, widget.networkId);
               }
            ),


        ]
        ),
      ),

    );

  }


  _evaluationQuestionnaire(){
    return  Expanded(
      child: SlideUpFadeIn(
        2.5,
        SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Auswertung Fragebogen",
                style: ThemeTexts.assessmentSubtitle.copyWith(color: ThemeColors.greenShade2),
              ),

              Container(
                padding: EdgeInsets.only(top: 4),
                  child: Text(
                      widget.evaluation.length == 1 ? "An folgendem Punkt möchtest Du gerne am Veränderungsprojekt arbeiten:" : "An folgenden Punkten möchtest Du gerne am Veränderungsprojekt arbeiten:",
                      style: ThemeTexts.assessmentIntro,
                      overflow: TextOverflow.clip,
                    ),
              ),

              SizedBox(height: 20),

              Container(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.evaluation.length,
                        itemBuilder: (context, index) {
                          return SurveyBoxFilled(
                            question: widget.evaluation[index],
                          );
                        },

                      ),
                    ),

            ],
          ),
    )
      )
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
          return Part_2_5(assessmentId: assessmentId, networkId: networkId);
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

  void _goToQuestionnaire(BuildContext context, int assessmentId, int networkId){
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Part_3_1(assessmentId: assessmentId, networkId: networkId);
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
