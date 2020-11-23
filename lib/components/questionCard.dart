

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

class QuestionCard extends StatelessWidget{

  final String question;
  final String questionNumber;
  final bool answered;
  final Function callback;

  const QuestionCard({
    Key key,
    @required this.question,
    @required this.questionNumber,
    this.answered,
    this.callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: answered ? ThemeColors.greenShade2 : ThemeColors.greenShade3,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: ThemeTexts.assessmentQuestion,
                  ),
                ),
                Center(
                  child: answered ?
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
      onTap: (){
        callback(question, questionNumber);
      },
    );
  }

}