import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/emptyProjectCard.dart';
import 'package:ip5_selbsteinschaetzung/components/myProjectCard.dart';
import 'package:ip5_selbsteinschaetzung/components/projectCardDialog.dart';
import 'package:ip5_selbsteinschaetzung/components/projectDescriptionDialog.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/resources/SlideUpFromBottom.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';



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
  int noProjectCards;

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
                //todo: show help dialog
                print("show help dialog");

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
    noProjectCards = 0;
    Future.delayed(Duration.zero, _getProjectTitle);
    Future.delayed(Duration.zero, _getProjectCards);
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

  _getProjectCards() async{
    //initialize app db
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    widgetList.clear();

    final projectCards = await assessmentRepo.getProjectCardsByAssessment(widget.assessmentId);

    print("projectCards.length: "+projectCards.length.toString());

    setState(() {
      projectCards.reversed.forEach((element){
        widgetList.add(
          MyProjectCard(projectCard: element)
        );
      });
      noProjectCards = projectCards.length;
      for(int i=0; i<10-noProjectCards; i++){
        widgetList.add(
          EmptyProjectCard()
        );
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onClose: null,
                    subtitle: projectTitle,
                    percent: 0,
                    showProgressbar: false,
                    widget: headerRow(context),
                    intro: "Dokumentiere in den nächsten Wochen möglichst jeden Tag, was Du gemacht hast und wie das war.\nDazu kannst Du jeweils mit dem Button \"+ Neue Karte\" eine neue Karte erstellen. Erstelle mindestens 10 Karten um dein Projekt abzuschiessen",
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
                                  "Meine Karten",
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
                                        "Neue Karte",
                                        style: ThemeTexts.assessmentDialogSubtitle.copyWith(color: ThemeColors.greenShade1, fontSize: 16.5, fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  onPressed: (){
                                    print("open new card dialog");
                                    showDialog(
                                      context: context,
                                      barrierColor: Colors.black.withOpacity(.3),
                                      child: SlideUpFromBottom(0, ProjectCardDialog(assessmentId: widget.assessmentId)),
                                    );
                                  },
                                ),

                              ],
                            ),
                          ),

                          Container(
                            height: 170,
                            child: ListView.builder(
                              padding: EdgeInsets.only(top: 14, left: 18, bottom: 10, right: 14),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,

                              itemCount: widgetList.length,
                              itemBuilder: (context, index) {
                                return widgetList[index];
                              },

                            ),
                          ),



                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 22),
                            child: Text(
                              "$noProjectCards/10 Karten",
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
    );
  }



  //next page
  void _next(BuildContext context, int assessmentId) {
    //todo: validate and go to evaluation
    print("validate and go to evaluation");
  }




}