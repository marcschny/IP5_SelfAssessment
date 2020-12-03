import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';


class SurveyBoxFilled extends StatefulWidget{

  final String question;

  const SurveyBoxFilled({
    Key key,
    this.question,
  });

  _SurveyBoxFilledState createState() => _SurveyBoxFilledState();

}

class _SurveyBoxFilledState extends State<SurveyBoxFilled> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
              color: ThemeColors.greenShade4,
              border: Border.all(color: ThemeColors.greenShade4),
              borderRadius: BorderRadius.all(Radius.circular(12))
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
    );
  }
}
