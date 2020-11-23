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

class CheckBoxComponentState extends State<CheckBoxComponent> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: [
      Checkbox(
        value: checked,
        onChanged: (bool value) {
          setState(() {
            checked = value;
          });
        },
        activeColor: ThemeColors.greenShade2,
        checkColor: ThemeColors.greenShade4,
      ),
      GestureDetector(
          onTap: () {
            setState(() {
              checked = !checked;
            });
          },
          child: Text(
            widget.checkboxTitle,
            style: TextStyle(fontSize: 20),
          ))
    ]));
  }
}
