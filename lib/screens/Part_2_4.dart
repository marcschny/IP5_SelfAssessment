import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/surveyBox.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/question.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

import 'Part_3_1.dart';


class Part_2_4 extends StatefulWidget {

  final List<Question> evaluation;
  final int assessmentId;

  const Part_2_4({Key key, this.assessmentId, this.evaluation}) : super(key: key);

  @override
  _Part_2_4State createState() => _Part_2_4State();
}

class _Part_2_4State extends State<Part_2_4> {

  int assessmentId;
  int networkId;
  LinkedHashMap<String, int> routeArgs;

  @override
  Widget build(BuildContext context) {

    //get passed arguments
    routeArgs = ModalRoute.of(context).settings.arguments;
    assessmentId = routeArgs["assessmentId"];
    networkId = routeArgs["networkId"];

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

                        QuestionCard(
                          questionNumber: "2.4.1",
                          assessmentId: widget.assessmentId,
                        ),

                        SizedBox(height: 20),


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
                                widget.evaluation == null ? "Wenn Du hier irgendwie nicht weiter kommst, dann könntest Du den Fragekatalog ausfüllen." : "Der Fragekatalog wurde bereits ausgefüllt",
                                style: ThemeTexts.assessmentQuestion.copyWith(color: Colors.black26),
                                textAlign: TextAlign.start,
                                softWrap: true,
                                overflow: TextOverflow.clip,

                                ),
                            ),

                            ],
                        ),


                            widget.evaluation == null ? Padding(
                              padding: EdgeInsets.only(left: 34, top: 3),
                              child: RaisedButton(
                                color: ThemeColors.greenShade4,
                                elevation: 0,
                                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                onPressed: () {
                                  Navigator.of(context).pushNamed("/part_3_1", arguments: widget.assessmentId);
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
                            ) : Container(),

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
                 Navigator.of(context).pushNamed("/part_2_5", arguments: widget.assessmentId);
               }
            ),


        ]
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
              Text(
                "Auswertung Fragebogen",
                style: ThemeTexts.assessmentSubtitle.copyWith(color: ThemeColors.greenShade2),
              ),

              Container(
                  child: Text(
                      widget.evaluation.length == 1 ? "An folgendem Punkt möchtest Du gerne am Projekt arbeiten:" : "An folgenden Punkten möchtest Du gerne am Projekt arbeiten:",
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
                          return new SurveyBox(
                              question: '${widget.evaluation[index].question}',
                              answerable: false,
                          );
                        },

                      ),
                    ),

            ],
          ),
    );

  }


}
