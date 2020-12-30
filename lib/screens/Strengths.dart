import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/resources/SlideUpFadeIn.dart';
import 'package:ip5_selbsteinschaetzung/screens/Weaknesses.dart';


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

//todo: what if question was not answered?
//todo: add more intro text (mainly to fill screen)
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
                intro: "Hier kannst Du Deine Stärken notieren!",
                percent: 0.3,
                showProgressbar: true,
              ),

              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(18, 2, 18, 94),
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
                nextTitle: "Das möchte ich  gerne besser können",
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


