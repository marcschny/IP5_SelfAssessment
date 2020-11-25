import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/importantPersonTile.dart';
import 'package:ip5_selbsteinschaetzung/components/personDialog.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';


//Screen 1.2
class ImportantPersons extends StatefulWidget{

  const ImportantPersons({
    Key key
  }) : super(key: key);

  _ImportantPersonsState createState() => _ImportantPersonsState();

}

class _ImportantPersonsState extends State<ImportantPersons>{

  int assessmentId;
  int networkId;
  LinkedHashMap<String, int> routeArgs;

  List<ImportantPersonTile> widgetList = List();
  List<Person> personList;


  @override
  void initState() {
    super.initState();
    personList = List();

   Future.delayed(Duration.zero, _getTiles);
  }


  @override
  void dispose() {
    super.dispose();
  }

  //when popped back from dialog screen
  FutureOr onGoBack(dynamic value){
    _getTiles();
    print("FutureOr onGoBck!");
  }

  _getTiles() async{
    //initialize app db
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    //prevent widgetList from dupulicate values...
    widgetList.clear();

    //get all persons by network card
    final persons = await assessmentRepo.getAllPersonsByNetworkCard(networkId);

    //refresh personList asynchronously
    setState(() {
      personList = persons;
    });

    //refresh widget list
    personList.forEach((element){
      if(element != null){
        widgetList.add(
            ImportantPersonTile(
              id: element.id,
              name: element.name,
              icon: element.icon,
              lifeArea: element.lifeArea,
            )
        );
      }
    });

    print("widgetList.length: "+widgetList.length.toString());
    print("personList.length: "+personList.length.toString());

  }



  @override
  Widget build(BuildContext context) {

    //get passed arguments
    routeArgs = ModalRoute.of(context).settings.arguments;
    assessmentId = routeArgs["assessmentId"];
    networkId = routeArgs["networkId"];

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
                          "Person hinzufügen",
                          style: ThemeTexts.assessmentDialogSubtitle.copyWith(color: ThemeColors.greenShade1, fontSize: 16.5, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    onPressed: (){
                      showDialog(
                        context: context,
                        child: PersonDialog(assessmentId: assessmentId, networkId: networkId),
                      ).then(onGoBack);
                    },
                  ),
                ),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(18, 10, 18, 94),
                    width: MediaQuery.of(context).size.width,
                    child: widgetList.length > 0 && widgetList != null ?
                    ListView.builder(
                      itemCount: widgetList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return widgetList[index];
                      },
                    ) :
                      Container(),
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