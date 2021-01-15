import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/components/animations/fade_in.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';
import 'package:provider/provider.dart';


class ProjectDescriptionDialog extends StatefulWidget{

  final int assessmentId;

  const ProjectDescriptionDialog({Key key, @required this.assessmentId}) : super(key: key);

  _ProjectDescriptionDialogState createState() => _ProjectDescriptionDialogState();

}

class _ProjectDescriptionDialogState extends State<ProjectDescriptionDialog>{

  String title = "";
  String description = "";

  @override
  void initState() {
    super.initState();
    getProjectTitleAndDescription();
  }

  @override
  void dispose() {
    super.dispose();
  }



  getProjectTitleAndDescription() async{
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    final assessment = await assessmentRepo.getProjectTitle(widget.assessmentId);
    final answer = await assessmentRepo.findAnswer("2.3.1", widget.assessmentId);

    setState(() {
      title = assessment?.project_title != null ? assessment.project_title : "Kein Projekttitel";
      description = answer?.answer != null ? answer.answer : "Keine Projektbeschreibung";
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
                          "Beschreibung",
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
                        child: Text(
                          description,
                          textAlign: TextAlign.start,
                          style: ThemeTexts.assessmentText.copyWith(fontSize: 16.5),
                          overflow: TextOverflow.clip,
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