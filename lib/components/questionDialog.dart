import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/answer.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';

class QuestionDialog extends StatefulWidget{

  final int assessmentId;
  final String question;
  final String questionNumber;

  const QuestionDialog({
    Key key,
    this.question,
    this.questionNumber,
    this.assessmentId
  });

  _QuestionDialogState createState() => _QuestionDialogState();

}

class _QuestionDialogState extends State<QuestionDialog> {

  String subquestion;
  Answer answer;

  final answerController = TextEditingController();


  @override
  void initState() {
    super.initState();
    getAnswer();
    answerController.addListener(() {
      getSubQuestion();
    });
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: widget.question,
                      style: ThemeTexts.assessmentQuestion
                  ),
                  WidgetSpan(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                    ),
                  ),
                  TextSpan(
                    text: subquestion,
                    style: ThemeTexts.assessmentSubquestion,
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: ThemeColors.greenShade4,
              ),
              child: TextField(
                autofocus: true,
                style: ThemeTexts.assessmentAnswer,
                decoration: InputDecoration(
                  hintText: "Deine Antwort...",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 16,
                controller: answerController,
              ),

            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2.0,
        shape: CircleBorder(),
        backgroundColor: ThemeColors.greenShade2,
        child: Icon(
          Icons.check,
          size: 30,
          color: Color.fromRGBO(80, 80, 80, 1),
        ),
        onPressed: () {
          createOrUpdateAnswer();
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  getAnswer() async {
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    final loadAnswer = await assessmentRepo.findAnswer(
        widget.questionNumber);

    answer = loadAnswer;

    setState((){
        if(loadAnswer !=null) {
          var cursorPos = answerController.selection;

          answerController.text = loadAnswer.answer;

          if (cursorPos.start < answerController.text.length) {
            cursorPos = new TextSelection.fromPosition(
                new TextPosition(offset: answerController.text.length));
          }
          answerController.selection = cursorPos;
        }
    });
  }

  createOrUpdateAnswer() async {
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    //todo: get answer by questionNumber and assessment_id!
    final loadAnswer = await assessmentRepo.findAnswer(
        widget.questionNumber);

    final question = await assessmentRepo.findQuestion(widget.questionNumber);
    question.answered = answerController.text != "" ? true : false;
    assessmentRepo.updateQuestion(question);

      //todo: same here (no id passed yet)
      if(loadAnswer!=null) {
        final Answer updatedAnswer =  Answer(
            loadAnswer.id, answerController.text, widget.questionNumber,
            widget.assessmentId);
        assessmentRepo.updateAnswer(updatedAnswer);

      } else {

        //todo: same here (no id passed yet)
        final Answer newAnswer = new Answer(
            null, answerController.text, widget.questionNumber,
            widget.assessmentId);
        if(newAnswer.answer!='') {
          assessmentRepo.insertAnswer(newAnswer);
        }

      }
    }


  getSubQuestion() async {
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    //todo: same here - get by questionNumber and Assessment_id!
    final loadQuestion = await assessmentRepo.findQuestion(
        widget.questionNumber);

    String subQuestion = loadQuestion.subquestion;

    setState((){
      subquestion = subQuestion;
    });
  }



}