import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/progress_bar.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';



class TopBar extends StatelessWidget{

  final String title;
  final int titleNumber;
  final String subtitle;
  final String intro;
  final double percent;
  final bool showProgressbar;
  final Widget widget;


  const TopBar({
    Key key,
    @required this.title,
    @required this.titleNumber,
    @required this.subtitle,
    this.intro,
    @required this.percent,
    @required this.showProgressbar,
    this.widget
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(16, 8, 16, 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 8, left: 1),
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      titleNumber.toString(),
                      style: ThemeTexts.assessmentNumberTitle,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 100,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      title,
                      style: ThemeTexts.assessmentTitle,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
                Spacer(flex: 4),
                Hero(
                  tag: "closeButton",
                  child: Container(
                    child: Center(
                      child: GestureDetector(
                        child: Icon(
                          Icons.close,
                          size: 32,
                          color: Color.fromRGBO(80, 80, 80, 1),
                        ),
                        onTap: (){
                          //todo: popUntil (pop back to main app)
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            showProgressbar ? ProgressBar(
              percent: percent,
            ) : Container(),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  subtitle,
                  style: ThemeTexts.assessmentSubtitle.copyWith(height: .92),
                ),
              ),
            ),
            widget != null ? Flexible(
                fit: FlexFit.loose,
                child: widget) : Container(),
            intro != null && intro != "" ?
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    intro,
                    style: ThemeTexts.assessmentIntro,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ) : Container(),
          ],
        ),
      );
  }


}