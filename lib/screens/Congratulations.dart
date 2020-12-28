/*
*
* Lottie animation received from:  https://lottiefiles.com
* check licence
* > todo: will be done in main app later
*
* */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/screens/Evaluation.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:lottie/lottie.dart';


class Congratulations extends StatefulWidget{

  final int assessmentId;

  Congratulations({Key key, this.assessmentId}) : super(key: key);

  @override
  _CongratulationsState createState() => _CongratulationsState();
}

class _CongratulationsState extends State<Congratulations> with TickerProviderStateMixin {
  AnimationController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = AnimationController(vsync: this, duration: Duration(milliseconds: 6000));
    Future.delayed(Duration(milliseconds: 500), _startAnimation);
    Future.delayed(Duration(milliseconds: 5100), _goToEvaluation);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  _startAnimation() async{
    _confettiController.forward(from: 0);
  }

  _goToEvaluation() async{
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Evaluation(assessmentId: widget.assessmentId);
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


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){},
      child: Scaffold(
        body: Stack(
          children: [

            //background image
            Image.asset(
              "assets/background_image/gradient-grey.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),

            _confettiAnimation(context),


            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Gratulation!",
                    style: ThemeTexts.startAssessmentTitle.copyWith(fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Du hast Dein Veränderungsprojekt abgeschlossen.",
                    style: ThemeTexts.assessmentText.copyWith(fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );

  }

 _confettiAnimation(context){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Lottie.asset(
        "assets/lottie/confetti.json",
        repeat: false,
        reverse: false,
        animate: true,
        alignment: Alignment.center,
        controller: _confettiController
      ),
    );
 }
}