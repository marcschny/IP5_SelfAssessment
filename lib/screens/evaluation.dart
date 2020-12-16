

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';

class Evaluation extends StatefulWidget{

  final int assessmentId;

  const Evaluation({Key key, this.assessmentId}) : super(key: key);

  _EvaluationState createState() => _EvaluationState();

}

class _EvaluationState extends State<Evaluation>{

  String projectTitle = "";
  String _selectedSmiley;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _getProjectTitle);
    _selectedSmiley = "";
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
                    onClose: null,
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
                            Padding(
                              padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Du hattest x/10 gut gelungene Erlebnisse während Deines Veränderungsprojekts.",
                                    textAlign: TextAlign.start,
                                    style: ThemeTexts.assessmentDialogTitle.copyWith(color: ThemeColors.greenShade1, fontSize: 17),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Auch wenn Du selber noch nicht zufrieden bist: Du hast viel gemacht!",
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
                                      //todo: open experience page
                                      print("open experience page");

                                    },
                                  ),

                                ],
                              ),
                            ),

                            SizedBox(height: 22),

                            Padding(
                              padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Möchtest Du am Veränderungsprojekt weiterfahren?",
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
                                          "Zum Veränderungsprojekt",
                                          style: ThemeTexts.assessmentDialogSubtitle.copyWith(
                                              color: Colors.black87,
                                              fontSize: 16.5,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      //todo: open experience page
                                      print("open experience page");

                                    },
                                  ),

                                ],
                              ),
                            ),


                            SizedBox(height: 22),

                            Padding(
                              padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Wie zufrieden bist zu insgesamt mit deinem Veränderungsprojekt?",
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
                  padding: EdgeInsets.fromLTRB(18, 10, 18, 20),
                  child: Column(
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
                          //todo: end assessment
                          print("end assessment");

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
                          //todo: restart assessment
                          print("restart assessment");

                        },
                      ),

                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }




}