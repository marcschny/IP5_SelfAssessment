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
import 'package:ip5_selbsteinschaetzung/components/experienceExplanationDialog.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/experience.dart';
import 'package:ip5_selbsteinschaetzung/resources/FadeIn.dart';
import 'package:ip5_selbsteinschaetzung/resources/SlideUpFromBottom.dart';
import 'package:ip5_selbsteinschaetzung/screens/ChangeProject.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';
import 'package:intl/intl.dart';

class NotEditableExperienceDialog extends StatefulWidget{

  final int assessmentId;
  final Experience experience;

  const NotEditableExperienceDialog({Key key, this.assessmentId, this.experience}) : super(key: key);

  _NotEditableExperienceDialogState createState() => _NotEditableExperienceDialogState();

}

class _NotEditableExperienceDialogState extends State<NotEditableExperienceDialog>{

  String _selectedSmiley;
  final _descriptionController = TextEditingController();
  final format = DateFormat("dd.MM.yyyy");


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          Stack(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 94),
                height: MediaQuery.of(context).size.height-25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [




                    Container(
                      padding: EdgeInsets.fromLTRB(12, 10, 18, 18),
                      child: Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
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
                                    image: AssetImage("assets/smileys/${widget.experience.mood}.png"),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              widget.experience.description,
                              style: ThemeTexts.assessmentDialogTitle.copyWith(fontSize: 21),
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                    ),



                    Flexible(
                      fit: FlexFit.loose,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(18, 0, 18, 12),
                          child: widget.experience.explanation != null && widget.experience.explanation != "" ?
                            Text(
                              widget.experience.explanation,
                              style: ThemeTexts.assessmentText.copyWith(fontSize: 18),
                              textAlign: TextAlign.start,
                            ) :
                            Text(
                              "Keine Erläuterung dazu vorhanden...",
                              style: ThemeTexts.assessmentText.copyWith(fontStyle: FontStyle.italic, fontSize: 18),
                              textAlign: TextAlign.start
                            ),

                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
                      child: Row(
                        children: [

                          Icon(
                            Icons.today_rounded,
                            size: 19,
                            color: Color.fromRGBO(85, 85, 85, 1),
                          ),
                          SizedBox(width: 6),
                          Text(
                            format.format(DateTime.parse(widget.experience.date_created)).toString(),
                            style: ThemeTexts.assessmentText.copyWith(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 16),
                          ),

                        ],
                      ),
                    ),


                  ],
                ),
              ),

              Positioned(
                bottom: 14,
                right: 16,
                child: Container(
                  color: Colors.transparent,
                  height: 70,
                  margin: EdgeInsets.only(right: 7, bottom: 5),
                  child: ButtonTheme(
                    height: 60,
                    minWidth: 60,
                    child: RaisedButton(
                        elevation: 0.0,
                        color: ThemeColors.greyShade1,
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.arrow_back,
                          color: Color.fromRGBO(80, 80, 80, 1),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }
                    ),
                  ),
                ),
              ),

            ],
          ),
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