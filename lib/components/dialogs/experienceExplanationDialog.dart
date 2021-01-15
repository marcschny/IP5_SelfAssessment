import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/experience.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_4/change_project.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';



class ExperienceExplanationDialog extends StatefulWidget{

  final int assessmentId;
  final String smiley;
  final String description;
  final Experience experience;

  const ExperienceExplanationDialog({
    Key key,
    @required this.assessmentId,
    @required this.smiley,
    @required this.description,
    this.experience
  }) : super(key: key);

  _ExperienceExplanationDialogState createState() => _ExperienceExplanationDialogState();

}

class _ExperienceExplanationDialogState extends State<ExperienceExplanationDialog>{

  final _explanationController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _explanationController.text = widget.experience != null ? widget.experience.explanation : "";
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
                  _save(context);
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

  _save(BuildContext context) async{
    if(_explanationController.text != null && _explanationController.text != "") {
      final appDatabase = Provider.of<AppDatabase>(context, listen: false);
      final assessmentRepo = appDatabase.assessmentRepository;

      if (widget.experience != null) {
        final updateExperience = Experience(
            widget.experience.id, widget.smiley,
            widget.description, _explanationController.text,
            widget.experience.date_created, widget.assessmentId);

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
      } else {
        final newExperience = Experience(
            null, widget.smiley, widget.description, _explanationController.text,
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
        "Du hast noch nichts eingetippt",
        context: context,
      );
    }

  }


}