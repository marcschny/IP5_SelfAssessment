/*
*
* Smiley icons received from:  https://icons8.de
* this link must be shown in the app
* e.g in the "about us" or "settings" screen
* > todo: has to be done in main app later
*
* */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ip5_selbsteinschaetzung/components/dialogs/experienceExplanationDialog.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/experience.dart';
import 'package:ip5_selbsteinschaetzung/resources/animations/fade_in.dart';
import 'package:ip5_selbsteinschaetzung/resources/animations/slide_up_from_bottom.dart';
import 'package:ip5_selbsteinschaetzung/screens/change_project.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';



class ExperienceDialog extends StatefulWidget{

  final int assessmentId;
  final Experience experience;

  const ExperienceDialog({Key key, this.assessmentId, this.experience}) : super(key: key);

  _ExperienceDialogState createState() => _ExperienceDialogState();

}

class _ExperienceDialogState extends State<ExperienceDialog>{

  String _selectedSmiley;
  final _descriptionController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _selectedSmiley = "";
    _descriptionController.text = widget.experience != null ? widget.experience.description : "";
    _selectedSmiley = widget.experience != null ? widget.experience.mood : "";
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
                        style: ThemeTexts.assessmentDialogTitle.copyWith(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 18),
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
                        "Beschreibe kurz was Du erreicht hast oder was noch nicht geklappt hat",
                        textAlign: TextAlign.center,
                        style: ThemeTexts.assessmentDialogTitle.copyWith(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 18),
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
                        style: ThemeTexts.assessmentDialogTitle.copyWith(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 18),
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
                          if(_validate()){
                            showDialog(
                              context: context,
                              barrierColor: Colors.black.withOpacity(.0),
                              child: widget.experience != null ?
                              SlideUpFromBottom(0, ExperienceExplanationDialog(assessmentId: widget.assessmentId, smiley: _selectedSmiley, description: _descriptionController.text, experience: widget.experience)) :
                              SlideUpFromBottom(0, ExperienceExplanationDialog(assessmentId: widget.assessmentId, smiley: _selectedSmiley, description: _descriptionController.text)),
                            );
                          }else{
                            showToast(
                              _missingInput(),
                              context: context,
                              textAlign: TextAlign.center,
                              textStyle: ThemeTexts.toastText,
                              textPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              position: ToastPosition.bottom,
                              backgroundColor: Color.fromRGBO(70, 70, 70, .7),
                              duration: Duration(milliseconds: 2500),
                            );
                          }
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
                  _save();
                },
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  bool _validate(){
    if(_selectedSmiley != "" && _selectedSmiley != null && _descriptionController.text != "" && _descriptionController.text != null) return true;
    else return false;
  }

  String _missingInput(){
    if(_selectedSmiley == "") return "Du hast noch keinen Smiley ausgewählt";
    else if(_descriptionController.text == "") return "Du hast noch nichts eingegeben";
    else return "";
  }

  _save() async{
    if(_validate()) {
      final appDatabase = Provider.of<AppDatabase>(context, listen: false);
      final assessmentRepo = appDatabase.assessmentRepository;

      if(widget.experience != null) {
        final updateExperience = Experience(widget.experience.id, _selectedSmiley,
            _descriptionController.text, "", widget.experience.date_created, widget.experience.assessment_id);

        assessmentRepo.updateExperience(updateExperience);
        Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 300),
              pageBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return ChangeProject(assessmentId: widget.assessmentId);
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
            ModalRoute.withName("/changeProject")
        );
      }else{
        final newExperience = Experience(
            null, _selectedSmiley, _descriptionController.text, "",
            DateTime.now().toString(), widget.assessmentId);

        assessmentRepo.createExperience(newExperience);
        Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return ChangeProject(assessmentId: widget.assessmentId);
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
          ModalRoute.withName("/changeProject")
        );
      }
    }else{
      showToast(
        _missingInput(),
        context: context,
        textAlign: TextAlign.center,
        textStyle: ThemeTexts.toastText,
        textPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        position: ToastPosition.bottom,
        backgroundColor: Color.fromRGBO(70, 70, 70, .7),
        duration: Duration(milliseconds: 2500),
      );
    }
  }

}