import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

class CheckBoxComponent extends StatefulWidget {
  final String checkboxTitle;

  const CheckBoxComponent({Key key, @required this.checkboxTitle})
      : super(key: key);

  @override
  CheckBoxComponentState createState() => CheckBoxComponentState();
}

class CheckBoxComponentState extends State<CheckBoxComponent>{
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0),
      margin: EdgeInsets.only(bottom: 0),
      child: Row(
        children: [
          Checkbox(
            value: checked,
            onChanged: (bool value) {
              setState(() {
                checked = value;
              });
              print(widget.checkboxTitle+" ["+checked.toString()+"]");
            },
            activeColor: ThemeColors.greenShade2,
            checkColor: ThemeColors.greenShade4,
          ),
          Expanded(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    checked = !checked;
                  });
                  print(widget.checkboxTitle+" ["+checked.toString()+"]");
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
