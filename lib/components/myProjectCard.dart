

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/projectCardDialog.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/projectcard.dart';
import 'package:ip5_selbsteinschaetzung/resources/SlideUpFromBottom.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:intl/intl.dart';

class MyProjectCard extends StatelessWidget{

  final ProjectCard projectCard;

  MyProjectCard({
    Key key,
    @required this.projectCard
  }) : super(key: key);

  final format = DateFormat("dd.MM.yyyy");


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 110,
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ThemeColors.greenShade3, ThemeColors.greenShade2.withOpacity(.85)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.25, 1.0],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  format.format(DateTime.parse(projectCard.date_created)).toString(),
                  style: ThemeTexts.assessmentNavigationNext.copyWith(color: Color.fromRGBO(105, 105, 105, 1)),
                  overflow: TextOverflow.fade,
                ),

                Text(
                  projectCard.description,
                  style: ThemeTexts.assessmentText.copyWith(fontSize: 16),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 5),
                Container(
                  width: 36,
                  height: 36,
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
                        image: AssetImage("assets/smileys/${projectCard.mood}.png"),
                        fit: BoxFit.cover,
                      )
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      onTap: (){
        print("open project card: "+projectCard.description);
        showDialog(
          context: context,
          barrierColor: Colors.black.withOpacity(.3),
          child: SlideUpFromBottom(0, ProjectCardDialog(assessmentId: projectCard.assessment_id, projectCard: projectCard)),
        );
      },
    );
  }


}