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
  const Part_3_5({Key key}) : super(key: key);

  @override
  _Part_3_5State createState() => _Part_3_5State();
}

class _Part_3_5State extends State<Part_3_5> {

  int assessmentId;
  int networkId;
  LinkedHashMap<String, int> routeArgs;

  String surveyQuestion;
  List<Question> distinctQuestions = List();


  @override
  void initState() {
    super.initState();
    getSurveyAnswers();
  }

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
                          question: '${distinctQuestions[index].question}',
                          answerable: true,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Part_2_4(assessmentId: assessmentId, evaluation: distinctQuestions, networkId: networkId),
                    ),
                  );
                }

            ),
        ],
        ),
      ),

    );

  }

  getSurveyAnswers() async {
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    List<Answer>surveyAnswers = await assessmentRepo.getSurveyAnswers();

    String questionNumber;


    List<Question> questions = List();
    for(Answer element in surveyAnswers){
      questionNumber = element.question_number;
      Question findQuestion = await assessmentRepo.findQuestion(questionNumber);
      questions.add(findQuestion);

      distinctQuestions = questions.toSet().toList();
    }


    distinctQuestions.forEach((element) {
      setState(() {
        surveyQuestion =  element.question;
      });

      print(surveyQuestion);
    });

    }
  }

