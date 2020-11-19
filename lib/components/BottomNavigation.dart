

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/NextButton.dart';

import 'BackButton.dart';

class BottomNavigation extends StatelessWidget{
  final bool showNextButton;
  final bool showBackButton;
  final String nextTitle;
  final Function callbackBack;
  final Function callbackNext;
  
  const BottomNavigation({
    Key key,
    this.showNextButton,
    this.showBackButton,
    this.nextTitle,
    this.callbackBack,
    this.callbackNext
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 84,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background_image/gradient-grey.png"),
          fit: BoxFit.fill
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(showBackButton) GoBackButton(callback: callbackBack),
          if(showNextButton) NextButton(nextTitle: nextTitle, callback: callbackNext),
        ],
      ),
    );
  }
  
}