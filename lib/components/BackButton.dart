import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';


class GoBackButton extends StatelessWidget{

  final Function callback;

  const GoBackButton({
    Key key,
    @required this.callback
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 55,
      minWidth: 55,
      child: RaisedButton(
        elevation: 0.0,
        color: ThemeColors.greyShade1,
        shape: CircleBorder(),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: Color.fromRGBO(80, 80, 80, 1),
        ),
        onPressed: callback,
      ),
    );
  }



}