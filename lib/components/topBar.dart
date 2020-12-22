
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/progressBar.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';


//todo: remove attribute onClose. bc onclose functionality must be defined in this widget
class TopBar extends StatelessWidget{

  final String title;
  final int titleNumber;
  final Function onClose;
  final String subtitle;
  final String intro;
  final double percent;
  final bool showProgressbar;
  final Widget widget;


  const TopBar({
    Key key,
    @required this.title,
    @required this.titleNumber,
    @required this.onClose,
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
                  padding: EdgeInsets.only(right: 8, left: 6),
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
                        onTap: onClose,
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
              padding: widget != null ? EdgeInsets.fromLTRB(5, 0, 5, 0) : EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Material(
                color: Colors.transparent,
                child: Text(
                  subtitle,
                  style: ThemeTexts.assessmentSubtitle,
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
                padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
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