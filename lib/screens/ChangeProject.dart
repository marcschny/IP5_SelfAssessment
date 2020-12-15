

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

class ChangeProject extends StatefulWidget{

  final int assessmentId;
  final int visualizationId;

  const ChangeProject({
    Key key,
    @required this.assessmentId,
    @required this.visualizationId
  }) : super(key: key);

  _ChangeProjectState createState() => _ChangeProjectState();

}

class _ChangeProjectState extends State<ChangeProject>{


  final headerRow =
  Container(
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
            style: ThemeTexts.assessmentDialogSubtitle.copyWith(color: Colors.black87, fontSize: 16.5, fontWeight: FontWeight.normal),
            ),
          onPressed: (){
            //todo: show description dialog
            print("show description dialog");
            /*showDialog(
              context: context,
              barrierColor: Colors.black.withOpacity(.3),
              child: SlideUpFromBottom(0, PersonDialog(assessmentId: widget.assessmentId, visualizationId: widget.visualizationId)),
            ).then(onGoBack);*/
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
            style: ThemeTexts.assessmentDialogSubtitle.copyWith(color: Colors.black87, fontSize: 16.5, fontWeight: FontWeight.normal),
            ),
          onPressed: (){
            //todo: show help dialog
            print("show help dialog");
            /*showDialog(
              context: context,
              barrierColor: Colors.black.withOpacity(.3),
              child: SlideUpFromBottom(0, PersonDialog(assessmentId: widget.assessmentId, visualizationId: widget.visualizationId)),
            ).then(onGoBack);*/
          },
        ),

      ],
    )
  );


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
                    subtitle: "Titel meines Projekts",
                    percent: 0,
                    showProgressbar: false,
                    widget: headerRow,
                    intro: "Dokumentiere in den nächsten Wochen möglichst jeden Tag, was Du gemacht hast und wie das war.\nDazu kannst Du jeweils mit dem Button \"+ Neue Karte\" eine neue Karte erstellen. Erstelle mindestens 10 Karten um dein Projekt abzuschiessen",
                )


              ],
            )

          ],
        ),
      ),
    );
  }




}