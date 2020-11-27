import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/questionDialog.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';


class QuestionCard extends StatefulWidget{
  final String questionNumber;

  const QuestionCard({
    Key key,
    @required this.questionNumber,
  });

  _QuestionCardState createState() => _QuestionCardState();

}

class _QuestionCardState extends State<QuestionCard>{



  @override
  Widget build(BuildContext context) {

    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;
    final loadQuestion =  assessmentRepo.findQuestion(
        widget.questionNumber);

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
                color: snapshot.data.answered
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
                      child: snapshot.data.answered ?
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
                child: QuestionDialog(
                  question: snapshot.data.question,
                  questionNumber: widget.questionNumber
                )
            );
          },
        );
      }
      return Container();
      },
    );
  }

}