import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';


class NextButton extends StatelessWidget{

  final String nextTitle;
  final Function callback;

  const NextButton({
    Key key,
    @required this.nextTitle,
    @required this.callback
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 0),
          constraints: BoxConstraints(
            minWidth: 50,
            maxWidth: MediaQuery.of(context).size.width*0.4
          ),
          child: RichText(
            textAlign: TextAlign.end,
            softWrap: true,
            overflow: TextOverflow.clip,
            maxLines: 2,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Weiter zu\n",
                  style: ThemeTexts.assessmentNavigationNext.copyWith(fontWeight: FontWeight.w600),
                ),
                WidgetSpan(
                  child: Wrap(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: Text(
                        nextTitle,
                        textAlign: TextAlign.end,
                        style: ThemeTexts.assessmentNavigationNext,
                    ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),


        ButtonTheme(
          height: 60,
          minWidth: 70,
          child: RaisedButton(
            elevation: 0.0,
            color: ThemeColors.greenShade2,
            shape: CircleBorder(),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color.fromRGBO(80, 80, 80, 1),
            ),
            onPressed: callback,
          ),
        ),
      ],
    );
  }



}