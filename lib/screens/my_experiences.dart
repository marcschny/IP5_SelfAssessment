import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/experience_card.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


//todo: create subfolder in components for all dialogs
class MyExperiences extends StatefulWidget{

  final int assessmentId;

  const MyExperiences({Key key, this.assessmentId}) : super(key: key);

  _ExperienceState createState() => _ExperienceState();

}

class _ExperienceState extends State<MyExperiences>{

  List<ExperienceCard> goodWidgetList;
  List<ExperienceCard> badWidgetList;
  List<ExperienceCard> allWidgetList;
  int noExperiences;
  String _datesString;

  final format = DateFormat("dd.MM.yyyy");

  @override
  void initState() {
    super.initState();
    goodWidgetList = List();
    badWidgetList = List();
    allWidgetList = List();
    noExperiences = 0;
    _datesString = "";
    Future.delayed(Duration.zero, _getExperiences);
  }


  _getExperiences() async{
    //initialize app db
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;


    final positiveExperiences = await assessmentRepo.getPositiveExperiences(widget.assessmentId);
    final negativeExperiences = await assessmentRepo.getNegativeExperiences(widget.assessmentId);
    final allExperiences = await assessmentRepo.getExperiencesByAssessment(widget.assessmentId);


    setState(() {
      noExperiences = allExperiences.length;
      positiveExperiences.reversed.forEach((element) {
        goodWidgetList.add(
          ExperienceCard(experience: element, editable: false)
        );
      });
      negativeExperiences.reversed.forEach((element) {
        badWidgetList.add(
            ExperienceCard(experience: element, editable: false)
        );
      });
      allExperiences.reversed.forEach((element) {
        allWidgetList.add(
            ExperienceCard(experience: element, editable: false)
        );
      });
    });

    _setDates();

  }

  _setDates() async{
    setState(() {
      _datesString = "${format.format(DateTime.parse(allWidgetList.first.experience.date_created))} - ${format.format(DateTime.parse(allWidgetList.last.experience.date_created))}";
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

            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 94),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        "Deine Erlebnisse",
                        style: ThemeTexts.assessmentTitle.copyWith(color: ThemeColors.greenShade1, fontSize: 28),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 3),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Icon(
                            Icons.date_range_rounded,
                            size: 19,
                            color: ThemeColors.greyShade0,
                          ),
                          SizedBox(width: 3),

                          Text(
                            _datesString,
                            style: ThemeTexts.assessmentText.copyWith(color: ThemeColors.greyShade0, fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),


                    SizedBox(height: 40),

                    Column(
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
                                "Gute Erlebnisse",
                                style: ThemeTexts.assessmentDialogTitle,
                                textAlign: TextAlign.left,
                              ),

                              Text(
                                "${goodWidgetList.length}/$noExperiences",
                                textAlign: TextAlign.right,
                                style: ThemeTexts.assessmentDialogSubtitle.copyWith(color: ThemeColors.greenShade1, fontSize: 16.5, fontWeight: FontWeight.normal),
                              ),

                            ],
                          ),
                        ),

                        goodWidgetList.length > 0 ?
                        Container(
                          height: 170,
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 14, left: 0, bottom: 10, right: 0),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,

                            itemCount: goodWidgetList?.length,
                            itemBuilder: (context, index) {
                              if(index == 0) return Padding(padding: EdgeInsets.only(left: 18), child: goodWidgetList[index]);
                              else return goodWidgetList[index];
                            },

                          ),
                        ) : Container(
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Keine guten Erlebnisse",
                            style: ThemeTexts.assessmentText.copyWith(fontSize: 17, fontStyle: FontStyle.italic, color: Colors.grey),
                          ),
                        ),


                      ],
                    ),


                    SizedBox(height: 20),

                    Column(
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
                                "Weniger gute Erlebnisse",
                                style: ThemeTexts.assessmentDialogTitle,
                                textAlign: TextAlign.left,
                              ),

                              Text(
                                "${badWidgetList.length}/$noExperiences",
                                textAlign: TextAlign.right,
                                style: ThemeTexts.assessmentDialogSubtitle.copyWith(color: ThemeColors.greenShade1, fontSize: 16.5, fontWeight: FontWeight.normal),
                              ),

                            ],
                          ),
                        ),

                        badWidgetList.length > 0 ?
                        Container(
                          height: 170,
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 14, left: 0, bottom: 10, right: 0),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,

                            itemCount: badWidgetList?.length,
                            itemBuilder: (context, index) {
                              if(index == 0) return Padding(padding: EdgeInsets.only(left: 18), child: badWidgetList[index]);
                              else return badWidgetList[index];
                            },

                          ),
                        ) : Container(
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Keine weniger guten Erlebnisse",
                            style: ThemeTexts.assessmentText.copyWith(fontSize: 17, fontStyle: FontStyle.italic, color: Colors.grey),
                          ),
                        ),


                      ],
                    ),


                  ],
                ),
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
    );
  }




}

