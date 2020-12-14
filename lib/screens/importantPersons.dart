import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/importantPersonTile.dart';
import 'package:ip5_selbsteinschaetzung/components/personDialog.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';
import 'package:ip5_selbsteinschaetzung/resources/FadeIn.dart';
import 'package:ip5_selbsteinschaetzung/resources/SlideUpFromBottom.dart';
import 'package:ip5_selbsteinschaetzung/screens/MyVisualization.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';


//Screen 1.2
class ImportantPersons extends StatefulWidget{

  final int assessmentId;
  final int visualizationId;


  const ImportantPersons({
    Key key,
    @required this.assessmentId,
    @required this.visualizationId
  }) : super(key: key);

  _ImportantPersonsState createState() => _ImportantPersonsState();

}

class _ImportantPersonsState extends State<ImportantPersons>{


  List<ImportantPersonTile> widgetList;
  List<Person> personList;


  @override
  void initState() {
    super.initState();
    personList = List();
    widgetList = List();
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

  //get person tiles from db
  _getTiles() async{
    //initialize app db
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    //prevent widgetList from duplicate values...
    widgetList.clear();

    //get all persons by visualization
    final persons = await assessmentRepo.getAllPersonsByVisualization(widget.visualizationId);

    //refresh personList asynchronously
    setState(() {
      personList = persons;
    });

    //refresh widget list
    personList.forEach((element){
      if(element != null){
        widgetList.add(
            ImportantPersonTile(
              person: element,
            )
        );
      }
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


            //content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                TopBar(
                  title: "Wer ist mir wichtig?\nMeine wichtigen Personen",
                  titleNumber: 1,
                  onClose: null,
                  subtitle: "Wichtige Personen",
                  percent: 0.1,
                  intro: "Hier kannst Du wichtige Personen aus deinem Leben hinzufügen und bestimmen, wie Du zu dieser Person stehst. Je weniger Wichtig Du eine Person einträgst, desto weiter weg erscheint diese auf der Visualisierung.",
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
                          barrierColor: Colors.black.withOpacity(.3),
                          child: SlideUpFromBottom(0, PersonDialog(assessmentId: widget.assessmentId, visualizationId: widget.visualizationId)),
                        ).then(onGoBack);
                      },
                    ),
                  ),

                Expanded(
                  child: FadeIn(
                    1,
                    500,
                    Container(
                      padding: EdgeInsets.fromLTRB(18, 10, 18, 94),
                      width: MediaQuery.of(context).size.width,
                      child: widgetList.length > 0 && widgetList != null ?
                      ListView.builder(
                        itemCount: widgetList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          return GestureDetector(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                widgetList[index],
                                widgetList.length-1 != index ? Divider(color: Colors.black26) : Container(),
                              ],
                            ),
                            onTap: (){
                              showDialog(
                                context: context,
                                child: SlideUpFromBottom(
                                  0,
                                  PersonDialog(
                                    assessmentId: widget.assessmentId,
                                    visualizationId: widget.visualizationId,
                                    person: widgetList[index].person,
                                  ),
                                ),
                              ).then(onGoBack);
                            },
                          );
                        },
                      ) :
                        Container(),
                    ),
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
                _next(context, widget.assessmentId, widget.visualizationId);
              },
              callbackBack: (){
                Navigator.of(context).pop(true);
              },
            ),
          ],
        ),
      ),
    );
  }

  //next page
  void _next(BuildContext context, int assessmentId, int visualizationId) {
    if (personList.length >= 2) {
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 300),
          pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return MyVisualization(assessmentId: assessmentId, visualizationId: visualizationId);
          },
          transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return Align(
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      );
    } else {
      showToast(
        "Füge mindestens zwei Personen hinzu",
        context: context,
        textAlign: TextAlign.center,
        textStyle: ThemeTexts.toastText,
        textPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        position: ToastPosition.bottom,
        backgroundColor: Color.fromRGBO(70, 70, 70, .7),
        duration: Duration(milliseconds: 2500),
      );
    }
  }

}