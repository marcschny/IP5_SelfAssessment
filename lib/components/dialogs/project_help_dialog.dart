import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/components/animations/fade_in.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';
import 'package:provider/provider.dart';


//this is the project help dialog used in change_project (part_4)
class ProjectHelpDialog extends StatefulWidget{

  final int assessmentId;

  const ProjectHelpDialog({Key key, @required this.assessmentId}) : super(key: key);

  _ProjectHelpDialogState createState() => _ProjectHelpDialogState();

}

class _ProjectHelpDialogState extends State<ProjectHelpDialog>{

  //define variables
  String title = "";
  String youths = "";
  String socialEducators = "";
  String family = "";

  @override
  void initState() {
    super.initState();
    getProjectTitleAndHelp();
  }

  @override
  void dispose() {
    super.dispose();
  }


  //fetch project title and help from db
  //help: contains the questions 2.5.1, 2.5.2, 2.5.3
  getProjectTitleAndHelp() async{
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    final assessment = await assessmentRepo.getProjectTitle(widget.assessmentId);
    final answerYouths = await assessmentRepo.findAnswer("2.5.1", widget.assessmentId);
    final answerSocialEducators = await assessmentRepo.findAnswer("2.5.2", widget.assessmentId);
    final answerFamily = await assessmentRepo.findAnswer("2.5.3", widget.assessmentId);

    setState(() {
      title = assessment?.project_title != null ? assessment.project_title : "Kein Projekttitel";
      youths = answerYouths?.answer != null ? answerYouths.answer : "-";
      socialEducators = answerSocialEducators?.answer != null ? answerSocialEducators.answer : "-";
      family = answerFamily?.answer != null ? answerFamily.answer : "-";
    });

  }


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        child: Stack(
            children: [
              FadeIn(
                1.04,
                500,
                Container(
                    padding: EdgeInsets.fromLTRB(18, 0, 18, 94),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height-100,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Container(
                            padding: EdgeInsets.only(top: 4, bottom: 4),
                            child: Text(
                              "Hilfestellungen",
                              style: ThemeTexts.assessmentDialogTitle,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 0, bottom: 14),
                            child: Text(
                              title,
                              style: ThemeTexts.assessmentDialogTitle.copyWith(color: Colors.black26),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 30, bottom: 14),
                            width: double.infinity,
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Jugendliche: ",
                                    style: ThemeTexts.assessmentText.copyWith(fontSize: 16.5, fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: youths+"\n\n",
                                    style: ThemeTexts.assessmentText.copyWith(fontSize: 16.5, fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text: "Sozialpädagog*innen: ",
                                    style: ThemeTexts.assessmentText.copyWith(fontSize: 16.5, fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: socialEducators+"\n\n",
                                    style: ThemeTexts.assessmentText.copyWith(fontSize: 16.5, fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text: "Familie: ",
                                    style: ThemeTexts.assessmentText.copyWith(fontSize: 16.5, fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: family,
                                    style: ThemeTexts.assessmentText.copyWith(fontSize: 16.5, fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    )
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
            ]
        ),
      ),
    );
  }




}