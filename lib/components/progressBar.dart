
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressBar extends StatelessWidget{

  final double percent;

  const ProgressBar({
    Key key,
    @required this.percent
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: LinearPercentIndicator(
        width: MediaQuery.of(context).size.width-32, //subtract topBar horizontally padding
        animation: true,
        lineHeight: 9.0,
        animationDuration: 1000,
        percent: percent,
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: ThemeColors.greenShade3,
        backgroundColor: Color.fromRGBO(230, 230, 230, 1),
      ),
    );
  }



}