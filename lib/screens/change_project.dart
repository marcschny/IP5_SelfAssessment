import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/bottom_navigation.dart';
import 'package:ip5_selbsteinschaetzung/components/dialogs/experience_dialog.dart';
import 'package:ip5_selbsteinschaetzung/components/dialogs/project_description_dialog.dart';
import 'package:ip5_selbsteinschaetzung/components/dialogs/project_help_dialog.dart';
import 'package:ip5_selbsteinschaetzung/components/empty_experience_card.dart';
import 'package:ip5_selbsteinschaetzung/components/experience_card.dart';
import 'package:ip5_selbsteinschaetzung/components/top_bar.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/resources/animations/slide_up_from_bottom.dart';
import 'package:ip5_selbsteinschaetzung/screens/congratulations.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';




class ChangeProject extends StatefulWidget{

  final int assessmentId;

  const ChangeProject({
    Key key,
    @required this.assessmentId,
  }) : super(key: key);

  _ChangeProjectState createState() => _ChangeProjectState();

}

class _ChangeProjectState extends State<ChangeProject>{

  String projectTitle = "";
  List<Widget> widgetList;
  int noExperiences;

  Widget headerRow(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

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
              child: Text(
                "Beschreibung",
                style: ThemeTexts.assessmentDialogSubtitle.copyWith(
                    color: Colors.black87,
                    fontSize: 16.5,
                    fontWeight: FontWeight.normal),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(.55),
                  child: Padding(
                    padding: EdgeInsets.only(top: 120),
                    child: SlideUpFromBottom(0, ProjectDescriptionDialog(assessmentId: widget.assessmentId)),
                  ),
                );
              },
            ),

            SizedBox(width: 10),

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
              child: Text(
                "Hilfestellungen",
                style: ThemeTexts.assessmentDialogSubtitle.copyWith(
                    color: Colors.black87,
                    fontSize: 16.5,
                    fontWeight: FontWeight.normal),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(.55),
                  child: Padding(
                    padding: EdgeInsets.only(top: 120),
                    child: SlideUpFromBottom(0, ProjectHelpDialog(assessmentId: widget.assessmentId)),
                  ),
                );

              },
            ),

          ],
        )
    );
  }

  @override
  void initState() {
    super.initState();
    widgetList = List();
    noExperiences = 0;
    Future.delayed(Duration.zero, _getProjectTitle);
    Future.delayed(Duration.zero, _getExperiences);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getProjectTitle() async{
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    final assessment = await assessmentRepo.getProjectTitle(widget.assessmentId);

    setState(() {
      projectTitle = assessment?.project_title != null ? assessment.project_title : "Kein Projekttitel";
    });

    print(assessment?.project_title);

  }

  _getExperiences() async{
    //initialize app db
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    widgetList.clear();

    final experiences = await assessmentRepo.getExperiencesByAssessment(widget.assessmentId);

    setState(() {
      experiences.reversed.forEach((element){
        widgetList.add(
            ExperienceCard(experience: element, editable: true)
        );
      });
      noExperiences = experiences.length;
      for(int i=0; i<10-noExperiences; i++){
        widgetList.add(
          EmptyExperienceCard()
        );
      }
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  TopBar(
                      title: "Veränderungsprojekt",
                      titleNumber: 4,
                      subtitle: projectTitle,
                      percent: 0,
                      showProgressbar: false,
                      widget: headerRow(context),
                      intro: "Halte in den nächsten Wochen möglichst oft fest, was Du gemacht hast und wie das war.\nDazu kannst Du jeweils mit dem Button \"+ Erlebnis\" eine neue Erlebniskarte erstellen. Erstelle mindestens 10 Erlebniskarten um dein Veränderungsprojekt abzuschiessen.",
                  ),

                  SizedBox(height: 12),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 94),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Erlebniskarten",
                                    style: ThemeTexts.assessmentDialogTitle,
                                    textAlign: TextAlign.left,
                                  ),

                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(width: 1.2, color: ThemeColors.greenShade1),
                                    ),
                                    color: Colors.transparent,
                                    elevation: 0,
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                                    highlightColor: ThemeColors.greenShade3,
                                    splashColor: Colors.transparent,
                                    focusElevation: 0,
                                    highlightElevation: 0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 20.5,
                                          color: ThemeColors.greenShade1,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          "Erlebnis",
                                          style: ThemeTexts.assessmentDialogSubtitle.copyWith(color: ThemeColors.greenShade1, fontSize: 16.5, fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    onPressed: (){
                                      print("open new card dialog");
                                      showDialog(
                                        context: context,
                                        barrierColor: Colors.black.withOpacity(.3),
                                        child: SlideUpFromBottom(0, ExperienceDialog(assessmentId: widget.assessmentId)),
                                      );
                                    },
                                  ),

                                ],
                              ),
                            ),

                            Container(
                              height: 170,
                              child: ListView.builder(
                                padding: EdgeInsets.only(top: 14, left: 0, bottom: 10, right: 14),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,

                                itemCount: widgetList.length,
                                itemBuilder: (context, index) {
                                  if(index == 0) return Padding(padding: EdgeInsets.only(left: 18), child: widgetList[index]);
                                  else return widgetList[index];
                                },

                              ),
                            ),



                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 22),
                              child: Text(
                                "$noExperiences/10 Erlebnisse",
                                textAlign: TextAlign.right,
                                style: ThemeTexts.assessmentDialogSubtitle.copyWith(color: ThemeColors.greenShade1, fontSize: 16.5, fontWeight: FontWeight.normal),
                              ),
                            ),

                          ]
                        ),
                      ),
                    ),
                  ),

                ],
              ),



              //bottom navigation bar
              BottomNavigation(
                showNextButton: true,
                showBackButton: false,
                nextTitle: "Auswertung",
                callbackNext: (){
                  _next(context, widget.assessmentId);
                },
                callbackBack: (){
                  _next(context, widget.assessmentId);
                },
              )

            ],
          ),
        ),
      ),
    );
  }



  //next page
  void _next(BuildContext context, int assessmentId) {
    if(noExperiences >= 10) {
    //todo: uncomment the following line and comment the line above for demonstration purposes
    //if(true){
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return Congratulations(assessmentId: assessmentId);
          },
          transitionsBuilder: (BuildContext context,
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
    }else{
      showToast(
        "Du brauchst mindestens 10 Erlebniskarten",
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