import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

class QuestionDialog extends StatefulWidget{

  final String question;
  final String questionNumber;

  const QuestionDialog({
    Key key,
    this.question,
    this.questionNumber
  });

  _QuestionDialogState createState() => _QuestionDialogState();

}

class _QuestionDialogState extends State<QuestionDialog>{

  //todo: read subquestion from db
  String subquestion;
  String answer;

  final answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    answerController.addListener(() {
      //todo: listen on changes
    });
  }

  @override
  void dispose(){
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
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
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
                maxLines: 15,
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
        onPressed: (){
          //todo: store answer in db
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }


}