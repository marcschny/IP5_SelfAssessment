import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/back_button.dart';
import 'package:ip5_selbsteinschaetzung/components/next_button.dart';



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
    @required this.nextTitle,
    @required this.callbackBack,
    @required this.callbackNext
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Hero(
        tag: "bottomNavigation",
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 94,
          padding: EdgeInsets.fromLTRB(18, 10, 13, 18),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              showBackButton ? GoBackButton(callback: callbackBack) : SizedBox(width: 20),
              if(showNextButton) NextButton(nextTitle: nextTitle, callback: callbackNext),
            ],
          ),
        ),
      ),
    );
  }

}