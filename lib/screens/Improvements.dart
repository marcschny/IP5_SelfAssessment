import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/surveyBoxFilled.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/resources/FadeIn.dart';
import 'package:ip5_selbsteinschaetzung/resources/SlideUpFadeIn.dart';
import 'package:ip5_selbsteinschaetzung/screens/NameIt.dart';
import 'package:ip5_selbsteinschaetzung/screens/SurveyPart1.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';


//todo: validate: die Frage (die Projektbeschreibung) muss ausgefüllt sein
class Improvements extends StatefulWidget {

  final List<String> evaluation;
  final int assessmentId;
  final int visualizationId;

  const Improvements({Key key, this.assessmentId, this.evaluation, this.visualizationId}) : super(key: key);

  @override
  _ImprovementsState createState() => _ImprovementsState();
}

class _ImprovementsState extends State<Improvements>{


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
    return WillPopScope(
      onWillPop: (){},
      child: Scaffold(
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
                    subtitle: "Das möchte ich gerne können",
                    intro: "In den nächsten Wochen kannst Du Dich in einem Bereich verbessern, den Du gerne besser können willst. "
                        "In Deinem Veränderungsprojekt kannst Du dazu deine täglichen Erlebnisse eintragen.",
                    percent: 0.45,
                    showProgressbar: true,
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 2, 20, 74),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SlideUpFadeIn(
                            0.4,
                            130,
                            QuestionCard(
                              questionNumber: "2.4.1",
                              assessmentId: widget.assessmentId,
                            ),
                          ),

                          SizedBox(height: 24),

                          widget.evaluation == null ?
                              FadeIn(
                                2.2,
                                400,
                                Row(
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
                                      "Wenn Du hier irgendwie nicht weiter kommst, dann könntest Du den Fragebogen ausfüllen.",
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
                              FadeIn(
                                2.2,
                                500,
                                Padding(
                                padding: EdgeInsets.only(left: 34, top: 3),
                                child: RaisedButton(
                                  color: ThemeColors.greenShade4,
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                  onPressed: () {
                                    _goToQuestionnaire(context, widget.assessmentId, widget.visualizationId);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget> [
                                        Text(
                                          "Fragebogen",
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
                 showBackButton: false,
                 nextTitle: "Name it!",
                 callbackNext: (){
                   _next(context, widget.assessmentId, widget.visualizationId);
                 }
              ),


          ]
          ),
        ),

      ),
    );

  }


  _evaluationQuestionnaire(){
    return  Expanded(
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeIn(
                2.2,
                600,
                Text(
                  "Auswertung Fragebogen",
                  style: ThemeTexts.assessmentSubtitle.copyWith(color: ThemeColors.greenShade2),
                ),
              ),

              FadeIn(
                2.2,
                600,
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    widget.evaluation.length == 1 ? "An folgendem Punkt möchtest Du gerne am Veränderungsprojekt arbeiten:" : "An folgenden Punkten möchtest Du gerne am Veränderungsprojekt arbeiten:",
                    style: ThemeTexts.assessmentIntro,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),

              SizedBox(height: 20),

              Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.evaluation.length,
                  itemBuilder: (context, index) {
                    return SlideUpFadeIn(
                      2.8+(index*0.1),
                      20,
                      SurveyBoxFilled(
                        question: widget.evaluation[index],
                      ),
                    );
                  },

                ),
              ),


            ],
          ),
    )
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
          return NameIt(assessmentId: assessmentId, visualizationId: visualizationId);
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

  void _goToQuestionnaire(BuildContext context, int assessmentId, int visualizationId){
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return SurveyPart1(assessmentId: assessmentId, visualizationId: visualizationId);
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
