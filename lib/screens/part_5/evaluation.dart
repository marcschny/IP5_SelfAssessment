import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/top_bar.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/assessment.dart';
import 'package:ip5_selbsteinschaetzung/components/animations/fade_in.dart';
import 'package:ip5_selbsteinschaetzung/components/animations/slide_left.dart';
import 'package:ip5_selbsteinschaetzung/components/animations/slide_right.dart';
import 'package:ip5_selbsteinschaetzung/components/animations/slide_up_fade_in.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_4/change_project.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_5/my_experiences.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';


//Screen 5.1
class Evaluation extends StatefulWidget{

  final int assessmentId;

  const Evaluation({Key key, this.assessmentId}) : super(key: key);

  _EvaluationState createState() => _EvaluationState();

}

class _EvaluationState extends State<Evaluation>{

  //necessary vars
  String projectTitle = "";
  String _selectedSmiley;
  int noExperiences;
  int noPositiveExperiences;
  int noNegativeExperiences;

  @override
  void initState() {
    super.initState();
    _selectedSmiley = "";
    noPositiveExperiences = 0;
    noNegativeExperiences = 0;
    noExperiences = 0;
    Future.delayed(Duration.zero, _getProjectTitle);
    Future.delayed(Duration.zero, _getExperiences);
  }

  //fetch project title from db
  _getProjectTitle() async{
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    final assessment = await assessmentRepo.getProjectTitle(widget.assessmentId);

    setState(() {
      projectTitle = assessment?.project_title != null ? assessment.project_title : "Kein Projekttitel";
    });

  }

  //fetch experiences from db
  _getExperiences() async{
    //initialize app db
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    final experiences = await assessmentRepo.getExperiencesByAssessment(widget.assessmentId);
    final positiveExperiences = await assessmentRepo.getPositiveExperiences(widget.assessmentId);
    final negativeExperience = await assessmentRepo.getNegativeExperiences(widget.assessmentId);

    setState(() {
      noExperiences = experiences.length;
      noPositiveExperiences = positiveExperiences.length;
      noNegativeExperiences = negativeExperience.length;
    });

  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){},
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [

              //background image
              Image.asset(
                "assets/background_image/gradient-grey.png",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  TopBar(
                    title: "Auswertung",
                    titleNumber: 5,
                    subtitle: projectTitle,
                    percent: 0.05,
                    intro: "",
                    showProgressbar: false,
                  ),


                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 120),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            SlideUpFadeIn(
                              0.5,
                              100,
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Du hattest $noPositiveExperiences/$noExperiences gut gelungene Erlebnisse w??hrend Deines Ver??nderungsprojekts.",
                                      textAlign: TextAlign.start,
                                      style: ThemeTexts.assessmentDialogTitle.copyWith(color: ThemeColors.greenShade1, fontSize: 17),
                                    ),

                                    SizedBox(height: 12),

                                    noNegativeExperiences >=  noPositiveExperiences ?
                                    Text(
                                      "Auch wenn Du selber noch nicht zufrieden bist: Du hast viel gemacht!",
                                      textAlign: TextAlign.start,
                                      style: ThemeTexts.assessmentText.copyWith(color: ThemeColors.greyShade0, fontSize: 14.5),
                                    ) : Container(),

                                    SizedBox(height: 5),

                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      color: ThemeColors.greenShade3,
                                      elevation: 0,
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                      highlightColor: ThemeColors.greenShade3,
                                      focusElevation: 0,
                                      highlightElevation: 0,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.remove_red_eye_outlined,
                                            color: Colors.black87,
                                            size: 22,
                                          ),
                                          SizedBox(width: 7),
                                          Text(
                                            "Erlebnisse ansehen",
                                            style: ThemeTexts.assessmentDialogSubtitle.copyWith(
                                                color: Colors.black87,
                                                fontSize: 16.5,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            transitionDuration: Duration(milliseconds: 300),
                                            pageBuilder: (
                                                BuildContext context,
                                                Animation<double> animation,
                                                Animation<double> secondaryAnimation) {
                                              return MyExperiences(assessmentId: widget.assessmentId);
                                            },
                                            transitionsBuilder: (
                                                BuildContext context,
                                                Animation<double> animation,
                                                Animation<double> secondaryAnimation,
                                                Widget child) {
                                              return Align(
                                                child: SlideLeft(
                                                  0.1,
                                                  child,
                                                ),
                                              );
                                            },
                                          ),
                                        );

                                      },
                                    ),

                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 22),


                            noNegativeExperiences >=  noPositiveExperiences ?
                            SlideUpFadeIn(
                              0.8,
                              100,
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "M??chtest Du am Ver??nderungsprojekt weiterfahren?",
                                      textAlign: TextAlign.start,
                                      style: ThemeTexts.assessmentDialogTitle.copyWith(color: ThemeColors.greenShade1, fontSize: 17),
                                    ),

                                    SizedBox(height: 5),

                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      color: ThemeColors.greenShade3,
                                      elevation: 0,
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                      highlightColor: ThemeColors.greenShade3,
                                      focusElevation: 0,
                                      highlightElevation: 0,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black87,
                                            size: 22,
                                          ),
                                          SizedBox(width: 7),
                                          Text(
                                            "Zum Ver??nderungsprojekt",
                                            style: ThemeTexts.assessmentDialogSubtitle.copyWith(
                                                color: Colors.black87,
                                                fontSize: 16.5,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        _goToChangeProject();
                                      },
                                    ),

                                  ],
                                ),
                              ),
                            ) : Container(),


                            SizedBox(height: 22),

                            SlideUpFadeIn(
                              1.2,
                              100,
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Wie zufrieden bist zu insgesamt mit deinem Ver??nderungsprojekt?",
                                      textAlign: TextAlign.start,
                                      style: ThemeTexts.assessmentDialogTitle.copyWith(fontSize: 17),
                                    ),

                                    SizedBox(height: 5),

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
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 20),
                  child: FadeIn(
                    1.4,
                    500,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: ThemeColors.greenShade2,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          highlightColor: ThemeColors.greenShade2,
                          focusElevation: 0,
                          highlightElevation: 0,
                          child: Text(
                            "Assessment abschliessen",
                            style: ThemeTexts.assessmentDialogSubtitle.copyWith(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                          onPressed: () {
                            _finishAssessment();
                          },
                        ),


                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: ThemeColors.greyShade1,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                          highlightColor: ThemeColors.greenShade3,
                          focusElevation: 0,
                          highlightElevation: 0,
                          child: Text(
                            "Assessment neu starten",
                            style: ThemeTexts.assessmentDialogSubtitle.copyWith(
                                color: Colors.black87,
                                fontSize: 16.5,
                                fontWeight: FontWeight.normal),
                          ),
                          onPressed: () {
                            _restartAssessment();

                          },
                        ),

                      ],
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  //go back / continue change project
  _goToChangeProject(){
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return ChangeProject(assessmentId: widget.assessmentId);
        },
        transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return Align(
            child: SlideRight(
              0.1,
              child,
            ),
          );
        },
      ),
      (route) => false
    );
  }

  //finish the assessment
  _finishAssessment() async{
    //check if an overall_mood smiley has been selected
    if(_selectedSmiley != "") {
      final appDatabase = Provider.of<AppDatabase>(context, listen: false);
      final assessmentRepo = appDatabase.assessmentRepository;

      final assessment = await assessmentRepo.findAssessment(
          widget.assessmentId);

      final finishAssessment = Assessment(
          assessment.id, assessment.project_title, _selectedSmiley,
          assessment.date_created, DateTime.now().toString());

      assessmentRepo.updateAssessment(finishAssessment);
      //todo: popUntil (go back to main app)
      //Navigator.of(context).pushNamedAndRemoveUntil("/test", (route) => false);
    }else{
      showToast(
        "Du hast noch kein Smiley ausgew??hlt",
        context: context,
      );
    }

  }

  //restart the entire assessment
  _restartAssessment() async{
    //check if an overall_mood smiley has been selected
    if(_selectedSmiley != "") {
      final appDatabase = Provider.of<AppDatabase>(context, listen: false);
      final assessmentRepo = appDatabase.assessmentRepository;

      final assessment = await assessmentRepo.findAssessment(
          widget.assessmentId);

      final finishAssessment = Assessment(
          assessment.id, assessment.project_title, _selectedSmiley,
          assessment.date_created, DateTime.now().toString());

      assessmentRepo.updateAssessment(finishAssessment);

      Navigator.of(context).pushNamedAndRemoveUntil('/start', (Route<dynamic> route) => false);
    }else{
      showToast(
        "Du hast noch kein Smiley ausgew??hlt",
        context: context,
      );
    }

  }


}