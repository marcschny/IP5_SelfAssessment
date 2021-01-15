import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

//this is the progress bar used in the top bar
class ProgressBar extends StatelessWidget{

  final double percent;

  const ProgressBar({
    Key key,
    @required this.percent
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: LinearPercentIndicator(
        width: MediaQuery.of(context).size.width-32, //subtract topBar horizontally padding
        animation: false,
        lineHeight: 9.0,
        animationDuration: 1000,
        percent: percent,
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: ThemeColors.greenShade3,
        backgroundColor: Color.fromRGBO(230, 230, 230, 1),
        padding: EdgeInsets.all(4),
      ),
    );
  }



}