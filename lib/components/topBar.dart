
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/progressBar.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

class TopBar extends StatelessWidget{

  final String title;
  final int titleNumber;
  final Function onClose;
  final String subtitle;
  final String intro;

  const TopBar({
    Key key,
    this.title,
    this.titleNumber,
    this.onClose,
    this.subtitle,
    this.intro
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(right: 8, left: 6),
                child: Text(
                  titleNumber.toString(),
                  style: ThemeTexts.assessmentNumberTitle,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                ),
              ),
              Spacer(),
              Expanded(
                flex: 100,
                child: Text(
                  title,
                  style: ThemeTexts.assessmentTitle,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
              ),
              Spacer(flex: 4),
              Container(
                child: Center(
                  child: GestureDetector(
                    child: Icon(
                      Icons.close,
                      size: 32,
                      color: Color.fromRGBO(80, 80, 80, 1),
                    ),
                    onTap: onClose,
                  ),
                ),
              )
            ],
          ),
          ProgressBar(
            percent: 0.1
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: Text(
              subtitle,
              style: ThemeTexts.assessmentSubtitle,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
            child: Text(
              intro,
              style: ThemeTexts.assessmentIntro,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }


}