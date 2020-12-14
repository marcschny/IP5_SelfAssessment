import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/surveyBox.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/answer.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/question.dart';
import 'package:ip5_selbsteinschaetzung/resources/SlideUpFadeIn.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';

import 'Part_2_4.dart';


//todo: what if only top answers were selected -> handle this case
class Part_3_5 extends StatefulWidget {

  final int assessmentId;
  final int visualizationId;

  const Part_3_5({Key key, this.assessmentId, this.visualizationId}) : super(key: key);

  @override
  _Part_3_5State createState() => _Part_3_5State();
}


class _Part_3_5State extends State<Part_3_5>{

  bool allPositive = false;
  String _introText = "";
  Map<String, bool> distinctQuestions;


  @override
  void initState() {
    super.initState();
    distinctQuestions = Map();
    distinctQuestions.clear();
    getSurveyAnswers();
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
                intro: _introText,
                percent: 0.55,
              ),




              Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 94),
                      child: ListView.builder(
                        itemCount: distinctQuestions.length,
                        itemBuilder: (context, index) {

                            return SlideUpFadeIn(
                              0.6+(index*0.2),
                              100,
                              SurveyBox(
                              question: distinctQuestions.keys.elementAt(index),
                              checked: distinctQuestions.values.elementAt(index),
                              callback: (question){
                                _switchChecked(question);
                              }
                              ),
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
                  _next(context, widget.assessmentId, widget.visualizationId, distinctQuestions);
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

    List<Answer> surveyAnswers = await assessmentRepo.getNegSurveyAnswers(widget.assessmentId);
    if(surveyAnswers == null || surveyAnswers.length == 0){
      print(surveyAnswers.length);
      setState(() {
        allPositive = true;
        _introText = "Wähle einen oder zwei der folgenden Punkte aus, an welchen Du gerne am Veränderungsprojekt arbeiten möchtest, um darin noch besser zu werden.";
      });
      surveyAnswers = await assessmentRepo.getPosSurveyAnswers(widget.assessmentId);
    }else{
      print("neg");
      setState(() {
        _introText = "Folgende Punkte sind Dir weniger gut gelungen. Wähle bis zu zwei davon aus, an welchen Du gerne am Veränderungsprojekt arbeiten möchtest.";
      });
    }

    print("surveyAnswers: "+surveyAnswers.length.toString());

    String questionNumber;
    distinctQuestions.clear();
    for(Answer answer in surveyAnswers){
      questionNumber = answer.question_number;
      Question findQuestion = await assessmentRepo.findQuestion(questionNumber);

      distinctQuestions.putIfAbsent(findQuestion.question, () => false);
    }


    print(distinctQuestions.length);

    setState(() {

    });

    }
  }

  //when next-button pressed
  _next(BuildContext context, int assessmentId, int visualizationId, Map questions) async{

  List<String> _selectedQuestions = List();
  _selectedQuestions.clear();

  //fill list with selected questions from map (values with bool true)
  questions.forEach((key, value) {
    if(value) _selectedQuestions.add(key);
  });

  if(_selectedQuestions != null && _selectedQuestions.length > 0 && _selectedQuestions.length < 3){
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Part_2_4(assessmentId: assessmentId, visualizationId: visualizationId, evaluation: _selectedQuestions);
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
      ModalRoute.withName("/part_2_4"),
    );
  }else if(_selectedQuestions.length == 0){
    showToast(
      "Wähle einen oder zwei Punkte aus",
      context: context,
      textAlign: TextAlign.center,
      textStyle: ThemeTexts.toastText,
      textPadding: EdgeInsets.symmetric(vertical: 9, horizontal: 12),
      position: ToastPosition.bottom,
      backgroundColor: Color.fromRGBO(70, 70, 70, .7),
      duration: Duration(milliseconds: 3500),
    );
  }else if(_selectedQuestions.length > 2){
    showToast(
      "Wähle maximal zwei Punkte aus",
      context: context,
      textAlign: TextAlign.center,
      textStyle: ThemeTexts.toastText,
      textPadding: EdgeInsets.symmetric(vertical: 9, horizontal: 12),
      position: ToastPosition.bottom,
      backgroundColor: Color.fromRGBO(70, 70, 70, .7),
      duration: Duration(milliseconds: 3500),
    );
  }




  }

