import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/bottom_navigation.dart';
import 'package:ip5_selbsteinschaetzung/components/dialogs/visualization_dialog.dart';
import 'package:ip5_selbsteinschaetzung/components/question_card.dart';
import 'package:ip5_selbsteinschaetzung/components/top_bar.dart';
import 'package:ip5_selbsteinschaetzung/components/animations/fade_in.dart';
import 'package:ip5_selbsteinschaetzung/components/animations/slide_up_fade_in.dart';
import 'package:ip5_selbsteinschaetzung/components/animations/slide_up_from_bottom.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_4/change_project.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';


class WhoCanHelp extends StatefulWidget {

  final int assessmentId;
  final int visualizationId;

  const WhoCanHelp({
    Key key,
    this.assessmentId,
    this.visualizationId
  }) : super(key: key);

  @override
  _WhoCanHelpState createState() => _WhoCanHelpState();
}

class _WhoCanHelpState extends State<WhoCanHelp>{


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
                  subtitle: "Wer oder was hilft Dir dabei?",
                  intro: "Überlege Dir wer Dir bei Deinem Veränderungsprojekt helfen könnte und tippe auf die passende Frage um sie zu beantworten.",
                  percent: 0.55,
                  showProgressbar: true,
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 94),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SlideUpFadeIn(
                          0.5,
                          140,
                          QuestionCard(
                            questionNumber: "2.5.1",
                            assessmentId: widget.assessmentId,
                          ),
                        ),
                        SlideUpFadeIn(
                          0.7,
                          140,
                          QuestionCard(
                            questionNumber: "2.5.2",
                            assessmentId: widget.assessmentId,
                          ),
                        ),
                        SlideUpFadeIn(
                          0.9,
                          140,
                          QuestionCard(
                            questionNumber: "2.5.3",
                            assessmentId: widget.assessmentId,
                          ),
                        ),

                        SizedBox(height: 16),
                        FadeIn(
                          2.9,
                          600,
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
                                "Bei der Wahl Deiner Hilfspersonen könnte Dir Deine Visualisierung weiterhelfen.",
                                style: ThemeTexts.assessmentQuestion.copyWith(color: Colors.black26, fontSize: 15.4),
                                textAlign: TextAlign.start,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                        ),


                        FadeIn(
                          3.3,
                          800,
                          Padding(
                            padding: EdgeInsets.only(left: 32),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: ThemeColors.greenShade4,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                              highlightColor: ThemeColors.greenShade4,
                              splashColor: Colors.transparent,
                              focusElevation: 0,
                              highlightElevation: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.remove_red_eye_outlined,
                                    size: 20.5,
                                    color: Color.fromRGBO(80, 80, 80, 1),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    "Visualisierung anzeigen",
                                    style: ThemeTexts.assessmentDialogSubtitle.copyWith(color: Color.fromRGBO(80, 80, 80, 1), fontSize: 16.5, fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              onPressed: (){
                                showDialog(
                                  context: context,
                                  barrierColor: Colors.black.withOpacity(.3),
                                  child: SlideUpFromBottom(0, VisualizationDialog(assessmentId: widget.assessmentId, visualizationId: widget.visualizationId)),
                                );
                              },
                            ),
                          ),

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
              nextTitle: "Veränderungsprojekt",
              callbackBack: () {
                Navigator.of(context).pop();
              },
              callbackNext: (){
                print("Go to change project...");
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 200),
                    pageBuilder: (
                        BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return ChangeProject(assessmentId: widget.assessmentId,);
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
          ),
        ],
        ),
      ),

    );

  }
}
