import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/bottom_navigation.dart';
import 'package:ip5_selbsteinschaetzung/components/question_card.dart';
import 'package:ip5_selbsteinschaetzung/components/top_bar.dart';
import 'package:ip5_selbsteinschaetzung/components/animations/slide_up_fade_in.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_2/weaknesses.dart';


//Screen 2.1
class Strengths extends StatefulWidget {

  final int assessmentId;
  final int visualizationId;

  const Strengths({
    Key key,
    this.assessmentId,
    this.visualizationId
  }) : super(key: key);

  @override
  _StrengthsState createState() => _StrengthsState();
}


class _StrengthsState extends State<Strengths>{

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
              //background image

              TopBar(
                title: "Ich und andere Menschen:  Wie ich bin und werden möchte",
                titleNumber: 2,
                subtitle: "Hey, das kann ich bereits!",
                intro: "Hier geht's um Deine Stärken und Dinge die Du bereits gut kannst!\nTippe auf die Frage um sie zu beantworten.",
                percent: 0.3,
                showProgressbar: true,
              ),

              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 2, 16, 94),
                  margin: EdgeInsets.only(top: 10),
                      child: SingleChildScrollView(
                        child: Wrap(
                          children: [
                            SlideUpFadeIn(
                              0.5,
                              140,
                              QuestionCard(
                                questionNumber: "2.1.1",
                                assessmentId: widget.assessmentId,
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
              nextTitle: "Damit habe ich noch Mühe",
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

  //go to next page
  void _next(BuildContext context, int assessmentId, int visualizationId){
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Weaknesses(assessmentId: assessmentId, visualizationId: visualizationId);
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


