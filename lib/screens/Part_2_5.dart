import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_2_6.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';



class Part_2_5 extends StatefulWidget {

  final int assessmentId;
  final int networkId;

  const Part_2_5({
    Key key,
    this.assessmentId,
    this.networkId
  }) : super(key: key);

  @override
  _Part_2_5State createState() => _Part_2_5State();
}

class _Part_2_5State extends State<Part_2_5> with SingleTickerProviderStateMixin{

  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  TextEditingController _titleController;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children:[
            Image.asset(
              "assets/background_image/gradient-grey.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),

            Column(
              children: [
              TopBar(
                  title: "Ich und andere Menschen:  Wie ich bin und werden möchte",
                  titleNumber: 2,
                  onClose: null,
                  subtitle: "Name it!",
                  intro: "Wie lautet der Titel deines “Ja klar, das schaff  ich”-Projekts ?",
                  percent: 0.5,
              ),

              Expanded(
                child: FadeTransition(
                  opacity: _animationController,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                      child: Wrap(
                        children: [
                          TextField(
                            maxLines: 1,
                            controller: _titleController,
                            onSubmitted: (value){
                              //todo: write title to db (change project)
                            },
                            textInputAction: TextInputAction.go,
                            decoration: InputDecoration(
                              hintText: "Title Deines Projekts...",
                              hintStyle: ThemeTexts.assessmentText.copyWith(fontSize: 20, color: Colors.grey),
                              contentPadding: EdgeInsets.all(0),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: ThemeColors.greenShade3),
                              ),
                            ),
                            style: ThemeTexts.assessmentText.copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                  ),
                ),
              ),
          ],
        ),


            BottomNavigation(
                showNextButton: true,
                showBackButton: true,
                nextTitle: "Wer oder was hilft  Dir dabei?",
                callbackBack: () {
                  Navigator.of(context).pop();
                },
                callbackNext: (){
                  _next(context, widget.assessmentId, widget.networkId);
                }
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );

  }


  void _next(BuildContext context, int assessmentId, int networkId){
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Part_2_6(assessmentId: assessmentId, networkId: networkId);
        },
        transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return Align(
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }

}
