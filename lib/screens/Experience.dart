

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/myProjectCard.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

class Experience extends StatefulWidget{

  final int assessmentId;

  const Experience({Key key, this.assessmentId}) : super(key: key);

  _ExperienceState createState() => _ExperienceState();

}

class _ExperienceState extends State<Experience>{

  List<MyProjectCard> goodWidgetList;
  List<MyProjectCard> badWidgetList;

  @override
  void initState() {
    super.initState();
    goodWidgetList = List();
    badWidgetList = List();
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

            Container(
              padding: EdgeInsets.fromLTRB(18, 20, 18, 94),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text(
                    "Deine Erlebnisse",
                    style: ThemeTexts.assessmentTitle.copyWith(color: ThemeColors.greenShade1, fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Icon(
                        Icons.date_range_rounded,
                        size: 19,
                        color: ThemeColors.greyShade0,
                      ),
                      SizedBox(width: 3),

                      Text(
                        "22.11.2020 - 10.12.2020",
                        style: ThemeTexts.assessmentText.copyWith(color: ThemeColors.greyShade0, fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),


                  SizedBox(height: 40),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Gute Erlebnisse",
                            style: ThemeTexts.assessmentDialogTitle,
                            textAlign: TextAlign.left,
                          ),

                          Text(
                            "x/10",
                            textAlign: TextAlign.right,
                            style: ThemeTexts.assessmentDialogSubtitle.copyWith(color: ThemeColors.greenShade1, fontSize: 16.5, fontWeight: FontWeight.normal),
                          ),

                        ],
                      ),

                      Container(
                        height: 170,
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 14, left: 18, bottom: 10, right: 14),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,

                          itemCount: goodWidgetList?.length,
                          itemBuilder: (context, index) {
                            return goodWidgetList[index];
                          },

                        ),
                      ),


                    ],
                  ),


                  SizedBox(height: 20),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Weniger gute Erlebnisse",
                            style: ThemeTexts.assessmentDialogTitle,
                            textAlign: TextAlign.left,
                          ),

                          Text(
                            "x/10",
                            textAlign: TextAlign.right,
                            style: ThemeTexts.assessmentDialogSubtitle.copyWith(color: ThemeColors.greenShade1, fontSize: 16.5, fontWeight: FontWeight.normal),
                          ),

                        ],
                      ),

                      Container(
                        height: 170,
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 14, left: 18, bottom: 10, right: 14),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,

                          itemCount: badWidgetList?.length,
                          itemBuilder: (context, index) {
                            return badWidgetList[index];
                          },

                        ),
                      ),


                    ],
                  ),


                ],
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

