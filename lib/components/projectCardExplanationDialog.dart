

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

class ProjectCardExplanationDialog extends StatefulWidget{

  final int assessmentId;

  const ProjectCardExplanationDialog({Key key, this.assessmentId}) : super(key: key);

  _ProjectCardExplanationDialogState createState() => _ProjectCardExplanationDialogState();

}

class _ProjectCardExplanationDialogState extends State<ProjectCardExplanationDialog>{

  final _explanationController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _explanationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ThemeColors.greenShade3, ThemeColors.greenShade2.withOpacity(.85)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.1, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(18, 40, 18, 94),
            height: MediaQuery.of(context).size.height-25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


                Text(
                  "Wie war das genau? Und wie ging es Dir dabei?",
                  textAlign: TextAlign.center,
                  style: ThemeTexts.assessmentDialogTitle.copyWith(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 18),
                ),
                SizedBox(height: 40),
                Expanded(
                  child: TextField(
                    autofocus: false,
                    style: ThemeTexts.assessmentAnswer,
                    decoration: InputDecoration(
                      hintText: "Text hier eingeben...",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 16,
                    controller: _explanationController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width-32,
        color: Colors.transparent,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            ButtonTheme(
              height: 51,
              minWidth: 51,
              child: RaisedButton(
                elevation: 0.0,
                color: ThemeColors.greyShade1,
                shape: CircleBorder(),
                child: Icon(
                  Icons.arrow_back,
                  color: Color.fromRGBO(80, 80, 80, 1),
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ),

            ButtonTheme(
              height: 56,
              minWidth: 66,
              child: RaisedButton(
                elevation: 0.0,
                color: ThemeColors.greenShade2,
                shape: CircleBorder(),
                child: Icon(
                  Icons.check,
                  color: Color.fromRGBO(80, 80, 80, 1),
                ),
                onPressed: (){
                  //todo: save project card
                },
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }



}