import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';

//this is the survey box component used in part_3
class SurveyBox extends StatefulWidget{

  final String question;
  final bool checked;
  final Function callback;

  const SurveyBox({
    Key key,
    this.question,
    this.checked,
    this.callback
  });

  _SurveyBoxState createState() => _SurveyBoxState();

}

class _SurveyBoxState extends State<SurveyBox> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.callback(widget.question);
      },
      child: Container(
        decoration: widget.checked
            ? BoxDecoration(
                color: ThemeColors.greenShade2,
                border: Border.all(color: ThemeColors.greenShade2),
                borderRadius: BorderRadius.all(Radius.circular(12))
        )
            :  BoxDecoration(
                border: Border.all(color: ThemeColors.greenShade2),
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.transparent,
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),

        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Text(
            widget.question,
            style: ThemeTexts.assessmentQuestion,
          ),
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
