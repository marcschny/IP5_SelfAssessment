import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/answer.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';

class SurveyBox extends StatefulWidget{

  final String question;
  final bool answerable;

  const SurveyBox({
    Key key,
    this.question,
    this.answerable
  });

  _SurveyBoxState createState() => _SurveyBoxState();

}

class _SurveyBoxState extends State<SurveyBox> {
  bool _answered;

  @override
  void initState() {
    super.initState();
    _answered = false;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _answered = !this._answered;
          });
        },



      child: Container(
        decoration: _answered && widget.answerable
            ? BoxDecoration(
                color: ThemeColors.greenShade2,
                borderRadius: BorderRadius.all(Radius.circular(12))
        )
            :  BoxDecoration(
                border: Border.all(color: ThemeColors.greenShade2),
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.transparent,
        ),
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),

        child: Text(
          widget.question,
          style: ThemeTexts.assessmentQuestion,
        ),
        margin: EdgeInsets.only(bottom: 15),
        width: MediaQuery
            .of(context)
            .size
            .width,
      ),
    );
  }
}
