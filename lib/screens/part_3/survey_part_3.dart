import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/bottom_navigation.dart';
import 'package:ip5_selbsteinschaetzung/components/expandable_question_card.dart';
import 'package:ip5_selbsteinschaetzung/components/top_bar.dart';
import 'package:ip5_selbsteinschaetzung/components/animations/slide_up_fade_in.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_3/survey_evaluation.dart';


//Screen 3.4
class SurveyPart3 extends StatefulWidget {

  final int assessmentId;
  final int visualizationId;

  const SurveyPart3({
    Key key,
    this.assessmentId,
    this.visualizationId
  }) : super(key: key);

  @override
  _SurveyPart3State createState() => _SurveyPart3State();
}

class _SurveyPart3State extends State<SurveyPart3>{


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
                subtitle: "Kommunikation mit Mitmenschen",
                intro: "",
                percent: 0.55,
                showProgressbar: true,
              ),


            Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(18, 10, 18, 94),
                  child: ListView(
                    children: [


                      SlideUpFadeIn(
                        0.5,
                        100,
                        ExpandableQuestionCard(
                          questionNumber: "3.4.1",
                          assessmentId: widget.assessmentId,
                        ),
                      ),
                      SlideUpFadeIn(
                        0.9,
                        100,
                        ExpandableQuestionCard(
                          questionNumber: "3.4.2",
                          assessmentId: widget.assessmentId,
                        ),
                      ),
                      SlideUpFadeIn(
                        1.1,
                        100,
                        ExpandableQuestionCard(
                          questionNumber: "3.4.3",
                          assessmentId: widget.assessmentId,
                        ),
                      ),
                      SlideUpFadeIn(
                        1.3,
                        100,
                        ExpandableQuestionCard(
                          questionNumber: "3.4.4",
                          assessmentId: widget.assessmentId,
                        ),
                      ),
                      SlideUpFadeIn(
                        1.5,
                        100,
                        ExpandableQuestionCard(
                          questionNumber: "3.4.5",
                          assessmentId: widget.assessmentId,
                        ),
                      ),
                      SlideUpFadeIn(
                        1.6,
                        100,
                        ExpandableQuestionCard(
                          questionNumber: "3.4.6",
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
                nextTitle: "Auswertung",
                callbackBack: () {
                  Navigator.of(context).pop();
                },
                callbackNext: () {
                  _next(context, widget.assessmentId, widget.visualizationId);
                }

            ),
        ],
        ),
      ),
    );
  }


  void _next(BuildContext context, int assessmentId, int visualizationId){
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return SurveyEvaluation(assessmentId: assessmentId, visualizationId: visualizationId);
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
