import 'dart:ui';

import 'package:flutter/cupertino.dart';
//the package intl and material both have a widget called 'TextDirection'
//to avoid name errors material is imported as UI
import 'package:flutter/material.dart' as UI;
import 'package:flutter/widgets.dart';
import 'package:ip5_selbsteinschaetzung/components/experienceDialog.dart';
import 'package:ip5_selbsteinschaetzung/components/notEditableExperienceDialog.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/experience.dart';
import 'package:ip5_selbsteinschaetzung/resources/SlideUpFromBottom.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:intl/intl.dart';


class ExperienceCard extends StatelessWidget{

  final Experience experience;
  final bool editable;

  ExperienceCard({
    Key key,
    @required this.experience,
    @required this.editable
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
              textDirection: UI.TextDirection.ltr,
              children: [


                Directionality(
                  textDirection: UI.TextDirection.ltr,
                  child: Text(
                    format.format(DateTime.parse(experience.date_created)).toString(),
                    style: ThemeTexts.assessmentNavigationNext.copyWith(color: Color.fromRGBO(105, 105, 105, 1)),
                    overflow: TextOverflow.fade,
                  ),
                ),

                Directionality(
                  textDirection: UI.TextDirection.ltr,
                  child: Text(
                    experience.description,
                    style: ThemeTexts.assessmentText.copyWith(fontSize: 16),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                SizedBox(height: 5),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                      color: UI.Colors.transparent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: UI.Colors.black45.withOpacity(.2),
                            spreadRadius: -6,
                            blurRadius: 12,
                            offset: Offset(0,4)
                        )
                      ],
                      image: DecorationImage(
                        image: AssetImage("assets/smileys/${experience.mood}.png"),
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
        if(editable) {
          UI.showDialog(
            context: context,
            barrierColor: UI.Colors.black.withOpacity(.3),
            child: SlideUpFromBottom(0, ExperienceDialog(
                assessmentId: experience.assessment_id,
                experience: experience)),
          );
        }else{
          UI.showDialog(
            context: context,
            barrierColor: UI.Colors.black.withOpacity(.3),
            child: SlideUpFromBottom(0, NotEditableExperienceDialog(
                assessmentId: experience.assessment_id,
                experience: experience)),
          );
        }
      },
    );
  }


}