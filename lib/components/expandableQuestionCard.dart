import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:expandable/expandable.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';


class ExpandableQuestionCard extends StatelessWidget{

  final String question;
  final String questionNumber;
  final bool answered;

  const ExpandableQuestionCard({
    Key key,
    this.question,
    this.questionNumber,
    this.answered
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: ThemeColors.greenShade3,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: ExpandablePanel(
            header: Container(
              child: Text(
                question,
                style: ThemeTexts.assessmentQuestion,
              ),
            ),
            expanded: Container(
              padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
              //color: Colors.red,
              child: CustomRadioButton(
                enableShape: true,
                customShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: ThemeColors.greenShade2),
                ),
                width: MediaQuery.of(context).size.width,
                padding: 0,
                elevation: 0,
                enableButtonWrap: true,
                unSelectedColor: Colors.transparent,
                selectedColor: ThemeColors.greenShade2,
                buttonLables: [
                  "Mache ich sehr oft / kann ich echt gut",
                  "Mache ich öfters / kann ich meisten",
                  "Kriege ich hin und wieder hin",
                  "Schaffe ich selten"
                ],
                buttonValues: [
                  "Mache ich sehr oft / kann ich echt gut",
                  "Mache ich öfters / kann ich meisten",
                  "Kriege ich hin und wieder hin",
                  "Schaffe ich selten"
                ],
                buttonTextStyle: ButtonTextStyle(
                  unSelectedColor: Colors.black,
                  selectedColor: Colors.black,
                  textStyle: ThemeTexts.assessmentAnswer.copyWith(fontSize: 14, fontWeight: FontWeight.w600)
                ),
                radioButtonValue: (value){
                  //todo: write answer value and question.answered to db (using questionNumber)
                  print(value);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

}