import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/personDialog.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';


//Screen 1.2
class ImportantPersons extends StatefulWidget{

  const ImportantPersons({
    Key key
  }) : super(key: key);

  _ImportantPersonsState createState() => _ImportantPersonsState();

}

class _ImportantPersonsState extends State<ImportantPersons>{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final LinkedHashMap<String, int> routeArgs = ModalRoute.of(context).settings.arguments;
    //final Set<int> routeArgs = {11, 3};
    final int assessmentId = routeArgs["assessmentId"];
    final int networkId = routeArgs["networkId"];
    //print("assId hashmap: "+assessmentId.toString());

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


            //content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                TopBar(
                  title: "Wer ist mir wichtig?\nMeine Netzwerkkarte",
                  titleNumber: 1,
                  onClose: null,
                  subtitle: "Wichtige Personen",
                  percent: 0.1,
                  intro: "Wer ist für Dich in Deinem Leben ganz wichtig?  Zeichne diese wichtigen Personen ganz nah bei Dir; je weiter weg von der Mitte (und damit von Dir) Du eine Person einträgst, desto weniger wichtig ist sie aktuell in Deinem Leben.",
                ),


                Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(width: 1.2, color: ThemeColors.greenShade1),
                    ),
                    color: Colors.transparent,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
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
                          "Person hinzufügen",
                          style: ThemeTexts.assessmentDialogSubtitle.copyWith(color: ThemeColors.greenShade1, fontSize: 16.5, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    onPressed: (){
                      showDialog(
                        context: context,
                        child: PersonDialog(assessmentId: assessmentId, networkId: networkId),
                      );
                    },
                  ),
                ),


              ],
            ),

            //bottom navigation bar
            BottomNavigation(
              showNextButton: true,
              showBackButton: true,
              nextTitle: "Visualisierung",
              callbackNext: (){
              },
            ),
          ],
        ),
      ),
    );
  }



}