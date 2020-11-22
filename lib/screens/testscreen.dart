import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/CurvedShape.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

class TestScreen extends StatefulWidget {

  const TestScreen({Key key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();

}

class _TestScreenState extends State<TestScreen>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          child: Column(
            children: [
              QuestionCard(
                question: "Wenn Du daran denkst, was für eine Person Du gerne wärst: Wie könnte das Motto dieser Person lauten?",
                answered: false,
                questionNumber: "2.1.1",
                callback: (question){
                  print("tapped on the question: "+question);
                },
              ),
              QuestionCard(
                question: "Was fällt Dir manchmal schwer im Umgang mit anderen Menschen? ",
                answered: true,
                questionNumber: "2.1.2",
                callback: (question){
                  print("tapped on the question: "+question);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
