import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/bottom_navigation.dart';
import 'package:ip5_selbsteinschaetzung/components/question_card.dart';
import 'package:ip5_selbsteinschaetzung/components/survey_box_filled.dart';
import 'package:ip5_selbsteinschaetzung/components/top_bar.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/resources/animations/fade_in.dart';
import 'package:ip5_selbsteinschaetzung/resources/animations/slide_up_fade_in.dart';
import 'package:ip5_selbsteinschaetzung/screens/name_it.dart';
import 'package:ip5_selbsteinschaetzung/screens/survey_intro.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';


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
                    intro: "In den nächsten Wochen kannst Du Dich in einem Bereich verbessern, in dem Du gerne besser werden möchtest. Beschreibe dabei möglichst genau was Du erreichen möchtest.",
                    percent: 0.45,
                    showProgressbar: true,
                ),

                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 2, 16, 74),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            SlideUpFadeIn(
                              0.4,
                              130,
                              QuestionCard(
                                questionNumber: "2.3.1",
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
                                        "Falls Dir nichts einfällt, kannst Du auch den Fragebogen ausfüllen, um herauszufinden worin du noch besser werden könntest.",
                                        style: ThemeTexts.assessmentQuestion.copyWith(color: Colors.black26, fontSize: 15.4),
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

                  ),


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
    return  Flexible(
      fit: FlexFit.loose,
      child: Container(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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

                SizedBox(height: 16),

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
        ),
      )
    );

  }


  void _next(BuildContext context, int assessmentId, int visualizationId) async{
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    final answeredQuestion = await assessmentRepo.findAnswer('2.3.1', widget.assessmentId);

    if(answeredQuestion?.answer != null && answeredQuestion?.answer != ""){
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
    }else{
      showToast(
        "Du hast die Frage noch nicht beantwortet",
        context: context,
      );
    }

  }


  void _goToQuestionnaire(BuildContext context, int assessmentId, int visualizationId){
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return SurveyIntro(assessmentId: assessmentId, visualizationId: visualizationId);
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
