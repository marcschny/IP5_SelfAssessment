import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/surveyBox.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/answer.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/question.dart';
import 'package:provider/provider.dart';

import 'Part_2_4.dart';

class Part_3_5 extends StatefulWidget {

  final int assessmentId;
  final int networkId;

  const Part_3_5({Key key, this.assessmentId, this.networkId}) : super(key: key);

  @override
  _Part_3_5State createState() => _Part_3_5State();
}

class _Part_3_5State extends State<Part_3_5> {


  String surveyQuestion;

  Map<String, bool> distinctQuestions;


  @override
  void initState() {
    super.initState();
    distinctQuestions = Map();
    distinctQuestions.clear();
    getSurveyAnswers();
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
                subtitle: "Auswertung Fragebogen",
                intro: "Folgende Punkte sind Dir bisher weniger gut gelungen. "
                    " Wähle bis zu zwei davon aus, an welchen Du gerne als  Veränderungsprojekt arbeiten möchtest",
                percent: 0.55,
              ),


              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 94),
                    child: ListView.builder(
                      itemCount: distinctQuestions.length,
                      itemBuilder: (context, index) {

                          return new SurveyBox(
                          question: distinctQuestions.keys.elementAt(index),
                          checked: distinctQuestions.values.elementAt(index),
                          callback: (question){
                            _switchChecked(question);
                          }
                          );
                      },
                    ),
              ),

              ),
            ],
            ),

            BottomNavigation(
                showNextButton: true,
                showBackButton: true,
                nextTitle: "Lust auf etwas Neues?",
                callbackBack: () {
                  Navigator.of(context).pop();
                },
                callbackNext: () {
                  _next(context, widget.assessmentId, widget.networkId, distinctQuestions);
                }

            ),
        ],
        ),
      ),

    );

  }

  //switch checked state of question box
  _switchChecked(String question){
    distinctQuestions.forEach((key, value) {
      if(key == question){
        distinctQuestions.update(key, (value) => value ? false : true);
      }
    });
    setState(() { });
  }


  getSurveyAnswers() async {
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    List<Answer> surveyAnswers = await assessmentRepo.getSurveyAnswers(widget.assessmentId);

    String questionNumber;

    for(Answer element in surveyAnswers){
      questionNumber = element.question_number;
      Question findQuestion = await assessmentRepo.findQuestion(questionNumber);

      distinctQuestions.putIfAbsent(findQuestion.question, () => false);
    }

    setState(() {

    });

    }
  }

  //when next-button pressed
  _next(BuildContext context, int assessmentId, int networkId, Map questions) async{

  List<String> _selectedQuestions = List();
  _selectedQuestions.clear();

  //fill list with selected questions from map (values with bool true)
  questions.forEach((key, value) {
    if(value) _selectedQuestions.add(key);
  });

  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Part_2_4(assessmentId: assessmentId, evaluation: _selectedQuestions, networkId: networkId),
      ),
    );


  }

