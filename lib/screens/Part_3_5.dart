import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/expandableQuestionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/answer.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/question.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';

import 'Part_2_2.dart';
import 'Part_2_4.dart';

class Part_3_5 extends StatefulWidget {
  const Part_3_5({Key key}) : super(key: key);

  @override
  _Part_3_5State createState() => _Part_3_5State();
}

class _Part_3_5State extends State<Part_3_5> {

  int assessmentId;

  String surveyQuestion;
  List<Question> questions = List();

  @override
  void initState() {
    super.initState();
    getSurveyAnswers();
  }

/*  @override
  void dispose() {
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {

    assessmentId = ModalRoute.of(context).settings.arguments;

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
                    " Wähle eines davon aus, an welchem Du gerne als  Veränderungsprojekt arbeiten möchtest",
                percent: 0.55,
              ),


              Padding(
                padding: const EdgeInsets.all(20),
              child: Column(
                  children: <Widget>[
                    for(var element in questions )
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: ThemeColors.greenShade2),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Colors.transparent,
                        ),
                        child: Text(
                          element.question,
                          style: ThemeTexts.assessmentQuestion,
                        ),
                        margin: EdgeInsets.only(bottom: 15),
                      ),
                  ],
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
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Part_2_4()));
                  Navigator.of(context).pushNamed("/part_2_4", arguments: assessmentId);
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



    for(Answer element in surveyAnswers){
      questionNumber = element.question_number;
      //todo: Question findQuestion =  await assessmentRepo.findQuestion(questionNumber);
      //questions.add(findQuestion);
    }


    questions.forEach((element) {
      setState(() {
        surveyQuestion =  element.question;
      });

      print(surveyQuestion);
    });

    }
  }

