import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/answer.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';
import 'package:expandable/expandable.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:provider/provider.dart';


class ExpandableQuestionCard extends StatefulWidget {

  final int assessmentId;
  final String questionNumber;

  const ExpandableQuestionCard({
    Key key,
    @required this.questionNumber,
    @required this.assessmentId
  });

  _ExpandableQuestionCardState createState() => _ExpandableQuestionCardState();

}

class _ExpandableQuestionCardState extends State<ExpandableQuestionCard> {

  Answer answer;
  String question;
  ExpandableController controller;

  @override
  void initState() {
    super.initState();
    question = "";
    _getQuestion();
    _loadAnswer();
  }


  _getQuestion() async{
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    final getQuestion = await assessmentRepo.findQuestion(widget.questionNumber);

    setState(() {
      question = getQuestion.question;
    });

  }



  _loadAnswer() async{
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;
    final getAnswer = await assessmentRepo.findAnswer(widget.questionNumber, widget.assessmentId);

    setState(() {
      answer = getAnswer;
    });
  }


  _getAnswer(){
    return answer.answer;
  }


  @override
  Widget build(BuildContext context) {
    if(answer != null){
      return _answeredList();
    }else{
      return _unansweredList();
    }
  }

  _answeredList(){
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: ThemeColors.greenShade3,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: ExpandablePanel(
            header: Text(
              question,
              style: ThemeTexts.assessmentQuestion,
            ),

            expanded: Container(
              padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
              //color: Colors.red,
              child: CustomRadioButton(
                defaultSelected: _getAnswer(),
                enableShape: true,
                customShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: ThemeColors.greenShade2),
                ),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                    textStyle: ThemeTexts.assessmentAnswer.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w600)
                ),
                radioButtonValue: (value) {
                  _saveOrUpdateAnswer(value);
                },
              ),
            ),

          ),
        ),
      ),
    );
  }

  _unansweredList(){
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: ThemeColors.greenShade3,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: ExpandablePanel(
            header: Text(
              question,
              style: ThemeTexts.assessmentQuestion,
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                    textStyle: ThemeTexts.assessmentAnswer.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w600)
                ),
                radioButtonValue: (value) {
                  _saveOrUpdateAnswer(value);
                },
              ),
            ),
          controller: controller,
          ),
        ),
      ),
    );
  }


  _saveOrUpdateAnswer(String value) async{
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    if(answer == null) {
      final Answer newAnswer = Answer(null, value, widget.questionNumber, widget.assessmentId);
      assessmentRepo.insertAnswer(newAnswer).then((answerId) {
        _loadAnswer();
      });
      print("new answer: "+newAnswer.answer+" ["+newAnswer.assessment_id.toString()+"]");
    }else{
      final Answer updateAnswer = Answer(answer.id, value, widget.questionNumber, widget.assessmentId);
      assessmentRepo.updateAnswer(updateAnswer);
      print("updated answer: "+updateAnswer.answer+" ["+updateAnswer.assessment_id.toString()+"]");
    }
  }





}