import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/CurvedShape.dart';
import 'package:ip5_selbsteinschaetzung/components/expandableQuestionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/questionDialog.dart';
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
              ExpandableQuestionCard(question: "In einer mir bekannten Gruppe etwas sagen/eine Idee vorbringen", questionNumber: "3.1.1", answered: false),
              ExpandableQuestionCard(question: "Ein Gespräch anfangen/andere ansprechen", questionNumber: "3.1.2", answered: false),
            ],
          ),
        ),
      ),
    );
  }

}
