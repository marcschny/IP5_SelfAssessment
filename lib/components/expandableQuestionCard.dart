import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/answer.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:expandable/expandable.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:provider/provider.dart';


class ExpandableQuestionCard extends StatefulWidget {

  final int assessmentId;
  final String question;
  final String questionNumber;
  final bool answered;

  const ExpandableQuestionCard({
    Key key,
    this.question,
    this.questionNumber,
    this.answered,
    this.assessmentId
  });

  _ExpandableQuestionCardState createState() => _ExpandableQuestionCardState();

}

class _ExpandableQuestionCardState extends State<ExpandableQuestionCard> {


  @override
  Widget build(BuildContext context) {
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;
    final loadQuestion = assessmentRepo.findQuestion(
        widget.questionNumber);

    final loadAnswer = assessmentRepo.findAnswer(
        widget.questionNumber);

          return Container(
            margin: EdgeInsets.only(bottom: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: ThemeColors.greenShade3,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: ExpandablePanel(
                  header: FutureBuilder(
                    future: loadQuestion,
                    builder: (context, snapshot) {
                      return Container(
                        child: Text(
                          widget.question, //snapshot.data.question
                          style: ThemeTexts.assessmentQuestion,
                        ),
                      );
                    },
                  ),

                  expanded: FutureBuilder(
                  future: loadAnswer,
                  builder: (context, snapshot) {
                    return Container(
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

                          if (snapshot.hasData) {
                            final Answer updatedAnswer = Answer(
                                snapshot.data.id, value, widget.questionNumber,
                                widget.assessmentId);
                            assessmentRepo.updateAnswer(updatedAnswer);
                          } else {
                            final Answer newAnswer = new Answer(
                                null, value, widget.questionNumber,
                                widget.assessmentId);
                            if (newAnswer.answer != '') {
                              assessmentRepo.insertAnswer(newAnswer);
                            }
                          }
                        },
                        // defaultSelected: true,

                      ),
                    );
                  }
                  ),
                ),
              ),
            ),
          );
        }


}