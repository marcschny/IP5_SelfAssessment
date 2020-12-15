/*
*
* Smiley icons received from:  https://icons8.de
* this link must be shown in the app
* e.g in the "about us" or "settings" screen
* > todo: will be done in main app later
*
* */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ip5_selbsteinschaetzung/resources/FadeIn.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

class ProjectCardDialog extends StatefulWidget{

  final int assessmentId;

  const ProjectCardDialog({Key key, this.assessmentId}) : super(key: key);

  _ProjectCardDialogState createState() => _ProjectCardDialogState();

}

class _ProjectCardDialogState extends State<ProjectCardDialog>{

  String _selectedSmiley;
  final _descriptionController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _selectedSmiley = "";
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
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
        child: FadeIn(
          1.34,
          500,
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(18, 50, 18, 94),
              height: MediaQuery.of(context).size.height-25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Column(
                    children: [
                      Text(
                        "Wie ist es Dir heute mit deinem Veränderungsprojekt ergangen?",
                        textAlign: TextAlign.center,
                        style: ThemeTexts.assessmentDialogTitle.copyWith(color: Color.fromRGBO(85, 85, 85, 1)),
                      ),
                      SizedBox(height: 6),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 12, 5, 5),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Opacity(
                                opacity: _selectedSmiley == "verygreat" || _selectedSmiley == "" ? 1 : 0.35,
                                child: Container(
                                  width: _selectedSmiley == "verygreat" ? 57 : 50,
                                  height: _selectedSmiley == "verygreat" ? 57 : 50,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black45.withOpacity(.2),
                                            spreadRadius: -6,
                                            blurRadius: 12,
                                            offset: Offset(0,4)
                                        )
                                      ],
                                    image: DecorationImage(
                                      image: AssetImage("assets/smileys/verygreat.png"),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                ),
                              ),
                              onTap: (){
                                print("clicked on very great smiley");
                                setState(() {
                                  _selectedSmiley = "verygreat";
                                });
                              },
                            ),
                            GestureDetector(
                              child: Opacity(
                                opacity: _selectedSmiley == "great" || _selectedSmiley == "" ? 1 : 0.35,
                                child: Container(
                                  width: _selectedSmiley == "great" ? 57 : 50,
                                  height: _selectedSmiley == "greaat" ? 57 : 50,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black45.withOpacity(.2),
                                            spreadRadius: -6,
                                            blurRadius: 12,
                                            offset: Offset(0,4)
                                        )
                                      ],
                                    image: DecorationImage(
                                      image: AssetImage("assets/smileys/great.png"),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                ),
                              ),
                              onTap: (){
                                print("clicked on great smiley");
                                setState(() {
                                  _selectedSmiley = "great";
                                });
                              },
                            ),
                            GestureDetector(
                              child: Opacity(
                                opacity: _selectedSmiley == "ok" || _selectedSmiley == "" ? 1 : 0.35,
                                child: Container(
                                  width: _selectedSmiley == "ok" ? 57 : 50,
                                  height: _selectedSmiley == "ok" ? 57 : 50,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black45.withOpacity(.2),
                                        spreadRadius: -6,
                                        blurRadius: 12,
                                        offset: Offset(0,4)
                                      )
                                    ],
                                    image: DecorationImage(
                                      image: AssetImage("assets/smileys/ok.png"),
                                      fit: BoxFit.cover,
                                    )
                                  ),
                                ),
                              ),
                              onTap: (){
                                print("clicked on ok smiley");
                                setState(() {
                                  _selectedSmiley = "ok";
                                });
                              },
                            ),
                            GestureDetector(
                              child: Opacity(
                                opacity: _selectedSmiley == "bad" || _selectedSmiley == "" ? 1 : 0.35,
                                child: Container(
                                  width: _selectedSmiley == "bad" ? 57 : 50,
                                  height: _selectedSmiley == "bad" ? 57 : 50,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black45.withOpacity(.2),
                                            spreadRadius: -6,
                                            blurRadius: 12,
                                            offset: Offset(0,4)
                                        )
                                      ],
                                    image: DecorationImage(
                                      image: AssetImage("assets/smileys/bad.png"),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                ),
                              ),
                              onTap: (){
                                print("clicked on bad smiley");
                                setState(() {
                                  _selectedSmiley = "bad";
                                });
                              },
                            ),
                            GestureDetector(
                              child: Opacity(
                                opacity: _selectedSmiley == "verybad" || _selectedSmiley == "" ? 1 : 0.35,
                                child: Container(
                                  width: _selectedSmiley == "verybad" ? 57 : 50,
                                  height: _selectedSmiley == "verybad" ? 57 : 50,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black45.withOpacity(.2),
                                            spreadRadius: -6,
                                            blurRadius: 12,
                                            offset: Offset(0,4)
                                        )
                                      ],
                                    image: DecorationImage(
                                      image: AssetImage("assets/smileys/verybad.png"),
                                      fit: BoxFit.cover,
                                    )
                                  ),
                                ),
                              ),
                              onTap: (){
                                print("clicked on very bad smiley");
                                setState(() {
                                  _selectedSmiley = "verybad";
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  Column(
                    children: [
                      Text(
                        "Beschreibe in einem Satz was Du erreicht hast oder was noch nicht geklappt hat",
                        textAlign: TextAlign.center,
                        style: ThemeTexts.assessmentDialogTitle.copyWith(color: Color.fromRGBO(85, 85, 85, 1)),
                      ),
                      SizedBox(height: 4),
                      Container(
                        padding: EdgeInsets.fromLTRB(14, 10, 14, 12),
                        child: TextField(
                          maxLines: 1,
                          controller: _descriptionController,
                          onSubmitted: (value){

                          },
                          textInputAction: TextInputAction.go,
                          decoration: InputDecoration(
                            hintText: "Dein Satz...",
                            hintStyle: ThemeTexts.assessmentText.copyWith(fontSize: 19, color: Colors.black45),
                            contentPadding: EdgeInsets.all(0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: ThemeColors.greenShade1),
                            ),
                          ),
                          style: ThemeTexts.assessmentText.copyWith(fontSize: 19),
                        ),
                      ),
                      Text(
                        "Beispiel: Andere zum lachen gebracht",
                        textAlign: TextAlign.center,
                        style: ThemeTexts.assessmentNavigationNext.copyWith(color: Color.fromRGBO(105, 105, 105, 1)),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Text(
                        "Möchtest Du näher erläutern wie das war?",
                        textAlign: TextAlign.center,
                        style: ThemeTexts.assessmentDialogTitle.copyWith(color: Color.fromRGBO(85, 85, 85, 1)),
                      ),
                      SizedBox(height: 10),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: ThemeColors.greenShade2,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 9, horizontal: 0),
                        focusElevation: 0,
                        highlightElevation: 0,
                        child: Text(
                          "Ja",
                          style: ThemeTexts.assessmentText.copyWith(
                              color: Colors.white,
                              fontSize: 16.5,
                              fontWeight: FontWeight.normal),
                        ),
                        onPressed: () {
                          print("open explanation dialog/screen");
                          /*showDialog(
                            context: context,
                            barrierColor: Colors.black.withOpacity(.55),
                            child: Padding(
                              padding: EdgeInsets.only(top: 120),
                              child: SlideUpFromBottom(0, ProjectDescriptionDialog(assessmentId: widget.assessmentId)),
                            ),
                          );*/
                        },
                      ),
                    ],
                  ),


                  SizedBox(height: 14),
                ],
              ),
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
                  Icons.close,
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
      resizeToAvoidBottomInset: false,
    );
  }



}