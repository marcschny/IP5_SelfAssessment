import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

class CheckBoxComponent extends StatefulWidget {
  final String checkboxTitle;
  final bool checked;
  final Function callback;

  const CheckBoxComponent({Key key, @required this.checkboxTitle, @required this.checked, this.callback})
      : super(key: key);

  @override
  CheckBoxComponentState createState() => CheckBoxComponentState();
}

class CheckBoxComponentState extends State<CheckBoxComponent>{

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0),
      margin: EdgeInsets.only(bottom: 0),
      child: Row(
        children: [
          Checkbox(
            value: widget.checked,
            onChanged: (bool value) {
              widget.callback(widget.checkboxTitle);
            },
            activeColor: ThemeColors.greenShade2,
            checkColor: ThemeColors.greenShade4,
          ),
          Expanded(
            child: GestureDetector(
                onTap: () {
                  print(widget.checkboxTitle+" ["+widget.checked.toString()+"]");
                  widget.callback(widget.checkboxTitle);
                },
                child: Text(
                  widget.checkboxTitle,
                  overflow: TextOverflow.clip,
                  style: ThemeTexts.assessmentText.copyWith(fontSize: 19),
                )
            ),
          )
        ]
      )
    );
  }
}
