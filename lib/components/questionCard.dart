import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/questionDialog.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/resources/SlideUpFromBottom.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';

//todo: load question by questionNumber and assessment id!
class QuestionCard extends StatefulWidget{

  final String questionNumber;
  final int assessmentId;

  const QuestionCard({
    Key key,
    @required this.questionNumber,
    @required this.assessmentId
  });

  _QuestionCardState createState() => _QuestionCardState();

}

class _QuestionCardState extends State<QuestionCard>{

  bool _answered;

  @override
  void initState() {
    super.initState();
    _answered = false;
    _getAnswered();
  }

  //when popped back from dialog screen
  FutureOr onGoBack(dynamic value){
    _getAnswered();
    print("FutureOr onGoBck!");
  }

  _getAnswered() async{
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    final findAnswer = await assessmentRepo.findAnswer(widget.questionNumber, widget.assessmentId);

    if(findAnswer != null) {
      setState(() {
        if (findAnswer.answer == null || findAnswer.answer == "") {
          _answered = false;
        } else {
          _answered = true;
        }
      });
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;
    final loadQuestion =  assessmentRepo.findQuestion(widget.questionNumber);

    return FutureBuilder(
    future: loadQuestion,
      builder: (context, snapshot) {
      if(snapshot.hasData) {
        return GestureDetector(
          child: Container(
            margin: EdgeInsets.only(bottom: 24),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: _answered
                    ? ThemeColors.greenShade2
                    : ThemeColors.greenShade3,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        snapshot.data.question,
                        style: ThemeTexts.assessmentQuestion,
                      ),
                    ),
                    Center(
                      child: _answered ?
                      Icon(
                        Icons.check,
                        size: 28,
                        color: Color.fromRGBO(80, 80, 80, 1),
                      ) :
                      SizedBox(width: 30),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onTap: () {
            showDialog(
                context: context,
                child: SlideUpFromBottom(
                  0,
                  QuestionDialog(
                    question: snapshot.data.question,
                    questionNumber: widget.questionNumber,
                    assessmentId: widget.assessmentId
                  ),
                )
            ).then(onGoBack);
          },
        );
      }
      return Container();
      },
    );
  }

}